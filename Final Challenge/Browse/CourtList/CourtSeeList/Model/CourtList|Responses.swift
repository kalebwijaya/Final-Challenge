//
//  CourtListResult.swift
//  Final Challenge
//
//  Created by Steven on 11/18/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class CourtListResponses: Codable {
    let errorCode, errorMessage, sportTypeID: String
    let data: [CourtListData]

    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_message"
        case sportTypeID = "sport_type_id"
        case data
    }

    init(errorCode: String, errorMessage: String, sportTypeID: String, data: [CourtListData]) {
        self.errorCode = errorCode
        self.errorMessage = errorMessage
        self.sportTypeID = sportTypeID
        self.data = data
    }
}


