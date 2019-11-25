//
//  BookingParam.swift
//  Final Challenge
//
//  Created by Steven on 11/25/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class BookingParam: Codable{
    let bookDate, userID : String
    let bookInput: [BookParamDetail]
    
    enum CodingKeys: String, CodingKey{
        case bookDate = "date"
        case userID = "user_id"
        case bookInput
    }
    
    init(bookDate: String, userID: String, bookInput: [BookParamDetail]) {
        self.bookDate = bookDate
        self.userID = userID
        self.bookInput = bookInput
    }
    
}
