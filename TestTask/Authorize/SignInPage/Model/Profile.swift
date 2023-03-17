import Foundation

class Profile: Codable {
    let firstName: String
    let lastName: String
    let email: String
    
    public enum CodingKeys: String, CodingKey {
        case firstName, lastName, email
    }
    
    init(firstName: String, lastName: String, email: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.email = try container.decode(String.self, forKey: .email)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(email, forKey: .email)
    }
}

extension Profile: Equatable {
    static func ==(lhs: Profile, rhs: Profile) -> Bool {
        lhs.firstName == rhs.firstName ? true : false
    }
}
