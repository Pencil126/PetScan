//
//  UpdatePictureView.swift
//  PetScan
//
//  Created by 蔡承曄 on 2024/7/4.
//

import SwiftUI

struct UpdatePictureView: View {
    let themeColor: Color = Color(red: 149/255, green: 172/255, blue: 175/255)
    let backgroundColor: Color = Color(red: 237/255, green: 237/255, blue: 237/255)
    
    var body: some View {
        ZStack{
            backgroundColor
                .ignoresSafeArea()
            themeColor
                .frame(height: 650)
            VStack{
                Text("皮膚病檢測")
                    .font(.system(size: 24))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                
                Rectangle()
                    .frame(width: 362,height: 448)
                    .foregroundStyle(.white)
                    .padding()
                
                Button{
                    //action
                }label: {
                    Text("基礎問題檢測")
                        .foregroundStyle(.white)
                        .frame(width: 362,height: 65)
                        .font(.system(size: 24))
                        .background(Color(red: 103/255, green: 118/255, blue: 121/255))
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    UpdatePictureView()
}
