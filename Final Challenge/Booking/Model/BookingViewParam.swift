//
//  BookingViewParam.swift
//  Final Challenge
//
//  Created by Steven on 11/26/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class BookingViewParam: Codable{
    let sportTypeID, sportCenterID, date: String
    
    enum CodingKeys: String, CodingKey{
        case sportTypeID = "sport_type_id"
        case sportCenterID = "sport_center_id"
        case date = "date"
    }
    
    init(sportTypeID: String, sportCenterID: String, date: String) {
        self.sportTypeID = sportTypeID
        self.sportCenterID = sportCenterID
        self.date = date
    }
}
