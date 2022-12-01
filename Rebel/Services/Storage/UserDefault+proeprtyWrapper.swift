import Foundation
import Factory

@propertyWrapper
public struct UserDefault<T: Codable> {
	private let key: String
	private let defaultValue: T

	@Injected(Container.storage) private var storage

	public init(key: String, defaultValue: T) {
		self.key = key
		self.defaultValue = defaultValue
	}

	public var wrappedValue: T {
		get {
			storage.decodable(forKey: key, defaultValue: defaultValue)
		}
		set {
			storage.store(newValue, forKey: key)
		}
	}
}
