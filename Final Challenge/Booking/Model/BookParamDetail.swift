//
//  BookParamDetail.swift
//  Final Challenge
//
//  Created by Steven on 11/25/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class BookParamDetail: Codable{
    let courtID, bookStartTime, bookEndTime: String
    
    enum CodingKeys: String, CodingKey{
        case courtID = "court_id"
        case bookStartTime = "book_start_time"
        case bookEndTime = "book_end_time"
    }
    
    init(courtID: String , bookStartTime: String, bookEndTime: String) {
        self.courtID = courtID
        self.bookStartTime = bookStartTime
        self.bookEndTime = bookEndTime
    }
}
