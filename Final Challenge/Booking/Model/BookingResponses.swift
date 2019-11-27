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
    let data: BookingCode

    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_message"
        case data
    }

    init(errorCode: String, errorMessage: String, data: BookingCode) {
        self.errorCode = errorCode
        self.errorMessage = errorMessage
        self.data = data
    }
}

class BookingCode: Codable {
    let bookID: String

    enum CodingKeys: String, CodingKey {
        case bookID = "book_id"
    }

    init(bookID: String) {
        self.bookID = bookID
    }
}
