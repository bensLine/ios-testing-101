import Foundation

class StudentServiceImpl: StudentService {
	private(set) var favoriteCourseIds: Set<String> = .init()

	func addFavoriteCourse(withId courseId: String) {
		favoriteCourseIds.insert(courseId)
	}

	func removeFavoriteCourse(withId courseId: String) {
		favoriteCourseIds.remove(courseId)
	}

	func toggleFavorite(with courseId: Course.ID) {
		if favoriteCourseIds.contains(courseId) {
			removeFavoriteCourse(withId: courseId)
		} else {
			addFavoriteCourse(withId: courseId)
		}
	}
}
