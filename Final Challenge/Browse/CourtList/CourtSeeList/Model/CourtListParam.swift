//
//  CourtListParam.swift
//  Final Challenge
//
//  Created by Steven on 11/18/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class CourtListParam : Codable{
    var sportTypeID: String
    var userLatitude: String
    var userLongitude: String
    
    enum CodingKeys: String, CodingKey {
        case sportTypeID = "sport_type_id"
        case userLatitude = "user_latitude"
        case userLongitude = "user_longitude"
    }
    
    init(sportTypeID: String, userLatitude: String, userLongitude: String) {
        self.sportTypeID = sportTypeID
        self.userLatitude = userLatitude
        self.userLongitude = userLongitude
    }
}
