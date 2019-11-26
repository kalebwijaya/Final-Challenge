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
    let data: OrderDetailsData
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_message"
        case data = "data"
    }

    init(errorCode: String, errorMessage: String, data: OrderDetailsData) {
        self.errorCode = errorCode
        self.errorMessage = errorMessage
        self.data = data
    }
}
