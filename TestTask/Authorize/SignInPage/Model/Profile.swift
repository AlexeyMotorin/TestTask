import Foundation

class Profile: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let tradeStore: String?
    let paymentMethod: String?
    let balance: Double?
    let tradeHistory: String?
    let profileImage: String? // тут должна быть сслыка на аватарку
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    
    public enum CodingKeys: String, CodingKey {
        case firstName, lastName, email, tradeStore, paymentMethod, balance, tradeHistory, profileImage
    }
    
    init(firstName: String,
         lastName: String,
         email: String,
         tradeStore: String? = nil,
         paymentMethod: String? = nil,
         balance: Double? = nil,
         tradeHistory: String? = nil,
         profileImage: String? = nil
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.tradeStore = tradeStore
        self.paymentMethod = paymentMethod
        self.balance = balance
        self.tradeHistory = tradeHistory
        self.profileImage = profileImage
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.email = try container.decode(String.self, forKey: .email)
        self.tradeStore = try container.decodeIfPresent(String.self, forKey: .tradeStore)
        self.paymentMethod = try container.decodeIfPresent(String.self, forKey: .paymentMethod)
        self.balance = try container.decodeIfPresent(Double.self, forKey: .balance)
        self.tradeHistory = try container.decodeIfPresent(String.self, forKey: .tradeHistory)
        self.profileImage = try container.decodeIfPresent(String.self, forKey: .profileImage)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(email, forKey: .email)
        try container.encode(tradeStore, forKey: .tradeStore)
        try container.encode(paymentMethod, forKey: .paymentMethod)
        try container.encode(balance, forKey: .balance)
        try container.encode(tradeHistory, forKey: .tradeHistory)
        try container.encode(profileImage, forKey: .profileImage)
    }
}

extension Profile: Equatable {
    static func ==(lhs: Profile, rhs: Profile) -> Bool {
        lhs.firstName == rhs.firstName ? true : false
    }
}
