import XCTest
@testable import Rebel
import Factory

final class CourseFeedViewModelIntegrationTests: XCTestCase {
	private var sut: CourseFeedViewModel!  // System Under Test
	private var storage: StorageMock!

	override func setUp() {
		storage = StorageMock()

		// Overwrite dependency registration of default implementation with our mock
		Container.storage.register { self.storage }

		// StudentService will load our just registered StorageMock now
		let realStudentService = StudentServiceImpl()
		let courseService = CourseServiceMock()

		sut = CourseFeedViewModel(courseService: courseService, studentService: realStudentService)
	}

	// MARK: Integration tests with "real" Student Service

	func test_courseIsStoredAsFavorite_whenCourseWasToggledAndNotInFavorites() {
		// GIVEN
		let favoriteId = "iPraktikum"

		// WHEN
		sut.toggleFavorite(withId: favoriteId)

		// THEN
		XCTAssertEqual(storage.mockedData as? Set<String>, Set([favoriteId]))
	}

	func test_courseIsNotStoredAsFavorites_whenCourseWasToggledTwiceAndNotInFavorites() {
		// GIVEN
		let courseId = "Lame course"

		// WHEN
		sut.toggleFavorite(withId: courseId)
		sut.toggleFavorite(withId: courseId)

		// THEN
		XCTAssertEqual(storage.mockedData as? Set<String>, Set([]))
	}
}
