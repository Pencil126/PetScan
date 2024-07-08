//
//  TabBarView.swift
//  PetScan
//
//  Created by 蔡承曄 on 2024/7/3.
//

import SwiftUI

struct TabBarView: View {
    let themeColor: Color = Color(red: 149/255, green: 172/255, blue: 175/255)
    let backgroundColor: Color = Color(red: 237/255, green: 237/255, blue: 237/255)
    @State public var tabViewSelection = 2
    
    @State private var drinkRecords: [DrinkRecord] = [
            DrinkRecord(time: "7/1", value: 600),
            DrinkRecord(time: "7/2", value: 650),
            DrinkRecord(time: "7/3", value: 680),
            DrinkRecord(time: "7/4", value: 620),
            DrinkRecord(time: "7/5", value: 780),
            DrinkRecord(time: "7/6", value: 700),
            DrinkRecord(time: "7/8", value: 710),
            DrinkRecord(time: "7/9", value: 650)
        ]
    
    var body: some View {
        TabView(selection: $tabViewSelection){
            UpdatePictureView()
                .tabItem {
                    VStack{
                        Image(systemName: "cross.fill")
                        Text("皮膚病檢測")
                    }
                }
                .tag(0)
            FoodAndDrinkView(drinkRecords: $drinkRecords)
                .tabItem {
                    VStack{
                        Image(systemName: "drop.fill")
                        Text("食物、飲水")
                    }
                }
                .tag(1)
            HomeView(drinkRecords: $drinkRecords)
                .tabItem {
                    VStack{
                        Image(systemName: "house")
                        Text("主頁")
                    }
                }
                .tag(2)
            QuestionsView()
                .tabItem {
                    VStack{
                        Image(systemName: "questionmark")
                        Text("常識問答")
                    }
                }
                .tag(3)
            EnterMedicineView()
                .tabItem {
                    VStack{
                        Image(systemName: "pill.fill")
                        Text("藥物紀錄")
                    }
                }
                .tag(4)
        }
        .accentColor(Color(red: 207/255, green: 116/255, blue: 65/255))
        .tableStyle(.automatic)
    }
}

#Preview {
    TabBarView()
}
