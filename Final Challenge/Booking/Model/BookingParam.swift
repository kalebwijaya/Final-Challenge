//
//  BookingParam.swift
//  Final Challenge
//
//  Created by Steven on 11/25/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class BookingParam: Codable{
    let bookDate, userID, sportCenterID : String
    let bookInput: [BookParamDetail]
    
    enum CodingKeys: String, CodingKey{
        case bookDate = "date"
        case userID = "user_id"
        case sportCenterID = "sport_center_id"
        case bookInput = "book_input"
    }
    
    init(bookDate: String, userID: String, sportCenterID:String, bookInput: [BookParamDetail]) {
        self.bookDate = bookDate
        self.userID = userID
        self.bookInput = bookInput
        self.sportCenterID = sportCenterID
    }
    
}
