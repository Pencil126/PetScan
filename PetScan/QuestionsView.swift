//
//  QuestionsView.swift
//  PetScan
//
//  Created by 蔡承曄 on 2024/7/4.
//

import SwiftUI

struct QuestionsView: View {
    let themeColor: Color = Color(red: 149/255, green: 172/255, blue: 175/255)
    let backgroundColor: Color = Color(red: 237/255, green: 237/255, blue: 237/255)
    let selectedColor: Color = Color(red: 103/255, green: 118/255, blue: 121/255)
    
    @State private var selectedAnser = 0
    var body: some View {
        NavigationStack{
            ZStack{
                backgroundColor
                    .ignoresSafeArea()
                themeColor
                VStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 350,height: 258)
                            .foregroundStyle(.white)
                        HStack(alignment: .top){
                            Text("Q.")
                                .font(.system(size: 32))
                            Text("下列何者是狗狗可以吃的東西？")
                                .font(.system(size: 32))
                        }
                        .frame(width: 330,alignment: .center)
                        if selectedAnser == 3{
                            Circle()
                                .frame(width: 180)
                                .foregroundStyle(.clear)
                                .overlay(
                                    Circle()
                                        .stroke(.red,lineWidth: 35)
                                )
                        }
                        else if selectedAnser == 1 || selectedAnser == 2{
                            Image(systemName: "cross.fill")
                                .resizable()
                                .rotationEffect(.degrees(45))
                                .foregroundStyle(.red)
                                .frame(width: 180,height: 180)
                        }
                    }
                    
                    
                    Button{
                        selectedAnser = 1
                    }label: {
                        ZStack{
                            if selectedAnser == 1{
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(width: 350, height: 70)
                                    .foregroundStyle(.red)
                            }
                            else if selectedAnser == 2{
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(width: 350, height: 70)
                                    .foregroundStyle(Color(red: 226/255, green: 233/255, blue: 233/255))
                            }
                            else if selectedAnser == 3{
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(width: 350, height: 70)
                                    .foregroundStyle(Color(red: 226/255, green: 233/255, blue: 233/255))
                            }
                            else {
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(width: 350, height: 70)
                                    .foregroundStyle(selectedColor)
                            }
                            HStack{
                                Text("A")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 32))
                                Spacer()
                                Text("巧克力")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 32))
                                Spacer()
                            }
                            .frame(width: 300, height: 70)
                                
                        }
                    }
                    .padding(4)
                    
                    Button{
                        selectedAnser = 2
                    }label: {
                        ZStack{
                            if selectedAnser == 1{
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(width: 350, height: 70)
                                    .foregroundStyle(Color(red: 226/255, green: 233/255, blue: 233/255))
                            }
                            else if selectedAnser == 2{
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(width: 350, height: 70)
                                    .foregroundStyle(.red)
                            }
                            else if selectedAnser == 3{
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(width: 350, height: 70)
                                    .foregroundStyle(Color(red: 226/255, green: 233/255, blue: 233/255))
                            }
                            else {
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(width: 350, height: 70)
                                    .foregroundStyle(selectedColor)
                            }
                            HStack{
                                Text("B")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 32))
                                Spacer()
                                Text("雞骨頭")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 32))
                                Spacer()
                            }
                            .frame(width: 300, height: 70)
                                
                        }
                    }
                    .padding(4)
                    
                    Button{
                        selectedAnser = 3
                    }label: {
                        ZStack{
                            if selectedAnser == 1{
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(width: 350, height: 70)
                                    .foregroundStyle(.green)
                            }
                            else if selectedAnser == 2{
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(width: 350, height: 70)
                                    .foregroundStyle(.green)
                            }
                            else if selectedAnser == 3{
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(width: 350, height: 70)
                                    .foregroundStyle(selectedColor)
                            }
                            else {
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(width: 350, height: 70)
                                    .foregroundStyle(selectedColor)
                            }
                            HStack{
                                Text("C")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 32))
                                Spacer()
                                Text("無調味肉乾")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 32))
                                Spacer()
                            }
                            .frame(width: 300, height: 70)
                                
                        }
                    }
                    .padding(4)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("常識問答")
                        .font(.system(size: 24))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TabBarView(tabViewSelection: 3)
}
