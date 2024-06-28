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
    @State var weekOrDay: String = "week"
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
                    .padding(.top, 10)
                
                // 寵物資料
                VStack(spacing: 5) {
                    Form{
                        Section(header: Text("喝水量").font(.system(size: 20)).frame(width: 351, alignment: .leading).foregroundStyle(.white)){
                            DatePicker("日期", selection: $date, displayedComponents: .date)
                                
                        }
                        .frame(height: 30)
                        Section{
                            DatePicker("時間", selection: $date, displayedComponents: .hourAndMinute)
                                
                        }
                        .frame(height: 30)
                        
                        Section {
                            TextField("喝水量", text: $amountOfWater)
                        }
                        .frame(height: 30)
                        
                    }
                    .listSectionSpacing(15)
                    .frame(height: 225)
                    .scrollContentBackground(.hidden)
                    .scrollDisabled(true)
                    
                    weekOrDaySelectionButtons
                    
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 351, height: 215)
                        .padding(EdgeInsets(top: 6, leading: 0, bottom: 0, trailing: 0))
                    
                    Form {
                        Section(header: Text("食物紀錄").font(.system(size: 20)).frame(width: 351, alignment: .leading).foregroundStyle(.white)) {
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
                    .listSectionSpacing(15)
                    .scrollContentBackground(.hidden)
                    .scrollDisabled(true)
                }
                
                Spacer()
            }
        }
    }
    
    private var weekOrDaySelectionButtons: some View {
        HStack(spacing: 0) {
            Button {
                weekOrDay = "week"
            } label: {
                ZStack {
                    UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 10, bottomLeading: 10))
                        .frame(width: 175.5, height: 37)
                        .foregroundStyle(weekOrDay == "week" ? Color(red: 103/255, green: 118/255, blue: 121/255) : .white)
                    HStack{
                        Text("週")
                            .font(.system(size: 20))
                            .foregroundStyle(weekOrDay == "week" ? .white : Color(red: 103/255, green: 118/255, blue: 121/255))
                        Spacer()
                            .frame(width: 140)
                    }
                }
            }
            
            Button {
                weekOrDay = "day"
            } label: {
                ZStack {
                    UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(bottomTrailing: 10, topTrailing: 10))
                        .frame(width: 175.5, height: 37)
                        .foregroundStyle(weekOrDay == "day" ? Color(red: 103/255, green: 118/255, blue: 121/255) : .white)
                    HStack{
                        Text("日")
                            .font(.system(size: 20))
                            .foregroundStyle(weekOrDay == "day" ? .white : Color(red: 103/255, green: 118/255, blue: 121/255))
                        Spacer()
                            .frame(width: 140)
                    }
                }
            }
        }
    }
}

#Preview {
    FoodAndDrinkView()
}
