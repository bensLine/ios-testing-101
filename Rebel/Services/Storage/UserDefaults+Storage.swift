import Foundation

extension UserDefaults: Storage {
	func store<T: Encodable>(_ encodable: T?, forKey key: String) {
		let data = try? JSONEncoder().encode(encodable)
		set(data, forKey: key)
	}

	func decodable<T: Decodable>(forKey key: String, defaultValue: T) -> T {
		guard let data = object(forKey: key) as? Data else {
			return defaultValue
		}

		guard let value = try? JSONDecoder().decode(T.self, from: data) else {
			return defaultValue
		}

		return value
	}
}
