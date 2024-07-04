//
//  PetList.swift
//  PetScan
//
//  Created by 蔡承曄 on 2024/6/10.
//

import Foundation
import SwiftUI

// 定義Pet資料模型
struct Pet: Identifiable {
    let id = UUID()
    var petName: String
    var petAvatar: String
}

// 定義包含多個Pet的Pets資料結構
struct Pets {
    var petList: [Pet]
}
