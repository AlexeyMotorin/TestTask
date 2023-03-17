import Foundation

extension UserDefaults {
    func set<T: Encodable>(encodable: T, forKey key: String ) -> Bool {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
            return true
        } else {
            return false
        }
    }
    
    func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data,
           let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
}
