import XCTest
import SnapshotTesting
@testable import Rebel
import SwiftUI

final class CourseDetailViewTests: XCTestCase {
	private var sut: CourseDetailView! // System Under Test
	private var viewModel: CourseDetailsViewModel!
	private var courseService: CourseServiceMock!
	private var studentService: StudentServiceMock!

	override func setUp() {
		courseService = CourseServiceMock()
		studentService = StudentServiceMock()
	}
	
    func test_loadingIsShown_whenCourseNotFetched() throws {
		courseService.mockedCourse = nil
		viewModel = CourseDetailsViewModel(courseId: "any", courseService: courseService, studentService: studentService)

		sut = CourseDetailView(courseSummary: .softwarePatterns, model: viewModel)
		expectSnapshot(matching: sut)
    }

	func test_detailsAreShown_whenCourseWasFetched() throws {
		courseService.mockedCourse = .softwarePatterns
		viewModel = CourseDetailsViewModel(courseId: "any", courseService: courseService, studentService: studentService)

		sut = CourseDetailView(courseSummary: .softwareTesting, model: viewModel)
		let navView = NavigationView { sut }
		expectSnapshot(matching: navView)
	}

	func test_detailsAreMarkedAsFavorite_whenCourseIsInFavorites() throws {
		let favoriteCourse: Course = .softwarePatterns
		courseService.mockedCourse = favoriteCourse
		studentService.mockedFavoriteCourseIds.insert(favoriteCourse.id)
		viewModel = CourseDetailsViewModel(courseId: favoriteCourse.id,
										   courseService: courseService,
										   studentService: studentService)

		sut = CourseDetailView(courseSummary: .softwarePatterns, model: viewModel)
		let navView = NavigationView { sut }
		expectSnapshot(matching: navView)
	}
}
