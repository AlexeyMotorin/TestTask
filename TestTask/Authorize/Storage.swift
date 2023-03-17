import Foundation
import SwiftKeychainWrapper

/// Класс отвечает за хранение логина и пароля
final class AccountStorage {
    // MARK: Singletone
    static let shared = AccountStorage()
    private init() {}
    
    // MARK: Private enum
    private enum Keys: String, CodingKey {
        case password = "Password"
        case profile = "Profile"
    }
    
    // MARK: Private properties
    private let keyChainWrapper = KeychainWrapper.standard
    private let userDefaults = UserDefaults.standard
    
    // MARK: Public properties
    var password: String? {
        get { keyChainWrapper.string(forKey: Keys.password.rawValue) }
        set {
            guard let newValue else { return }
            let isSucces = keyChainWrapper.set(newValue, forKey: Keys.password.rawValue)
            guard isSucces else {
                assertionFailure("Ошибка записи пароля")
                return
            }
        }
    }
    
    var profile: Profile? {
        get { userDefaults.value(Profile.self, forKey: Keys.profile.rawValue) }
        set {
            guard let newValue else { return }
            let isSucces = userDefaults.set(encodable: newValue, forKey: Keys.profile.rawValue)
            guard isSucces else {
                assertionFailure("Ошибка записи профиля")
                return
            }
        }
    }
    
    func removeAccount() {
        keyChainWrapper.removeObject(forKey: Keys.password.rawValue)
        userDefaults.removeObject(forKey: Keys.profile.rawValue)
    }
}
