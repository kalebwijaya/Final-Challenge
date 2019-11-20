//
//  CourtDetails.swift
//  Final Challenge
//
//  Created by Kaleb Wijaya on 19/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

// MARK: - CourtDetailsResult
class CourtDetailsResult: Codable {
    let errorCode, errorMessage: String
    let data: CourtDetailsBooking

    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_message"
        case data
    }

    init(errorCode: String, errorMessage: String, data: CourtDetailsBooking) {
        self.errorCode = errorCode
        self.errorMessage = errorMessage
        self.data = data
    }
}

// MARK: - CourtDetailsBooking
class CourtDetailsBooking: Codable {
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

// MARK: - CourtDetailsImage
class CourtDetailsImage: Codable {
    let sportImageID, sportImageURL: String

    enum CodingKeys: String, CodingKey {
        case sportImageID = "sport_image_id"
        case sportImageURL = "sport_image_url"
    }

    init(sportImageID: String, sportImageURL: String) {
        self.sportImageID = sportImageID
        self.sportImageURL = sportImageURL
    }
}
