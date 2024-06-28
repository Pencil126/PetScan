//
//  HomeView.swift
//  PetScan
//
//  Created by 蔡承曄 on 2024/6/19.
//

import SwiftUI
import FirebaseFirestore

struct HomeView: View {
    let themeColor: Color = Color(red: 149/255, green: 172/255, blue: 175/255)
    let backgroundColor: Color = Color(red: 237/255, green: 237/255, blue: 237/255)
//    let user: [String: Any]
    @StateObject var viewModel = FirestoreViewModel()
    
    var body: some View {
        ZStack{
            backgroundColor
                .ignoresSafeArea()
            themeColor
                .frame(height: 650)
            VStack{
                Text("主頁")
                    .font(.system(size: 24))
                    .padding(.top,10)
                
                Spacer()
                    .frame(height: 45)
                
                //寵物資料
                VStack{
                    Circle()
                        .frame(width: 100)
                    Text(viewModel.currentPetName())
                        .font(.system(size: 32))
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text("品種：   ")
                            Text(viewModel.currentPetType())
                        }
                        .font(.system(size: 24))
                        .padding(.vertical,2)
                        
                        HStack{
                            Text("體重：   ")
                            Text(viewModel.currentPetWeight())
                            Text("kg")
                        }
                        .font(.system(size: 24))
                        .padding(.vertical,2)
                    }
                    
                }
                .foregroundStyle(.white)
                
                //功能按鍵區塊
                VStack{
                    Button("食物與喝水量歷史紀錄"){
                        //action
                    }
                    .buttonStyle(HomeViewButtonStyle())
                    
                    Button("藥物歷史紀錄"){
                        //action
                    }
                    .buttonStyle(HomeViewButtonStyle())
                    
                    Button("健康檢查紀錄"){
                        //action
                    }
                    .buttonStyle(HomeViewButtonStyle())
                    
                    Button("皮膚病檢測結果歷史紀錄"){
                        //action
                    }
                    .buttonStyle(HomeViewButtonStyle())
                }
                
                Spacer()
            }
        }
    }
}

struct HomeViewButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 351,height: 59)
            .font(.system(size: 24))
            .background(Color(red: 238/255, green: 238/255, blue: 238/255))
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .foregroundStyle(Color(red: 103/255, green: 118/255, blue: 121/255))
            .padding(.vertical,10)
            
    }
}

#Preview {
    HomeView()
}
