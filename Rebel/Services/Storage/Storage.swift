import Foundation

protocol Storage {
	func store<T: Encodable>(_ encodable: T?, forKey key: String)
	func decodable<T: Decodable>(forKey key: String, defaultValue: T) -> T
}
