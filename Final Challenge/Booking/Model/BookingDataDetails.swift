//
//  BookingDataDetails.swift
//  Final Challenge
//
//  Created by Steven on 11/25/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class BookingCourtDetails: Codable {
    let courtID, courtName, courtPriceDay, courtPriceNight: String
    let courtUnavailableTime: [String]

    enum CodingKeys: String, CodingKey {
        case courtID = "court_id"
        case courtName = "court_name"
        case courtPriceDay = "court_price_day"
        case courtPriceNight = "court_price_night"
        case courtUnavailableTime = "court_unavailable_time"
    }

    init(courtID: String, courtName: String, courtPriceDay: String, courtPriceNight: String, courtUnavailableTime: [String]) {
        self.courtID = courtID
        self.courtName = courtName
        self.courtPriceDay = courtPriceDay
        self.courtPriceNight = courtPriceNight
        self.courtUnavailableTime = courtUnavailableTime
    }
}
