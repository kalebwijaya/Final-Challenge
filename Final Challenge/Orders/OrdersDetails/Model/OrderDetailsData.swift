//
//  OrderDetailsData.swift
//  Final Challenge
//
//  Created by Kaleb Wijaya on 26/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class OrderDetailsData: Codable {
    let sportCenterName, bookDate, bookCode, totalCourt: String
    let bookStatus: String
    let sportCenterImageURL: String
    let courtData: [CourtDetailsDataDetails]

    enum CodingKeys: String, CodingKey {
        case sportCenterName = "sport_center_name"
        case bookDate = "book_date"
        case bookCode = "book_code"
        case totalCourt = "total_court"
        case bookStatus = "book_status"
        case sportCenterImageURL = "sport_center_image_url"
        case courtData = "court_data"
    }

    init(sportCenterName: String, bookDate: String, bookCode: String, totalCourt: String, bookStatus: String, sportCenterImageURL: String, courtData: [CourtDetailsDataDetails]) {
        self.sportCenterName = sportCenterName
        self.bookDate = bookDate
        self.bookCode = bookCode
        self.totalCourt = totalCourt
        self.bookStatus = bookStatus
        self.sportCenterImageURL = sportCenterImageURL
        self.courtData = courtData
    }
}
