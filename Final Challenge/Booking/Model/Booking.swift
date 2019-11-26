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


