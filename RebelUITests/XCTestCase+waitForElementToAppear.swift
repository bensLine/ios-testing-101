import XCTest
import Foundation

extension XCTestCase {
	/// credits https://masilotti.com/xctest-helpers/
	func waitForElementToAppear(_ element: XCUIElement, timeout: Double = 5, file: String = #file, line: UInt = #line) {
		let existsPredicate = NSPredicate(format: "exists == true")
		expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
		waitForExpectations(timeout: timeout, handler: nil)
	}
}
