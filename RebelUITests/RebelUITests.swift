import XCTest

final class RebelUITests: XCTestCase {
	private var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. Called before each test invocation

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - e.g.
		// XCUIDevice.shared.orientation = .landscapeLeft
    }

    override func tearDownWithError() throws {
        // Put teardown code here. Called after each test invocation
    }

	func test_favoriteIsAddedAndRemoved_whenCourseSwipedInCourseDetailsAndAgaininFavorites() throws {
		throw XCTSkip("not tested - show us!")
	}

	func test_courseIsInFavoriteList_whenCourseMarkedAsFavoriteInCourseDetails() throws {
		throw XCTSkip("not tested - heeeelp!")
	}
}
