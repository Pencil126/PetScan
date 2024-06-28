//
//  PetInfo.swift
//  PetScan
//
//  Created by 廖清筆 on 2024/6/26.
//

import Foundation
import FirebaseFirestoreSwift

struct PetInfo: Codable {
    @DocumentID var id: String?
    var name: String
    var petID: Int
    var type: String
    var weight: Double
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case petID
        case type
        case weight
    }
}
