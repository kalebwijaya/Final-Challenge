
import Foundation

class RegisterResponse: Codable {
    let errorCode, errorMessage: String

    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_message"
    }

    init(errorCode: String, errorMessage: String) {
        self.errorCode = errorCode
        self.errorMessage = errorMessage
    }
}


