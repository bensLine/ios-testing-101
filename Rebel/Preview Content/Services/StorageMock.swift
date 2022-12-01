import Foundation

class StorageMock: Storage {
	var mockedData: Any?

	private(set) var functionCall_store: FunctionCall?
	private(set) var functionCall_decodable: FunctionCall?

	func store<T: Encodable>(_ encodable: T?, forKey key: String) {
		functionCall_store = FunctionCall(key: key, data: encodable)
		mockedData = encodable
	}

	func decodable<T: Decodable>(forKey key: String, defaultValue: T) -> T {
		functionCall_decodable = FunctionCall(key: key, data: defaultValue)
		return mockedData as? T ?? defaultValue
	}
}

extension StorageMock {
	struct FunctionCall {
		let key: String
		let data: Any?
	}
}
