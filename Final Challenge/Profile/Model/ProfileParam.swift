//
//  ProfileParam.swift
//  Final Challenge
//
//  Created by Steven on 12/13/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class ProfileParam: Codable{
    let id, fullname, phoneNumber: String

    enum CodingKeys: String, CodingKey {
        case id, fullname
        case phoneNumber = "phone_number"
      
    }

    init(id: String, fullname: String, phoneNumber: String) {
        self.id = id
        self.fullname = fullname
        self.phoneNumber = phoneNumber
        
    }
}
