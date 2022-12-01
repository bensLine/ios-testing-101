import Foundation

import XCTest
@testable import Rebel
import Factory

final class CourseFeedViewModelTests: XCTestCase {
	private var sut: CourseFeedViewModel!  // System Under Test
//	private var courseService: CourseServiceMock!
//	private var studentService: StudentServiceMock!
//
//	func setUpWithData(initialCourses: [CourseSummary] = [], initialTags: [TechTag] = []) {
//		studentService = StudentServiceMock()
//		courseService = CourseServiceMock()
//
//		// Data needs to be defined before it is fetched from the VM
//		courseService.mockedCourseSummaries = initialCourses
//		courseService.mockedCourseTags = initialTags
//
//		sut = CourseFeedViewModel(courseService: courseService, studentService: studentService)
//		sut.refresh()
//	}

	func test_listedCoursesAreFiltered_whenCourseTitleContainsSearchString() throws {
		throw XCTSkip("not tested - show us!")
	}

	func test_searchSuggestionsAreShown_whenSearchStringIsContainedInTag() throws {
		throw XCTSkip("not tested - heeeelp!")
	}

	func test_searchSuggestionIsNotShown_whenSearchStringAndTagMatchExactly() throws {
		throw XCTSkip("not tested - heeeelp!")
	}

	// MARK: Bonus

	func test_objectWillChangeGetsPublished_whenFavoriteIsToggled() throws {
		throw XCTSkip("not tested - show us!")
	}

	func test_searchStringGetsPublished_whenSearchStringValueChanges() throws {
		throw XCTSkip("not tested - bonus, go head!")
	}
}
