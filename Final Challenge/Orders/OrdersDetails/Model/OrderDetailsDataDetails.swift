//
//  OrderDetailsDataDetails.swift
//  Final Challenge
//
//  Created by Kaleb Wijaya on 26/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

// MARK: - CourtDetails
class CourtDetailsDataDetails :Codable{
    let courtName, bookStartTime, bookEndTime, courtPrice: String
    
    enum CodingKeys: String, CodingKey {
        case courtName = "court_name"
        case bookStartTime = "book_start_time"
        case bookEndTime = "book_end_time"
        case courtPrice = "court_price"
    }

    init(courtName: String, bookStartTime: String, bookEndTime: String, courtPrice: String) {
        self.courtName = courtName
        self.bookStartTime = bookStartTime
        self.bookEndTime = bookEndTime
        self.courtPrice = courtPrice
    }
}
