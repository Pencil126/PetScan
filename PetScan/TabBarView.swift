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
    var body: some View {
        TabView{
            FoodAndDrinkView()
                .tabItem {
                    VStack{
                        Image(systemName: "house")
                        Text("皮膚病檢測")
                    }
                }
            FoodAndDrinkView()
                .tabItem {
                    VStack{
                        Image(systemName: "drop.fill")
                        Text("食物、飲水")
                    }
                }
            FoodAndDrinkView()
                .tabItem {
                    VStack{
                        Image(systemName: "house")
                        Text("主頁")
                    }
                }
            FoodAndDrinkView()
                .tabItem {
                    VStack{
                        Image(systemName: "questionmark")
                        Text("常識問答")
                    }
                }
            FoodAndDrinkView()
                .tabItem {
                    VStack{
                        Image(systemName: "gearshape")
                        Text("設定")
                    }
                }
        }
        .accentColor(themeColor)
    }
}

#Preview {
    TabBarView()
}
