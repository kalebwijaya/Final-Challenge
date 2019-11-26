//
//  CourtListData.swift
//  Final Challenge
//
//  Created by Steven on 11/18/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation


// MARK: - Datum
class CourtListData: Codable {
    
    let sportCenterID: Int
    let sportCenterName,sportCenterLat, sportCenterLong,sportMinPrice, sportCenterImageURL: String
    let sportCenterDistance: Float
//    let sportCenterDistance: String
    
    enum CodingKeys: String, CodingKey {
        case sportCenterID = "sport_center_id"
        case sportCenterName = "sport_center_name"
        case sportCenterLat = "sport_center_lat"
        case sportCenterLong = "sport_center_long"
        case sportMinPrice = "sport_min_price"
        case sportCenterImageURL = "sport_center_image_url"
        case sportCenterDistance = "sport_center_distance"
    }

    init(sportCenterID: Int, sportCenterName: String, sportCenterLat: String, sportCenterLong: String, sportMinPrice: String, sportCenterImageURL: String, sportCenterDistance: Float) {
        self.sportCenterID = sportCenterID
        self.sportCenterName = sportCenterName
        self.sportCenterLat = sportCenterLat
        self.sportCenterLong = sportCenterLong
        self.sportMinPrice = sportMinPrice
        self.sportCenterImageURL = sportCenterImageURL
        self.sportCenterDistance = sportCenterDistance
    }
}
