//
//  HealthCheckRecordView.swift
//  PetScan
//
//  Created by 蔡承曄 on 2024/7/4.
//

import SwiftUI

struct HealthCheckRecordView: View {
    let themeColor: Color = Color(red: 149/255, green: 172/255, blue: 175/255)
    let backgroundColor: Color = Color(red: 237/255, green: 237/255, blue: 237/255)
    let selectedColor: Color = Color(red: 103/255, green: 118/255, blue: 121/255)
    let recordDate: [String] = [
        "2024/06/29",
        "2024/05/18",
        "2023/09/28",
        "2023/03/23",
        "2023/03/11",
        "2023/03/02",
        "2022/09/03",
        "2022/08/28",
        "2022/04/22",
        "2021/12/17",
        "2021/09/03"
    ]
    let recordColor: [Color] = [
        Color(red: 185/255, green: 132/255, blue: 132/255),
        Color(red: 139/255, green: 185/255, blue: 132/255),
        Color(red: 185/255, green: 132/255, blue: 132/255),
        Color(red: 185/255, green: 132/255, blue: 132/255),
        Color(red: 139/255, green: 185/255, blue: 132/255),
        Color(red: 139/255, green: 185/255, blue: 132/255),
        Color(red: 185/255, green: 132/255, blue: 132/255),
        Color(red: 185/255, green: 132/255, blue: 132/255),
        Color(red: 185/255, green: 132/255, blue: 132/255),
        Color(red: 139/255, green: 185/255, blue: 132/255),
        Color(red: 139/255, green: 185/255, blue: 132/255)
    ]
    var body: some View {
        NavigationStack{
            ZStack{
                backgroundColor
                    .ignoresSafeArea()
                themeColor
                VStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 350,height: 600)
                            .foregroundStyle(Color(red: 226/255, green: 233/255, blue: 233/255))
                        ScrollView{
                            VStack(spacing: 0){
                                ForEach(recordDate.indices, id: \.self){ index in
                                    HStack{
                                        Text(recordDate[index])
                                            .font(.system(size: 20))
                                            .frame(width: 120,alignment: .leading)
                                        Text("檢查結果")
                                            .font(.system(size: 20))
                                            .padding(.horizontal,8)
                                        Rectangle()
                                            .frame(width: 70,height: 30)
                                            .foregroundStyle(recordColor[index])
                                    }
                                    
                                    Divider()
                                        .overlay(.black)
                                        .frame(width: 320)
                                        .padding(12)
                                }
                            }
                        }
                        .frame(width: 350,height: 580)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("健康檢查紀錄")
                        .font(.system(size: 24))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    HealthCheckRecordView()
}
