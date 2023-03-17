import Foundation
import SwiftKeychainWrapper

/// Класс отвечает за хранение логина и пароля
final class AccountStorage {
    // MARK: Singletone
    static let shared = AccountStorage()
    private init() {}
    
    // MARK: Private enum
    private enum Keys: String {
        case password = "Password"
        case firstName = "First name"
    }
    
    // MARK: Private properties
    private let keyChainWrapper = KeychainWrapper.standard
    
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
    
    var firstName: String? {
        get { keyChainWrapper.string(forKey: Keys.firstName.rawValue) }
        set {
            guard let newValue else { return }
            let isSucces = keyChainWrapper.set(newValue, forKey: Keys.firstName.rawValue)
            guard isSucces else {
                assertionFailure("Ошибка записи имени")
                return
            }
        }
    }
    
    func removeAccount() {
        KeychainWrapper.standard.removeObject(forKey: Keys.password.rawValue)
        KeychainWrapper.standard.removeObject(forKey: Keys.firstName.rawValue)
    }
}
