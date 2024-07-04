//
//  MedicialHistroyView.swift
//  PetScan
//
//  Created by 蔡承曄 on 2024/7/4.
//

import SwiftUI

struct MedicialHistroyView: View {
    let themeColor: Color = Color(red: 149/255, green: 172/255, blue: 175/255)
    let backgroundColor: Color = Color(red: 237/255, green: 237/255, blue: 237/255)
    let selectedColor: Color = Color(red: 103/255, green: 118/255, blue: 121/255)
    
    var body: some View {
        NavigationStack{
            ZStack{
                backgroundColor
                    .ignoresSafeArea()
                themeColor
                    .frame(height: 710)
                VStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 350,height: 35)
                            .foregroundStyle(Color(red: 226/255, green: 233/255, blue: 233/255))
                        Text("服用藥物")
                            .frame(width: 300,alignment: .leading)
                            .font(.system(size: 20))
                    }
                    
                    ScrollView{
                        VStack{
                            Text("多重奏狗S口嚼錠225毫克")
                                .font(.system(size: 20))
                                .frame(width: 300,alignment: .leading)
                                .padding(4)
                            Text("服用期間 2024/05/18-2024/06/29")
                                .font(.system(size: 14))
                                .frame(width: 300,alignment: .trailing)
                            Text("服用原因 跳蚤感染，預防心絲蟲症")
                                .font(.system(size: 14))
                                .frame(width: 300,alignment: .trailing)
                        }
                        .foregroundStyle(.white)
                        
                        Divider()
                            .overlay(.white)
                            .frame(width: 350)
                            .padding(5)
                        
                        VStack{
                            Text("諾皮佳25毫克")
                                .font(.system(size: 20))
                                .frame(width: 300,alignment: .leading)
                                .padding(4)
                            Text("服用期間 2024/05/18-2024/06/29")
                                .font(.system(size: 14))
                                .frame(width: 300,alignment: .trailing)
                            Text("服用原因 治療犬隻慢性異位性皮膚炎")
                                .font(.system(size: 14))
                                .frame(width: 300,alignment: .trailing)
                        }
                        .foregroundStyle(.white)
                        
                        Divider()
                            .overlay(.white)
                            .frame(width: 350)
                            .padding(5)
                        
                        VStack{
                            Text("禮藍悅耳")
                                .font(.system(size: 20))
                                .frame(width: 300,alignment: .leading)
                                .padding(4)
                            Text("服用期間 2023/03/02-2023/03/23")
                                .font(.system(size: 14))
                                .frame(width: 300,alignment: .trailing)
                            Text("服用原因 急性外耳炎")
                                .font(.system(size: 14))
                                .frame(width: 300,alignment: .trailing)
                        }
                        .foregroundStyle(.white)
                        
                        Divider()
                            .overlay(.white)
                            .frame(width: 350)
                            .padding(5)
                        
                        VStack{
                            Text("舒露朗")
                                .font(.system(size: 20))
                                .frame(width: 300,alignment: .leading)
                                .padding(4)
                            Text("服用期間 2023/03/02-2023/03/23")
                                .font(.system(size: 14))
                                .frame(width: 300,alignment: .trailing)
                            Text("服用原因 陽性細菌引起之外耳炎")
                                .font(.system(size: 14))
                                .frame(width: 300,alignment: .trailing)
                        }
                        .foregroundStyle(.white)
                        
                        Divider()
                            .overlay(.white)
                            .frame(width: 350)
                            .padding(5)
                        
                        VStack{
                            Text("滅心蟲10")
                                .font(.system(size: 20))
                                .frame(width: 300,alignment: .leading)
                                .padding(4)
                            Text("服用期間 2023/03/02-2023/03/23")
                                .font(.system(size: 14))
                                .frame(width: 300,alignment: .trailing)
                            Text("服用原因 預防犬心絲蟲")
                                .font(.system(size: 14))
                                .frame(width: 300,alignment: .trailing)
                        }
                        .foregroundStyle(.white)
                        
                        Divider()
                            .overlay(.white)
                            .frame(width: 350)
                            .padding(5)
                    }
                    .frame(height: 500)
                    
                    NavigationLink{
                        //action
                    }label: {
                        Text("新增紀錄")
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
                    Text("藥物歷史紀錄")
                        .font(.system(size: 24))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TabBarView(tabViewSelection: 2)
}
