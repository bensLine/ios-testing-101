import Foundation

class StudentServiceImpl: StudentService {
	@UserDefault(key: "favorite_course_ids", defaultValue: Set<String>())
	private(set) var favoriteCourseIds: Set<String>

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
