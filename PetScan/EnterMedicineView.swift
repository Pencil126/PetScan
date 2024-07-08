//
//  EnterMedicineView.swift
//  PetScan
//
//  Created by 蔡承曄 on 2024/7/5.
//

import SwiftUI

struct EnterMedicineView: View {
    let themeColor: Color = Color(red: 149/255, green: 172/255, blue: 175/255)
    let backgroundColor: Color = Color(red: 237/255, green: 237/255, blue: 237/255)
    let selectedColor: Color = Color(red: 103/255, green: 118/255, blue: 121/255)
    @State private var nameOfMedicine:String = ""
    @State private var startTimeOfMedicine = Date()
    @State private var endTimeOfMedicine = Date()
    @State private var reasonOfMedicine:String = ""
    
    var body: some View {
        NavigationStack{
            ZStack{
                backgroundColor
                    .ignoresSafeArea()
                themeColor
                VStack{
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 350, height: 37)
                            .foregroundStyle(Color(red: 226/255, green: 233/255, blue: 233/255))
                        Text("寵物服用藥物紀錄填寫")
                            .font(.system(size: 20))
                    }
                    Form{
                        Section {
                            TextField("藥物紀錄", text: $nameOfMedicine)
                        }
                        .frame(height: 30)
                        Section{
                            DatePicker("服用起始日期", selection: $startTimeOfMedicine, displayedComponents: .date)
                        }
                        .frame(height: 30)
                        Section{
                            DatePicker("服用結束日期", selection: $endTimeOfMedicine, displayedComponents: .date)
                        }
                        .frame(height: 30)
                        Section {
                            TextField("服用原因", text: $nameOfMedicine)
                        }
                        .frame(height: 30)
                    }
                    .listSectionSpacing(30)
                    .frame(width: 385,height: 320)
                    .scrollContentBackground(.hidden)
                    .scrollDisabled(true)
                    
                    Button{
                        //action
                    }label: {
                        Text("+ 新增")
                            .foregroundStyle(.white)
                            .frame(width: 350,height: 65)
                            .font(.system(size: 24))
                            .background(selectedColor)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
                    .padding(20)
                    
                    NavigationLink{
                        MedicialHistroyView()
                    }label:{
                        Text("藥物服用歷史紀錄")
                            .foregroundStyle(.white)
                            .frame(width: 350,height: 65)
                            .font(.system(size: 24))
                            .background(selectedColor)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
                    .padding(4)
                    
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("藥物紀錄")
                        .font(.system(size: 24))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TabBarView(tabViewSelection: 4)
}
