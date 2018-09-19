//
//  FacilitiesModel.swift
//  Cars24
//
//  Created by Coffeebeans on 18/09/18.
//  Copyright © 2018 Coffeebeans. All rights reserved.
//

import Foundation

struct FacilitiesModel:Codable {
    let facilities:[Facility]?
    let exclusions:[[Exclusion]]?
}

struct Facility:Codable {
    let facility_id:String?
    let name:String?
    let options:[Option]?
}

struct Option:Codable {
    let name:String?
    let icon:String?
    let id:String?
    var isActive:Bool=false
    var isDisabled:Bool=false
    
    enum CodingKeys: String, CodingKey {
        case name
        case icon
        case id
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        icon = try values.decode(String.self, forKey: .icon)
        id = try values.decode(String.self, forKey: .id)
    }
}

struct Exclusion:Codable {
    let facility_id:String?
    let options_id:String?
}

