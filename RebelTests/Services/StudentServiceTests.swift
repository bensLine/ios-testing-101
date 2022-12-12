import Foundation

import XCTest
import Factory
@testable import Rebel

final class StudentServiceTests: XCTestCase {
	private var sut: StudentServiceImpl!  // System Under Test
	private var storage: StorageMock!

	private let testCourseId = "the one and only ID"

	func setUpWithStorageMock(initialData: Any? = nil) {
		storage = StorageMock()
		storage.mockedData = initialData

		// Overwrite dependency registration of default implementation with our mock
		Container.storage.register { self.storage }
		sut = StudentServiceImpl()
	}

	// MARK: Unit Tests

	func test_courseIsAddedToFavoritesData_whenCourseWasNotFavorite() throws {
		// GIVEN
		setUpWithStorageMock()

		// WHEN
		sut.addFavoriteCourse(withId: testCourseId)

		// THEN
		XCTAssertTrue(sut.favoriteCourseIds.contains(testCourseId))
	}

	func test_courseIsRemovedFromFavoritesData_whenCourseWasInFavorites() throws {
		// GIVEN
		setUpWithStorageMock(initialData: Set<String>([testCourseId]))

		// WHEN
		sut.removeFavoriteCourse(withId: testCourseId)

		// THEN
		XCTAssertTrue(sut.favoriteCourseIds.isEmpty)
	}

	func test_courseIsAddedToFavoritesData_whenCourseWasToggledAndNotFavorite() throws {
		// GIVEN
		setUpWithStorageMock()

		// WHEN
		sut.toggleFavorite(with: testCourseId)

		// THEN
		XCTAssertTrue(sut.favoriteCourseIds.contains(testCourseId))
	}

	func test_courseIsRemovedFromFavoritesData_whenCourseWasToggledAndInFavorites() throws {
		// GIVEN
		setUpWithStorageMock(initialData: Set<String>([testCourseId]))

		// WHEN
		sut.toggleFavorite(with: testCourseId)

		// THEN
		XCTAssertTrue(sut.favoriteCourseIds.isEmpty)
	}

	// MARK: Integration Tests

	func test_favoritesAreReadFromStorage_whenFavoritesAreAccessed() throws {
		// GIVEN
		setUpWithStorageMock()

		// WHEN
		_ = sut.favoriteCourseIds

		// THEN
		XCTAssertNotNil(storage.functionCall_decodable)
		XCTAssertEqual(storage.functionCall_decodable?.key, "favorite_course_ids")
	}

	func test_favoritesAreStoredInStorage_whenFavoriteIsAdded() throws {
		// GIVEN
		setUpWithStorageMock()

		// WHEN
		sut.addFavoriteCourse(withId: testCourseId)

		// THEN
		XCTAssertNotNil(storage.functionCall_store)
		XCTAssertEqual(storage.functionCall_store?.key, "favorite_course_ids")
	}

	func test_favoritesAreStoredInStorage_whenFavoriteIsRemoved() throws {
		// GIVEN
		setUpWithStorageMock(initialData: Set<String>([testCourseId]))

		// WHEN
		sut.removeFavoriteCourse(withId: testCourseId)

		// THEN
		XCTAssertNotNil(storage.functionCall_store)
		XCTAssertEqual(storage.functionCall_store?.key, "favorite_course_ids")
	}
}
