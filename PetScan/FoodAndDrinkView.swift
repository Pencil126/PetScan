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
    var body: some View {
        ZStack{
            backgroundColor
                .ignoresSafeArea()
            themeColor
                .frame(height: 650)

            VStack{
                Text("食物與喝水")
                    .font(.system(size: 24))
                    .padding(.top,10)
                
                Spacer()
                    .frame(height: 45)
                
                //寵物資料
                
                VStack{
                    DatePicker("日期", selection: $date,displayedComponents: .date)
                        .padding(.horizontal)
                    DatePicker("時間", selection: $date,displayedComponents: .hourAndMinute)
                        .padding(.horizontal)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    FoodAndDrinkView()
}
