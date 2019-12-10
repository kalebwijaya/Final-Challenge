
import Foundation


class RegisterParam: Codable {
    let fullname, username, phoneNumber, email: String
    let password: String

    enum CodingKeys: String, CodingKey {
        case fullname = "fullname"
        case username = "username"
        case phoneNumber = "phone_number"
        case email = "email"
        case password = "password"
    }

    init(fullname: String, username: String, phoneNumber: String, email: String, password: String) {
        self.fullname = fullname
        self.username = username
        self.phoneNumber = phoneNumber
        self.email = email
        self.password = password
    }
}
