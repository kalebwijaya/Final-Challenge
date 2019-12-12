
import Foundation

// MARK: - LoginResponses
class LoginResponses: Codable {
    let errorCode, errorMessage: String
    let data: LoginData
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_message"
        case data
        
    }

    init(errorCode: String, errorMessage: String,data: LoginData) {
        self.errorCode = errorCode
        self.errorMessage = errorMessage
        self.data = data
        
    }
}

