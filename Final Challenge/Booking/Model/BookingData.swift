//
//  BookingData.swift
//  Final Challenge
//
//  Created by Steven on 11/25/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

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
