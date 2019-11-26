//
//  CourtSearchResponse.swift
//  Final Challenge
//
//  Created by Steven on 11/21/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class CourtSearchResponse: Codable{
    let errorCode, errorMessage: String
    let data: [CourtSearchData]

    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_message"
        case data
    }

    init(errorCode: String, errorMessage: String, data: [CourtSearchData]) {
        self.errorCode = errorCode
        self.errorMessage = errorMessage
        self.data = data
    }
}
