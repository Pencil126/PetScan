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
    @State var date = Date()
    @State var amountOfWater: String = ""
    @State var drinkOrFood: String = "drink"
    @State var nameOfFood: String = ""
    @State var amountOfFood: String = ""
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            themeColor
                .frame(height: 650)
            
            VStack {
                Text("食物與喝水")
                    .font(.system(size: 24))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                
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
                            }
                        }
                        
                        
                    }
                    .listSectionSpacing(15)
                    .frame(height: drinkOrFood == "drink" ? 210 : 270)
                    .scrollContentBackground(.hidden)
                    .scrollDisabled(true)
                    
                    Button{
                        //action
                    }label: {
                        Text("+ 新增")
                            .foregroundStyle(.white)
                            .frame(width: 362,height: 65)
                            .font(.system(size: 24))
                            .background(Color(red: 103/255, green: 118/255, blue: 121/255))
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
                    
                    if drinkOrFood == "drink"{
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 359,height: 193)
                                .foregroundStyle(backgroundColor)
                            VStack {
                                HStack(spacing: 0) {
                                    Text("距離達標還差")
                                        .font(.system(size: 24))
                                        .foregroundStyle(Color(red: 103/255, green: 118/255, blue: 121/255))
                                        .frame(width: 127, height: 80,alignment: .bottom)
                                    
                                    Text("130")
                                        .font(.system(size: 64))
                                        .fontWeight(.black)
                                        .foregroundStyle(Color(red: 207/255, green: 116/255, blue: 65/255))
                                        .frame(height: 100,alignment: .bottom)
                                    
                                    Text("ml")
                                        .font(.system(size: 32))
                                        .foregroundStyle(Color(red: 103/255, green: 118/255, blue: 121/255))
                                        .frame(height: 80,alignment: .bottom)
                                }
                                VStack(alignment: .trailing){
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 312,height: 35)
                                        .foregroundStyle(.white)
                                    Text("一天需要喝水量為385-770ml")
                                        .font(.system(size: 16))
                                        .foregroundStyle(Color(red: 103/255, green: 118/255, blue: 121/255))
                                }
                                .padding(.bottom,20)
                            }
                        }
                        .padding(EdgeInsets(top: 30, leading: 0, bottom: 20, trailing: 0))
                    }
                    else if drinkOrFood == "food"{
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 359,height: 120)
                                .foregroundStyle(backgroundColor)
                            VStack {
                                HStack(spacing: 0) {
                                    Text("距離達標還差")
                                        .font(.system(size: 24))
                                        .foregroundStyle(Color(red: 103/255, green: 118/255, blue: 121/255))
                                        .frame(width: 127, height: 80,alignment: .bottom)
                                    
                                    Text("50")
                                        .font(.system(size: 64))
                                        .fontWeight(.black)
                                        .foregroundStyle(Color(red: 207/255, green: 116/255, blue: 65/255))
                                        .frame(height: 110,alignment: .bottom)
                                    
                                    Text("大卡")
                                        .font(.system(size: 24))
                                        .foregroundStyle(Color(red: 103/255, green: 118/255, blue: 121/255))
                                        .frame(height: 80,alignment: .bottom)
                                }
                            }
                            .padding(.bottom,20)
                        }
                        .padding(EdgeInsets(top: 30, leading: 0, bottom: 20, trailing: 0))
                    }
                    
                    Button{
                        //action
                    }label: {
                        Text("歷史紀錄")
                            .foregroundStyle(.white)
                            .frame(width: 362,height: 65)
                            .font(.system(size: 24))
                            .background(Color(red: 103/255, green: 118/255, blue: 121/255))
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
                    
                    
                    
                }
                
                Spacer()
            }
        }
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
}

#Preview {
    TabBarView()
}
