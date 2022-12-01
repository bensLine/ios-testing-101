import Foundation

import XCTest
@testable import Rebel

final class UserDefaultsStorageTests: XCTestCase {
	/// The identifier of our UserDefaults object for testing - we do not want to use the standard one!
	private static let domainName = "com.example.netlight-samplecode.RebelTests"
	private var sut: UserDefaults!  // System Under Test

	override func setUp() {
		sut = UserDefaults(suiteName: Self.domainName)
	}

	override func tearDown() {
		// Make sure all data from previous tests is removed to have the same state in each test and run
		sut.removePersistentDomain(forName: Self.domainName)
		sut.synchronize()
	}

	func test_jsonObjectIsStoredInUserDefaults_whenStoreIsCalled() throws {
		// GIVEN
		let key = "store_key"
		let testObject = "testObject"

		// WHEN
		sut.store(testObject, forKey: key)

		// THEN
		let storedData = sut.data(forKey: key) ?? Data()
		let storedString = (try? JSONDecoder().decode(String.self, from: storedData)) ?? ""
		XCTAssertEqual(storedString, testObject)
	}

	func test_jsonObjectIsReadFromUserDefaults_whenDecodableIsCalled() throws {
		// GIVEN
		let key = "read_key"
		let testObject = "testObject"
		let dataToStore = (try? JSONEncoder().encode(testObject)) ?? Data()
		sut.set(dataToStore, forKey: key)

		// WHEN
		let actualObject = sut.decodable(forKey: key, defaultValue: "default")

		// THEN
		XCTAssertEqual(actualObject, testObject)
	}
}
