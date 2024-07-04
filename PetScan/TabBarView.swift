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
            FoodAndDrinkView()
                .tabItem {
                    VStack{
                        Image(systemName: "drop.fill")
                        Text("食物、飲水")
                    }
                }
                .tag(1)
            HomeView()
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
            Text("Setting View")
                .tabItem {
                    VStack{
                        Image(systemName: "gearshape")
                        Text("設定")
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
