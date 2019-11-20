//
//  OrderDetails.swift
//  Final Challenge
//
//  Created by Kaleb Wijaya on 18/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

// MARK: - OrderDetailsResult
class OrderDetailsResult: Codable {
    let errorCode, errorMessage: String
    let data: OrderDetails
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_message"
        case data = "data"
    }

    init(errorCode: String, errorMessage: String, data: OrderDetails) {
        self.errorCode = errorCode
        self.errorMessage = errorMessage
        self.data = data
    }
}

// MARK: - OrderDetails
class OrderDetails: Codable {
    let sportCenterName, bookDate, bookCode, totalCourt: String
    let bookStatus, sportCenterImageURL: String
    let courtData: [CourtDetails]
    
    enum CodingKeys: String, CodingKey {
        case sportCenterName = "sport_center_name"
        case bookDate = "book_date"
        case bookCode = "book_code"
        case totalCourt = "total_court"
        case bookStatus = "book_status"
        case courtData = "court_data"
        case sportCenterImageURL = "sport_center_image_url"
    }

    init(sportCenterName: String, bookDate: String, bookCode: String, totalCourt: String, bookStatus: String, courtData: [CourtDetails], sportCenterImageURL:String) {
        self.sportCenterName = sportCenterName
        self.bookDate = bookDate
        self.bookCode = bookCode
        self.totalCourt = totalCourt
        self.bookStatus = bookStatus
        self.courtData = courtData
        self.sportCenterImageURL = sportCenterImageURL
    }
}

// MARK: - CourtDetails
class CourtDetails :Codable{
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
