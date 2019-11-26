//
//  OrderParam.swift
//  Final Challenge
//
//  Created by Kaleb Wijaya on 26/11/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class OrderParam: Codable{
    let userID : String
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
    }
    
    init(userID: String) {
        self.userID = userID
    }
}
