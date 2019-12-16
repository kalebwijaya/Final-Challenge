//
//  ProfileResponses.swift
//  Final Challenge
//
//  Created by Steven on 12/13/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class ProfileResponses: Codable{
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
