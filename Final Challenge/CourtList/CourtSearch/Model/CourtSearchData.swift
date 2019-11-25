//
//  CourtSearchData.swift
//  Final Challenge
//
//  Created by Steven on 11/21/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class CourtSearchData: Codable {
    let sportCenterID: Int
    let sportCenterName, sportCenterLat, sportCenterLong: String
    let courtMinPrice, sportCenterImageURL: String

    enum CodingKeys: String, CodingKey {
        case sportCenterID = "sport_center_id"
        case sportCenterName = "sport_center_name"
        case sportCenterLat = "sport_center_lat"
        case sportCenterLong = "sport_center_long"
        case courtMinPrice = "court_min_price"
        case sportCenterImageURL = "sport_center_image_url"
    }

    init(sportCenterID: Int, sportCenterName: String, sportCenterLat: String, sportCenterLong: String, courtMinPrice: String, sportCenterImageURL: String) {
        self.sportCenterID = sportCenterID
        self.sportCenterName = sportCenterName
        self.sportCenterLat = sportCenterLat
        self.sportCenterLong = sportCenterLong
        self.courtMinPrice = courtMinPrice
        self.sportCenterImageURL = sportCenterImageURL
    }
}
