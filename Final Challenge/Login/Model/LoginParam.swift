import Foundation

// MARK: - LoginResponses
class LoginParam: Codable {
    let id, password: String
    
    
    init(id: String, password: String) {
        self.id = id
        self.password = password
    }
}
