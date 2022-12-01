import Foundation

import XCTest
@testable import Rebel

final class CourseDetailsViewModelTests: XCTestCase {
    private var sut: CourseDetailsViewModel!  // System Under Test
    private var studentService: StudentServiceMock!
    
    private let testCourse = CourseSummary(id: "the one and only", title: "Testy test", tags: ["Tag1", "Tag2"], imageName: "TestImage")
    
    override func setUp() {
        studentService = StudentServiceMock()
        sut = CourseDetailsViewModel(courseId: testCourse.id, studentService: studentService)
    }
    
    func test_toggleAddsCourseToFavorites_whenCourseWasNotFavorite() throws {
        // GIVEN
        let courseId = testCourse.id
        
        // WHEN
        sut.toggleFavorite(with: courseId)

        // THEN
        XCTAssertTrue(studentService.favoriteCourseIds.contains(testCourse.id))
    }
    
    func test_toggleRemovesCourseFromFavorites_whenCourseWasFavorite() throws {
        // GIVEN
        let courseId = testCourse.id
        studentService.addFavoriteCourse(withId: courseId)
        
        // WHEN
        sut.toggleFavorite(with: courseId)

        // THEN
        XCTAssertFalse(studentService.favoriteCourseIds.contains(testCourse.id))
		XCTAssertTrue(studentService.favoriteCourseIds.isEmpty)
    }
    
    func test_toggleUpdatesIsFavorite_whenCourseWasNotFavorite() throws {
        // GIVEN
        let courseId = testCourse.id
        
        // WHEN
        sut.toggleFavorite(with: courseId)

        // THEN
        XCTAssertTrue(sut.isFavorite)
    }
    
    func test_toggleUpdatesIsFavorite_whenCourseWasFavorite() throws {
        // GIVEN
        let courseId = testCourse.id
        studentService.addFavoriteCourse(withId: courseId)
        
        // WHEN
        sut.toggleFavorite(with: courseId)

        // THEN
        XCTAssertFalse(sut.isFavorite)
    }
}
