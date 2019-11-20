//
//  BrowseData.swift
//  Final Challenge
//
//  Created by Steven on 11/18/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class BrowseData: Codable {
    let sportTypeID, sportTypeName, sportTypeImage: String

    enum CodingKeys: String, CodingKey {
        case sportTypeID = "sport_type_id"
        case sportTypeName = "sport_type_name"
        case sportTypeImage = "sport_type_image"
    }

    init(sportTypeID: String, sportTypeName: String, sportTypeImage: String) {
        self.sportTypeID = sportTypeID
        self.sportTypeName = sportTypeName
        self.sportTypeImage = sportTypeImage
    }
}
