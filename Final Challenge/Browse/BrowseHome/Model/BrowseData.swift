//
//  BrowseData.swift
//  Final Challenge
//
//  Created by Steven on 11/18/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class BrowseData: Codable {
  
    let sportTypeID: Int
    let sportTypeName, sportTypeImage: String

    enum CodingKeys: String, CodingKey {
        case sportTypeID = "sport_type_id"
        case sportTypeName = "sport_type_name"
        case sportTypeImage = "sport_type_image"
    }

    init(sportTypeID: Int, sportTypeName: String, sportTypeImage: String) {
        self.sportTypeID = sportTypeID
        self.sportTypeName = sportTypeName
        self.sportTypeImage = sportTypeImage
    }
}
