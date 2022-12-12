import Foundation

import XCTest
@testable import Rebel

final class CourseDetailsViewModelTests: XCTestCase {
    private var sut: CourseDetailsViewModel!  // System Under Test
    private var studentService: StudentServiceMock!
	private var courseService: CourseServiceMock!

    override func setUp() {
        studentService = StudentServiceMock()
		courseService = CourseServiceMock()
		sut = CourseDetailsViewModel(courseId: "iPraktikum", courseService: courseService, studentService: studentService)
	}

	func test_objectWillChangeGetsPublished_whenFavoriteIsToggled() throws {
		// GIVEN
		courseService.mockedCourseSummaries = [.softwarePatterns]
		let sinkExpectation = expectation(description: "objectWillChange was published")

		let cancellable = sut.objectWillChange.sink {
			sinkExpectation.fulfill()
		}

		// WHEN
		sut.toggleFavorite(with: CourseSummary.softwarePatterns.id)

		// THEN
		wait(for: [sinkExpectation], timeout: 3)
		cancellable.cancel()
	}

    func test_toggleAddsCourseToFavorites_whenCourseWasNotFavorite() throws {
        // GIVEN
        let courseId = "iPraktikum"
        
        // WHEN
        sut.toggleFavorite(with: courseId)

        // THEN
        XCTAssertTrue(studentService.favoriteCourseIds.contains(courseId))
    }
    
    func test_toggleRemovesCourseFromFavorites_whenCourseWasFavorite() throws {
        // GIVEN
		let courseId = "iPraktikum"
        studentService.addFavoriteCourse(withId: courseId)
        
        // WHEN
        sut.toggleFavorite(with: courseId)

        // THEN
        XCTAssertFalse(studentService.favoriteCourseIds.contains(courseId))
		XCTAssertTrue(studentService.favoriteCourseIds.isEmpty)
    }
    
    func test_toggleUpdatesIsFavorite_whenCourseWasNotFavorite() throws {
        // GIVEN
        let courseId = "iPraktikum"
        
        // WHEN
        sut.toggleFavorite(with: courseId)

        // THEN
        XCTAssertTrue(sut.isFavorite)
    }
    
    func test_toggleUpdatesIsFavorite_whenCourseWasFavorite() throws {
        // GIVEN
        let courseId = "iPraktikum"
        studentService.addFavoriteCourse(withId: courseId)
        
        // WHEN
        sut.toggleFavorite(with: courseId)

        // THEN
        XCTAssertFalse(sut.isFavorite)
    }
}
