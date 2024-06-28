//
//  UsersPet.swift
//  PetScan
//
//  Created by 廖清筆 on 2024/6/26.
//

import Foundation

struct UsersPet: Codable {
    var petID: Int
    var userID: String
    
    enum CodingKeys: CodingKey {
        case petID
        case userID
    }
}
