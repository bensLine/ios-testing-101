import Foundation
@testable import Rebel

class StudentServiceMock: StudentService {
	var mockedFavoriteCourseIds: Set<String> = Set()

	var favoriteCourseIds: Set<String> {
		mockedFavoriteCourseIds
	}

	func addFavoriteCourse(withId courseId: String) {
		mockedFavoriteCourseIds.insert(courseId)
	}

	func removeFavoriteCourse(withId courseId: String) {
		mockedFavoriteCourseIds.remove(courseId)
	}

	func toggleFavorite(with courseId: Course.ID) {
        if mockedFavoriteCourseIds.contains(courseId) {
            removeFavoriteCourse(withId: courseId)
        } else {
            addFavoriteCourse(withId: courseId)
        }
    }
}

