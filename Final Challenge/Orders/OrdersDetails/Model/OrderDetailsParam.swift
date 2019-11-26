//
//  OrderDetailsParam.swift
//  Final Challenge
//
//  Created by Kaleb Wijaya on 26/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class OrderDetailsParam: Codable{
    
    let bookID,userID: String
    
    enum CodingKeys: String, CodingKey {
        case bookID = "sport_type_id"
        case userID = "sport_center_id"
    }
    
    init(bookID: String , userID: String) {
        self.bookID = bookID
        self.userID = userID
    }
}
