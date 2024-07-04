//
//  DiseaseOutcomeView.swift
//  PetScan
//
//  Created by 蔡承曄 on 2024/7/4.
//

import SwiftUI

struct DiseaseOutcomeView: View {
    let themeColor: Color = Color(red: 149/255, green: 172/255, blue: 175/255)
    let backgroundColor: Color = Color(red: 237/255, green: 237/255, blue: 237/255)
    let selectedColor: Color = Color(red: 103/255, green: 118/255, blue: 121/255)
    
    var body: some View {
        NavigationStack{
            ZStack{
                backgroundColor
                    .ignoresSafeArea()
                themeColor
                    .frame(height: 650)
                VStack{
                    Rectangle()
                        .frame(width: 362,height: 263)
                        .foregroundStyle(.white)
                        .padding()
                    Text("disease")
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                        .padding()
                    Text("請儘速就醫")
                        .font(.system(size: 48))
                        .foregroundStyle(.white)
                    NavigationLink{
                        HospitalMapView()
                    }label: {
                        Text("獸醫院地圖")
                            .foregroundStyle(.white)
                            .frame(width: 362,height: 65)
                            .font(.system(size: 24))
                            .background(Color(red: 103/255, green: 118/255, blue: 121/255))
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("皮膚病檢測結果")
                        .font(.system(size: 24))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TabBarView(tabViewSelection: 0)
}
