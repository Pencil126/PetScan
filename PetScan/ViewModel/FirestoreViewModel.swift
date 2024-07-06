//
//  FirestoreViewModel.swift
//  PetScan
//
//  Created by 廖清筆 on 2024/6/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class FirestoreViewModel: ObservableObject {
    @Published var pets: [PetInfo] = []
    @Published var currentPet: PetInfo?
    @Published var currentPetObject: String = "dKPmxyl4fr3k9d5hCFoW" //Why 進入新頁面會不見
    
    @Published var totalFoodValue: Double = 0.0
    @Published var totalDrinkValue: Int = 0
    
    private var db = Firestore.firestore()
    
    init() {
        fetchAllPet()
    }
    
    func fetchAllPet() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("No user is currently logged in.")
            return
        }
        
        db.collection("UsersPet").whereField("userID", isEqualTo: userId).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            let petID = querySnapshot?.documents.compactMap { $0["petID"] as? Int } ?? []
            
            print(petID)
            if !petID.isEmpty {
                print(petID[0])
                self.fetchPetInfo(by: petID)
                print("RESULT: \(self.pets)")
            } else {
                print("Not Found")
            }
        }
    }
    
    func fetchPetInfo(by petID: [Int]) {
        db.collection("PetInfo").whereField("petID", in: petID).addSnapshotListener { [self] (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents returned or querySnapshot is nil")
                return
            }
            
            if documents.isEmpty {
                print("Documents array is empty.")
            } else {
                print("\(documents.count) documents found.")
            }
            
            self.pets = documents.compactMap { (queryDocumentSnapshot) -> PetInfo? in
                print("Mapping document: \(queryDocumentSnapshot.documentID)")
                self.currentPetObject = queryDocumentSnapshot.documentID
                let data = queryDocumentSnapshot.data()
                // Using the helper functions to convert Firestore data into app's data structures
                let petID = data["petID"] as? Int
                let name = data["name"] as? String
                let type = data["type"] as? String
                let weight = data["weight"] as? Double
                let imageURL = data["imageURL"] as? String
                let foodData = data["food"] as? [[String: Any]] ?? []
                let drinkData = data["drink"] as? [[String: Any]] ?? []
                
                let food = fetchFood(foodData)
                let drink = fetchDrink(drinkData)
                
                print("petID: \(String(describing: petID)), name: \(String(describing: name)), type: \(String(describing: type)), weight: \(String(describing: weight)), img: \(String(describing: imageURL)), food: \(food), drink: \(drink)")
                return PetInfo(name: name ?? "", petID: petID ?? 1, type: type ?? "", weight: weight ?? 0.0, imageURL: imageURL ?? "", food: food, drink: drink)
            }
            if !self.pets.isEmpty {
                self.setCurrentPet(pet: self.pets[0])
//                print("\(self.currentPet)")
            }
        }
    }
    
    func fetchFood(_ foodData: [[String: Any]]) -> [Food] {
        return foodData.compactMap { item in
                let timestamp = (item["time"] as? Timestamp)?.dateValue() ?? Date()
                let name = item["name"] as? String ?? ""
                let value = item["value"] as? Double ?? 0.0
                return Food(timestamp: timestamp, name: name, value: value)
            }
    }
    
    func fetchDrink(_ drinkData: [[String: Any]]) -> [Drink] {
        return drinkData.compactMap { item in
            let timestamp = (item["time"] as? Timestamp)?.dateValue() ?? Date()
            let value = item["value"] as? Double ?? 0.0
            return Drink(timestamp: timestamp, value: value)
        }
    }
    
    func setCurrentPet(pet: PetInfo) {
        self.currentPet = pet
    }
    
    func currentPetName() -> String {
        if let name = currentPet?.name {
            return name  // 轉換為整數以去除小數點，然後轉換為字符串
        } else {
            return "Loading"
        }
    }
    
    func currentPetType() -> String {
        if let type = currentPet?.type {
            return type  // 轉換為整數以去除小數點，然後轉換為字符串
        } else {
            return "Loading"
        }
    }
    
    func currentPetWeight() -> String {
        if let weight = currentPet?.weight {
            return (String(weight))  // 轉換為整數以去除小數點，然後轉換為字符串
        } else {
            return "loading"
        }
    }
    
    func currentPetImageURL() -> URL? {
        if let pet = currentPet {
            print("URL is valid: \(pet.imageURL)")
            return URL(string: pet.imageURL)
        } else {
            return nil
        }
    }

    func addFoodRecord(date: Date, name: String, value: Double) {
        let ref = db.collection("PetInfo").document(currentPetObject)
        let newRecord: [String: Any] = [
                "time": Timestamp(date: date),
                "name": name,
                "value": value
            ]
        
        ref.updateData([
            "food": FieldValue.arrayUnion([newRecord])
        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func todayFoodValue() {
        let ref = db.collection("PetInfo").document(currentPetObject).collection("food")
        let todayGMT = Calendar.current.startOfDay(for: Date())
        let tomorrowGMT = Calendar.current.date(byAdding: .day, value: 1, to: todayGMT)!
        let today = Calendar.current.date(byAdding: .hour, value: 8, to: todayGMT)!
        let tomorrow = Calendar.current.date(byAdding: .hour, value: 8, to: tomorrowGMT)!
        print("Today: \(today), Tomorrow: \(tomorrow)")
        let limit = 300.0
        ref.whereField("time", isGreaterThanOrEqualTo: today).whereField("time", isLessThan: tomorrow).getDocuments { (snapshot, error) in
            if let error = error {
                print("todayFoodValue Error getting documents: \(error)")
            } else if let snapshot = snapshot {
                var totalValue = snapshot.documents.reduce(0) { (sum, document) -> Double in
                    let data = document.data()
                    if let entries = data["entries"] as? [[String: Any]] {
                        // 累加所有符合今天日期的 value
                        return entries.reduce(sum) { (subSum, entry) -> Double in
                            if let timestamp = entry["time"] as? Timestamp,
                               let value = entry["value"] as? Double,
                               Calendar.current.isDate(timestamp.dateValue(), inSameDayAs: today) {
                                return subSum + value
                            }
                            return subSum
                        }
                    }
                    return sum
                }
                print("Total value for today is: \(totalValue)")
                totalValue = limit - totalValue
                DispatchQueue.main.async {
                    self.totalFoodValue = totalValue
                }
            }
        }
    }
    
    func addDrinkRecord(date: Date, value: Int) {
        let ref = db.collection("PetInfo").document(currentPetObject)
        let newRecord: [String: Any] = [
                "time": Timestamp(date: date),
                "value": value
            ]
        
        ref.updateData([
            "drink": FieldValue.arrayUnion([newRecord])
        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
//    func todayDrinkValue() {
//        let ref = db.collection("PetInfo").document(currentPetObject)
//        let today = Calendar.current.startOfDay(for: Date())
//        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
//        let today = Calendar.current.date(byAdding: .hour, value: 8, to: todayGMT)!
//        let tomorrow = Calendar.current.date(byAdding: .hour, value: 8, to: tomorrowGMT)!
//        let todayTimestamp = Timestamp(date: today)
//        let tomorrowTimestamp = Timestamp(date: tomorrow)
//        let limit = 385
//        .whereField("time", isLessThanOrEqualTo: today).whereField("time", isLessThan: tomorrow)
//        print("Today: \(today), Tomorrow: \(tomorrow)")
//        print("Query range: \(todayTimestamp) to \(tomorrowTimestamp)")
//        let drinkData = data["drink"] as? [[String: Any]] ?? []
//        let drink = fetchDrink(drinkData)
//        ref.getDocuments { (snapshot, error) in
//            if let error = error {
//                print("todayDrinkValue Error getting documents: \(error)")
//            } else if let snapshot = snapshot {
//                print("Documents fetched successfully, Number of documents: \(snapshot.documents.count)")
//                var totalValue = snapshot.documents.reduce(0) { (sum, document) -> Int in
//                    let data = document.data()
//                    if let entries = data["entries"] as? [[String: Any]] {
//                        // 累加所有符合今天日期的 value
//                        return entries.reduce(sum) { (subSum, entry) -> Int in
//                            if let timestamp = entry["time"] as? Timestamp,
//                               let value = entry["value"] as? Int,
//                               Calendar.current.isDate(timestamp.dateValue(), inSameDayAs: today) {
//                                return subSum + value
//                            }
//                            return subSum
//                        }
//                    }
//                    return sum
//                }
//                print("Total value for today is: \(totalValue)")
//                totalValue = limit - totalValue
//                DispatchQueue.main.async {
//                    self.totalDrinkValue = totalValue
//                }
//            }
//        }
//    }
}
