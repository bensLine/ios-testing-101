import Foundation

import XCTest
@testable import Rebel
import Factory

final class CourseFeedViewModelTests: XCTestCase {
	private var sut: CourseFeedViewModel!  // System Under Test
	private var courseService: CourseServiceMock!
	private var studentService: StudentServiceMock!

	func setUpWithData(initialCourses: [CourseSummary] = [], initialTags: [TechTag] = []) {
		studentService = StudentServiceMock()
		courseService = CourseServiceMock()
		courseService.mockedCourseSummaries = initialCourses
		courseService.mockedCourseTags = initialTags

		sut = CourseFeedViewModel(courseService: courseService, studentService: studentService)
		sut.refresh()
	}

	func test_listedCoursesAreFiltered_whenCourseTitleContainsSearchString() {
		// GIVEN
		setUpWithData(initialCourses: [.softwarePatterns, .softwareTesting])

		// WHEN
		sut.searchString = "Patterns"

		// THEN
		XCTAssertEqual(sut.listedCourses.count, 1)
		XCTAssertEqual(sut.listedCourses, [.softwarePatterns])
	}

	func test_listedCoursesAreFiltered_whenCourseTitleExactlyMatchesSearchString() {
		// GIVEN
		setUpWithData(initialCourses: [.softwarePatterns, .softwareTesting])

		// WHEN
		sut.searchString = CourseSummary.softwarePatterns.title

		// THEN
		XCTAssertEqual(sut.listedCourses.count, 1)
		XCTAssertEqual(sut.listedCourses, [.softwarePatterns])
	}

	func test_listedCoursesAreFiltered_whenCourseTagsContainsOrMatchesSearchString() {
		// GIVEN
		setUpWithData(initialCourses: [.softwarePatterns, .softwareTesting])

		// WHEN
		sut.searchString = "DI"

		// THEN
		XCTAssertEqual(sut.listedCourses.count, 1)
		XCTAssertEqual(sut.listedCourses, [.softwarePatterns])
	}

	func test_noCoursesAreShown_whenSearchStringDoesntMatchCourseTitleOrTags() {
		// GIVEN
		setUpWithData(initialCourses: [.softwarePatterns, .softwareTesting])

		// WHEN
		sut.searchString = "Tag3"

		// THEN
		XCTAssertEqual(sut.listedCourses.count, 0)
	}

	func test_searchSuggestionsAreShown_whenSearchStringIsContainedInTag() {
		// GIVEN
		setUpWithData(initialTags: [.init(name: "Tag1"), .init(name: "Tag2")])

		// WHEN
		sut.searchString = "Tag"

		// THEN
		XCTAssertEqual(sut.searchSuggestions.count, 2)
	}

	func test_searchSuggestionIsNotShown_whenSearchStringAndTagMatchExactly() {
		// GIVEN
		let softwarePatternTag = TechTag(name: "Software Pattern")
		setUpWithData(initialTags: [softwarePatternTag, TechTag(name: "Pattern")])

		// WHEN
		sut.searchString = "Pattern"

		// THEN
		XCTAssertEqual(sut.searchSuggestions.count, 1)
		XCTAssertEqual(sut.searchSuggestions, [softwarePatternTag])
	}

	// MARK: Bonus

	func test_objectWillChangeGetsPublished_whenFavoriteIsToggled() throws {
		// GIVEN
		setUpWithData()
		let sinkExpectation = expectation(description: "objectWillChange was published")

		let cancellable = sut.objectWillChange.sink {
			sinkExpectation.fulfill()
		}

		// WHEN
		sut.toggleFavorite(withId: "some id")

		// THEN
		wait(for: [sinkExpectation], timeout: 3)
		cancellable.cancel()
	}

	func test_searchStringGetsPublished_whenSearchStringValueChanges() throws {
		// GIVEN
		setUpWithData()
		let expectedSearchString = "Testy test"
		let sinkExpectation = expectation(description: "searchString is published")
		let cancellable = sut.$searchString
			.dropFirst()
			.sink { value in
				XCTAssertEqual(value, expectedSearchString)
				sinkExpectation.fulfill()
			}

		// WHEN
		sut.searchString = expectedSearchString

		// THEN
		wait(for: [sinkExpectation], timeout: 3)
		cancellable.cancel()
	}
}
