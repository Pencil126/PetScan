//
//  FoodAndDrinkView.swift
//  PetScan
//
//  Created by 蔡承曄 on 2024/6/19.
//

import SwiftUI

struct FoodAndDrinkView: View {
    let themeColor: Color = Color(red: 149/255, green: 172/255, blue: 175/255)
    let backgroundColor: Color = Color(red: 237/255, green: 237/255, blue: 237/255)
    @StateObject var viewModel = FirestoreViewModel()
    @State var date = Date()
    @State var amountOfWater: String = ""
    @State var drinkOrFood: String = "drink"
    @State var nameOfFood: String = ""
    @State var amountOfFood: String = ""
    @State var todayRemainFood: Double = 300
    @State var todayRemainDrink: Int = 500
    
    var body: some View {
        NavigationStack{
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                themeColor
                    .frame(height: 710)
                
                VStack {
                    Spacer()
                        .frame(height: 25)
                    // 寵物資料
                    VStack(spacing: 0){
                        
                        drinkOrFoodSelectionButtons
                        
                        Form{
                            Section{
                                DatePicker("日期", selection: $date, displayedComponents: .date)
                                    
                            }
                            .frame(height: 30)
                            Section{
                                DatePicker("時間", selection: $date, displayedComponents: .hourAndMinute)
                                    
                            }
                            .frame(height: 30)
                            
                            if drinkOrFood == "drink"{
                                Section {
                                    TextField("喝水量", text: $amountOfWater)
                                }
                                .frame(height: 30)
                            }
                            else if drinkOrFood == "food"{
                                Section {
                                    Picker(selection: $nameOfFood) {
                                        Text("食物")
                                        Text("某食物")
                                    } label: {
                                        Text("食物名稱")
                                            .foregroundStyle(themeColor.opacity(0.5))
                                    }
                                }
                                
                                Section {
                                    TextField("克數", text: $amountOfFood)
                                        .keyboardType(.decimalPad)
                                }
                            }
                            
                            
                        }
                        .listSectionSpacing(15)
                        .frame(width: 385,height: drinkOrFood == "drink" ? 210 : 270)
                        .scrollContentBackground(.hidden)
                        .scrollDisabled(true)
                        
                        Button{
                            if drinkOrFood == "drink" {
                                viewModel.addDrinkRecord(date: date, value: Int(amountOfWater) ?? 0)
                                todayRemainDrink -= Int(amountOfWater) ?? 0
                            } else if drinkOrFood == "food" {
                                viewModel.addFoodRecord(date: date, name: nameOfFood, value: Double(amountOfFood) ?? 0)
                            }
                        }label: {
                            Text("+ 新增")
                                .foregroundStyle(.white)
                                .frame(width: 350,height: 65)
                                .font(.system(size: 24))
                                .background(Color(red: 103/255, green: 118/255, blue: 121/255))
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                                .onAppear{
                                    viewModel.todayFoodValue()
//                                    viewModel.todayDrinkValue()
                                }
                        }
                        
                        if drinkOrFood == "drink"{
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 350,height: 193)
                                    .foregroundStyle(backgroundColor)
                                VStack (spacing: 0){
                                    VStack(spacing: 0) {
                                        Text("距離達標還差")
                                            .font(.system(size: 24))
                                            .foregroundStyle(Color(red: 103/255, green: 118/255, blue: 121/255))
                                        
                                        HStack{
                                            Text("\(todayRemainDrink)")
                                                .font(.system(size: 60))
                                                .fontWeight(.black)
                                                .foregroundStyle(Color(red: 207/255, green: 116/255, blue: 65/255))
//                                                .onAppear{
//                                                    viewModel.todayDrinkValue()
//                                                }
                                            
                                            Text("ml")
                                                .font(.system(size: 20))
                                                .foregroundStyle(Color(red: 103/255, green: 118/255, blue: 121/255))
                                        }
                                    }
                                    VStack(alignment: .trailing){
                                        HStack {
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(width: 312*((500-Double(todayRemainDrink))/500), height: 35)
                                            .foregroundStyle(Color(red: 103/255, green: 118/255, blue: 121/255))
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(width: 312*(Double(todayRemainDrink)/500), height: 35)
                                            .foregroundStyle(.white)
                                        }
                                        Text("一天需要喝水量為385-770ml")
                                            .font(.system(size: 16))
                                            .foregroundStyle(Color(red: 103/255, green: 118/255, blue: 121/255))
                                            .padding(.horizontal,10)
                                    }
                                }
                            }
                            .padding(EdgeInsets(top: 50, leading: 0, bottom: 20, trailing: 0))
                        }
                        else if drinkOrFood == "food"{
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 350,height: 120)
                                    .foregroundStyle(backgroundColor)
                                VStack {
                                    VStack(spacing: 0) {
                                        Text("距離達標還差")
                                            .font(.system(size: 24))
                                            .foregroundStyle(Color(red: 103/255, green: 118/255, blue: 121/255))
                                        
                                        HStack{
                                            Text("\(todayRemainFood, specifier: "%.1f")")
                                                .font(.system(size: 60))
                                                .fontWeight(.black)
                                                .foregroundStyle(Color(red: 207/255, green: 116/255, blue: 65/255))
                                                .onAppear{
                                                    viewModel.todayFoodValue()
                                                }
                                            
                                            Text("公克")
                                                .font(.system(size: 20))
                                                .foregroundStyle(Color(red: 103/255, green: 118/255, blue: 121/255))
                                        }
                                    }
                                }
                            }
                            .padding(EdgeInsets(top: 30, leading: 0, bottom: 20, trailing: 0))
                        }
                        
                        NavigationLink{
                            DrinkRecordView()
                        }label: {
                            Text("歷史紀錄")
                                .foregroundStyle(.white)
                                .frame(width: 350,height: 65)
                                .font(.system(size: 24))
                                .background(Color(red: 103/255, green: 118/255, blue: 121/255))
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                        }
                        
                        
                        
                    }
                    
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("食物與喝水")
                        .font(.system(size: 24))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var drinkOrFoodSelectionButtons: some View {
        HStack(spacing: 0) {
            Button {
                drinkOrFood = "drink"
            } label: {
                ZStack {
                    UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 10, bottomLeading: 10))
                        .frame(width: 175, height: 37)
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
                        .frame(width: 175, height: 37)
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
}

#Preview{
    TabBarView(tabViewSelection: 1)
}
