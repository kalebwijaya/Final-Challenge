//
//  ProfileParam.swift
//  Final Challenge
//
//  Created by Steven on 12/13/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class ProfileParam: Codable{
    let id, fullname, phoneNumber, oldPassword: String
    let password: String

    enum CodingKeys: String, CodingKey {
        case id, fullname
        case phoneNumber = "phone_number"
        case oldPassword = "old_password"
        case password
    }

    init(id: String, fullname: String, phoneNumber: String, oldPassword: String, password: String) {
        self.id = id
        self.fullname = fullname
        self.phoneNumber = phoneNumber
        self.oldPassword = oldPassword
        self.password = password
    }
}
