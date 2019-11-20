//
//  History.swift
//  Final Challenge
//
//  Created by Kaleb Wijaya on 17/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

// MARK: - HistoryResult
class HistoryResult: Codable {
    let errorCode, errorMessage: String
    let data: [History]

    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_message"
        case data = "data"
    }
    
    init(errorCode: String, errorMessage: String, data: [History]) {
        self.errorCode = errorCode
        self.errorMessage = errorMessage
        self.data = data
    }
}

// MARK: - History
class History: Codable {
    let bookID, sportCenterName, statusTypeName, bookDate: String
    let totalPayment, sportCenterImageURL: String

    enum CodingKeys: String, CodingKey {
        case bookID = "book_id"
        case sportCenterName = "sport_center_name"
        case statusTypeName = "status_type_name"
        case bookDate = "book_date"
        case totalPayment = "total_payment"
        case sportCenterImageURL = "sport_center_image_url"
    }
    
    init(bookID: String, sportCenterName: String, statusTypeName: String, bookDate: String, totalPayment: String, sportCenterImageURL: String) {
        self.bookID = bookID
        self.sportCenterName = sportCenterName
        self.statusTypeName = statusTypeName
        self.bookDate = bookDate
        self.totalPayment = totalPayment
        self.sportCenterImageURL = sportCenterImageURL
    }
}
