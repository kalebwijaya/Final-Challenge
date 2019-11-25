//
//  Booking.swift
//  Final Challenge
//
//  Created by Kaleb Wijaya on 22/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

// MARK: - BookingCourtResult
class BookingCourtResult: Codable {
    let errorCode, errorMessage: String
    let data: BookingCourt
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_message"
        case data
    }

    init(errorCode: String, errorMessage: String, data: BookingCourt) {
        self.errorCode = errorCode
        self.errorMessage = errorMessage
        self.data = data
    }
}

// MARK: - BookingCourt
class BookingCourt: Codable {
    let sportCenterOpenTime, sportCenterClosedTime, sportCenterDayTime, sportCenterNightTime: String
    let sportCenterDetail: [BookingCourtDetails]

    enum CodingKeys: String, CodingKey {
        case sportCenterOpenTime = "sport_center_open_time"
        case sportCenterClosedTime = "sport_center_closed_time"
        case sportCenterDayTime = "sport_center_day_time"
        case sportCenterNightTime = "sport_center_night_time"
        case sportCenterDetail = "sport_center_detail"
    }

    init(sportCenterOpenTime: String, sportCenterClosedTime: String, sportCenterDayTime:String, sportCenterNightTime:String, sportCenterDetail: [BookingCourtDetails]) {
        self.sportCenterOpenTime = sportCenterOpenTime
        self.sportCenterClosedTime = sportCenterClosedTime
        self.sportCenterDetail = sportCenterDetail
        self.sportCenterDayTime = sportCenterDayTime
        self.sportCenterNightTime = sportCenterNightTime
    }
}

// MARK: - BookingCourtDetails
class BookingCourtDetails: Codable {
    let courtID, courtName, courtPriceDay, courtPriceNight: String
    let courtAvailableTime: [String]

    enum CodingKeys: String, CodingKey {
        case courtID = "court_id"
        case courtName = "court_name"
        case courtPriceDay = "court_price_day"
        case courtPriceNight = "court_price_night"
        case courtAvailableTime = "court_available_time"
    }

    init(courtID: String, courtName: String, courtPriceDay: String, courtPriceNight: String, courtAvailableTime: [String]) {
        self.courtID = courtID
        self.courtName = courtName
        self.courtPriceDay = courtPriceDay
        self.courtPriceNight = courtPriceNight
        self.courtAvailableTime = courtAvailableTime
    }
}
