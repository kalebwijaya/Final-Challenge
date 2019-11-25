//
//  BookingResponses.swift
//  Final Challenge
//
//  Created by Steven on 11/25/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class BookingResponse: Codable{
    let errorCode, errorMessage: String
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_message"
    }

    init(errorCode: String, errorMessage: String) {
        self.errorCode = errorCode
        self.errorMessage = errorMessage
    }
}
