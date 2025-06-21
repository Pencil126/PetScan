//
//  DrinkRecordView.swift
//  PetScan
//
//  Created by 蔡承曄 on 2024/7/5.
//

import SwiftUI
import Charts
import FirebaseFirestore

struct DrinkRecord: Identifiable {
    var id = UUID()
    var time: String
    var value: Int
    var timestamp: Date?
    var isAnimated: Bool = false
    
    init(id: UUID = UUID(), time: String, value: Int, timestamp: Date? = nil, isAnimated: Bool) {
        self.id = id
        self.time = time
        self.value = value
        self.timestamp = timestamp
        self.isAnimated = isAnimated
    }
    
    init?(from dictionary: [String: Any]) {
        guard let value = dictionary["value"] as? Int else { return nil }

        if let timestamp = dictionary["time"] as? Timestamp {
            let date = timestamp.dateValue()
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd"
            self.time = formatter.string(from: date)
            self.timestamp = date
        } else {
            return nil
        }

        self.value = value
    }
}

struct DrinkRecordView: View {
    let themeColor: Color = Color(red: 149/255, green: 172/255, blue: 175/255)
    let backgroundColor: Color = Color(red: 237/255, green: 237/255, blue: 237/255)
    let selectedColor: Color = Color(red: 103/255, green: 118/255, blue: 121/255)
    
    @State var drinkOrFood: String = "drink"
    @State private var averageValue: Int = 0
    @Binding var drinkRecords : [DrinkRecord]
    @State private var isAnimated: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                themeColor
                VStack {
                    drinkOrFoodSelectionButtons
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color(red: 226/255, green: 233/255, blue: 233/255))
                            .frame(width: 350,height: 350)
                        VStack{
                            VStack {
                                Text("平均每日飲水量")
                                    .font(.system(size: 20))
                                    .foregroundColor(selectedColor)
                                
                                HStack {
                                    Text(String(averageValue))
                                        .font(.system(size: 60))
                                        .fontWeight(.black)
                                        .foregroundStyle(Color(red: 207/255, green: 116/255, blue: 65/255))
                                    
                                    Text("ml")
                                        .font(.system(size: 20))
                                        .foregroundColor(selectedColor)
                                }
                            }
                            .padding()
                            
                            ChartView(drinkRecords: $drinkRecords)
                                .frame(height: 200)
                                .padding(.horizontal)
                                .onAppear {
                                    calculateAverage()
                                }
                        }
                    }
                    .padding(4)
                    
                    
                    // Drink Status
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color(red: 226/255, green: 233/255, blue: 233/255))
                            .frame(width: 350,height: 100)
                        HStack {
                            Text("近期喝水量狀況")
                                .font(.system(size: 20))
                                .foregroundColor(selectedColor)
                            
                            Text("良好")
                                .font(.system(size: 40))
                                .foregroundColor(.green)
                        }
                    }
                    .padding(4)
                    
                    
                    // Add Record Button
                    NavigationLink{
                        FoodAndDrinkView()
                    }label: {
                        Text("新增紀錄")
                            .foregroundStyle(.white)
                            .frame(width: 350,height: 65)
                            .font(.system(size: 24))
                            .background(selectedColor)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
                    .padding(4)
                    
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("食物與喝水量歷史紀錄")
                        .font(.system(size: 24))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                animateChart()
            })
        }
    }
    
    func animateChart(){
        guard !isAnimated else { return }
        isAnimated = true
        
        $drinkRecords.enumerated().forEach{index , element in
            let delay = Double(index) * 0.2
            DispatchQueue.main.asyncAfter(deadline: .now() + delay){
                withAnimation(.easeInOut(duration: 10)){
                    element.wrappedValue.isAnimated = true
                }
            }
        }
    }
    
    
    private func calculateAverage() {
        guard !drinkRecords.isEmpty else {
            averageValue = 0
            return
        }
        
        let total = drinkRecords.reduce(0) { $0 + $1.value }
        let average = Double(total) / Double(drinkRecords.count)
        
        averageValue = Int(average.rounded())
    }
    
    private var drinkOrFoodSelectionButtons: some View {
        HStack(spacing: 0) {
            Button {
                drinkOrFood = "drink"
            } label: {
                ZStack {
                    UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 10, bottomLeading: 10))
                        .frame(width: 175.5, height: 37)
                        .foregroundStyle(drinkOrFood == "drink" ? Color(red: 103/255, green: 118/255, blue: 121/255) : .white)
                    HStack{
                        Text("喝水量")
                            .font(.system(size: 20))
                            .frame(width: 70,alignment: .leading)
                            .foregroundStyle(drinkOrFood == "drink" ? .white : Color(red: 103/255, green: 118/255, blue: 121/255))
                        Spacer()
                            .frame(width: 50)
                    }
                }
            }
            
            Button {
                drinkOrFood = "food"
            } label: {
                ZStack {
                    UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(bottomTrailing: 10, topTrailing: 10))
                        .frame(width: 175.5, height: 37)
                        .foregroundStyle(drinkOrFood == "food" ? Color(red: 103/255, green: 118/255, blue: 121/255) : .white)
                    HStack{
                        Text("食物")
                            .font(.system(size: 20))
                            .frame(width: 70,alignment: .leading)
                            .foregroundStyle(drinkOrFood == "food" ? .white : Color(red: 103/255, green: 118/255, blue: 121/255))
                        Spacer()
                            .frame(width: 70)
                    }
                }
            }
        }
    }
    
    
    struct ChartView: View {
        let themeColor: Color = Color(red: 149/255, green: 172/255, blue: 175/255)
        let backgroundColor: Color = Color(red: 237/255, green: 237/255, blue: 237/255)
        let selectedColor: Color = Color(red: 103/255, green: 118/255, blue: 121/255)
        @Binding var drinkRecords: [DrinkRecord]
        
        
        
        var body: some View {
            Chart {
                
                ForEach(drinkRecords) { record in
                    BarMark(
                        x: .value("Day", record.time),
                        y: .value("Drinks", record.isAnimated ? Double(record.value) : 0)
                    )
                }
                
            }
            .foregroundStyle(selectedColor)
            .chartYScale(domain: 0...800)
            .frame(width: 300,height: 200)
        }
        
    }
}
#Preview {
    TabBarView(tabViewSelection: 4)
}
