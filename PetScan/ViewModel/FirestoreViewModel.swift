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
        db.collection("PetInfo").whereField("petID", in: petID).addSnapshotListener { (querySnapshot, error) in
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
                let data = queryDocumentSnapshot.data()
                // Using the helper functions to convert Firestore data into app's data structures
                let petID = data["petID"] as? Int
                let name = data["name"] as? String
                let type = data["type"] as? String
                let weight = data["weight"] as? Double
                let imageURL = data["imageURL"] as? String
                let food = (data["food"] as? [[String: Any]])?.map { Food(timestamp: $0["timestamp"] as? Date ?? Date(), value: $0["value"] as? Double ?? 0.0) } ?? []
                let drink = (data["drink"] as? [[String: Any]])?.map { Drink(timestamp: $0["timestamp"] as? Date ?? Date(), value: $0["value"] as? Double ?? 0.0) } ?? []
                
                print("petID: \(String(describing: petID)), name: \(String(describing: name)), type: \(String(describing: type)), weight: \(String(describing: weight)), img: \(String(describing: imageURL)), food: \(food), drink: \(drink)")
                return PetInfo(name: name ?? "", petID: petID ?? 1, type: type ?? "", weight: weight ?? 0.0, imageURL: imageURL ?? "", food: food, drink: drink)
            }
            if !self.pets.isEmpty {
                self.setCurrentPet(pet: self.pets[0])
//                print("\(self.currentPet)")
            }
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

}
