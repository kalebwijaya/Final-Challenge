//
//  LoginData.swift
//  Final Challenge
//
//  Created by Michael Louis on 09/12/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import Foundation

class LoginData: Codable {
    let id: Double
    let fullname, username, phoneNumber, email: String

    enum CodingKeys: String, CodingKey {
        case id, fullname, username
        case phoneNumber = "phone_number"
        case email
    }

    init(id: Double, fullname: String, username: String, phoneNumber: String, email: String) {
        self.id = id
        self.fullname = fullname
        self.username = username
        self.phoneNumber = phoneNumber
        self.email = email
    }
}
