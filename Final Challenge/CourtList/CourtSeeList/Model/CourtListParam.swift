//
//  CourtListParam.swift
//  Final Challenge
//
//  Created by Steven on 11/18/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class CourtListParam: Codable {
    var sportTypeID: Int
    var userLatitude: String
    var userLongitude: String
    
    enum CodingKeys: String, CodingKey {
        case sportTypeID = "sport_type_id"
        case userLatitude = "lat"
        case userLongitude = "long"
    }
    
    init(sportTypeID: Int, userLatitude: String, userLongitude: String) {
        self.sportTypeID = sportTypeID
        self.userLatitude = userLatitude
        self.userLongitude = userLongitude
    }
}

