//
//  CourtDetailsResponses.swift
//  Final Challenge
//
//  Created by Steven on 11/26/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class CourtDetailsResponses: Codable {
    let errorCode, errorMessage: String
    let data: CourtDetailsData

    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_message"
        case data
    }

    init(errorCode: String, errorMessage: String, data: CourtDetailsData) {
        self.errorCode = errorCode
        self.errorMessage = errorMessage
        self.data = data
    }
}
