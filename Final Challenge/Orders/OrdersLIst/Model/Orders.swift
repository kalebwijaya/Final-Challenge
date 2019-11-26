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


