import Factory
import Foundation

/// Register dependencies with default implementations
extension Container {
	static let storage = Factory<Storage>(scope: .shared) { UserDefaults.standard }
}

extension Container {
	static func registerUITestDependencies() {
		Container.storage.register { StorageMock() }

		NSLog("⚡️Registered UI-Testing dependencies")
	}
}
