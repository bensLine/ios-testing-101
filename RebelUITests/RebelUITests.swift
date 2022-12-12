import XCTest

final class RebelUITests: XCTestCase {
	private var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. Called before each test invocation
		app = XCUIApplication()

		// Let our app know that we run UI tests to trigger usage of mock data
		app.launchArguments = [UITesting.launchArgument]
		app.launch()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - e.g.
		// XCUIDevice.shared.orientation = .landscapeLeft
    }

    override func tearDownWithError() throws {
        // Put teardown code here. Called after each test invocation
    }

	func test_favoriteIsAddedAndRemoved_whenCourseSwipedInCourseDetailsAndAgaininFavorites() throws {
		// Course Feed
		let collectionViewsQuery = app.collectionViews
		let gameDesignButton = collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Game Design"]/*[[".cells.buttons[\"Game Design\"]",".buttons[\"Game Design\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		gameDesignButton.tap()

		// Course Details
		let gameDesignNavigationBar = app.navigationBars["Game Design"]
		gameDesignNavigationBar/*@START_MENU_TOKEN@*/.buttons["Love"]/*[[".otherElements[\"Love\"].buttons[\"Love\"]",".buttons[\"Love\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
		gameDesignNavigationBar.buttons["Courses"].tap()

		// Tab Bar
		app.tabBars["Tab Bar"].buttons["Favorites"].tap()

		// Favorites
		waitForElementToAppear(gameDesignButton)
	}

	func test_courseIsInFavoriteList_whenCourseMarkedAsFavoriteInCourseDetails() throws {
		// Course Feed
		let collectionViewsQuery = app.collectionViews
		let gameDesignButton = collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Game Design"]/*[[".cells.buttons[\"Game Design\"]",".buttons[\"Game Design\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		gameDesignButton.swipeLeft()
		gameDesignButton.swipeLeft()

		// Tab Bar
		app.tabBars["Tab Bar"].buttons["Favorites"].tap()

		// Favorites
		waitForElementToAppear(gameDesignButton)
		gameDesignButton.swipeLeft()
		gameDesignButton.swipeLeft()

		let noFavoritesText = app.staticTexts["Add some courses to your favorites!"]
		waitForElementToAppear(noFavoritesText)
	}
}
