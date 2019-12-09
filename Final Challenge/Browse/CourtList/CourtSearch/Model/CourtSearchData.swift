//
//  CourtSearchData.swift
//  Final Challenge
//
//  Created by Steven on 11/21/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class CourtSearchData: Codable {
    
   let sportCenterID: String
    let sportCenterName,sportCenterLat, sportCenterLong,courtMinPrice, sportCenterImageURL: String
    let sportCenterDistance: Float

    enum CodingKeys: String, CodingKey {
        case sportCenterID = "sport_center_id"
        case sportCenterName = "sport_center_name"
        case sportCenterLat = "sport_center_lat"
        case sportCenterLong = "sport_center_long"
        case courtMinPrice = "sport_min_price"
        case sportCenterImageURL = "sport_center_image_url"
        case sportCenterDistance = "sport_center_distance"
    }

    init(sportCenterID: String, sportCenterName: String, sportCenterLat: String, sportCenterLong: String, courtMinPrice: String, sportCenterImageURL: String,
        sportCenterDistance: Float) {
        self.sportCenterID = sportCenterID
        self.sportCenterName = sportCenterName
        self.sportCenterLat = sportCenterLat
        self.sportCenterLong = sportCenterLong
        self.courtMinPrice = courtMinPrice
        self.sportCenterImageURL = sportCenterImageURL
        self.sportCenterDistance = sportCenterDistance
    }
}
