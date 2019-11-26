//
//  CourtDetailsData.swift
//  Final Challenge
//
//  Created by Steven on 11/26/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class CourtDetailsData: Codable {
    let sportCenterID, sportTypeID, sportCenterName, sportMinPrice: String
    let sportCenterAddress, sportCenterLat, sportCenterLong, sportCenterOpenTime: String
    let sportCenterCloseTime, sportCenterStatus: String
    let sportCenterImage: [CourtDetailsImage]

    enum CodingKeys: String, CodingKey {
        case sportCenterID = "sport_center_id"
        case sportTypeID = "sport_type_id"
        case sportCenterName = "sport_center_name"
        case sportMinPrice = "sport_min_price"
        case sportCenterAddress = "sport_center_address"
        case sportCenterLat = "sport_center_lat"
        case sportCenterLong = "sport_center_long"
        case sportCenterOpenTime = "sport_center_open_time"
        case sportCenterCloseTime = "sport_center_close_time"
        case sportCenterImage = "sport_center_image"
        case sportCenterStatus = "sport_center_status"
    }

    init(sportCenterID: String, sportTypeID: String, sportCenterName: String, sportMinPrice: String, sportCenterAddress: String, sportCenterLat: String, sportCenterLong: String, sportCenterOpenTime: String, sportCenterCloseTime: String, sportCenterStatus: String, sportCenterImage: [CourtDetailsImage]) {
        self.sportCenterID = sportCenterID
        self.sportTypeID = sportTypeID
        self.sportCenterName = sportCenterName
        self.sportMinPrice = sportMinPrice
        self.sportCenterAddress = sportCenterAddress
        self.sportCenterLat = sportCenterLat
        self.sportCenterLong = sportCenterLong
        self.sportCenterOpenTime = sportCenterOpenTime
        self.sportCenterCloseTime = sportCenterCloseTime
        self.sportCenterImage = sportCenterImage
        self.sportCenterStatus = sportCenterStatus
    }
}
