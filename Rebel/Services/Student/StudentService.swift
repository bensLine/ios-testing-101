import Foundation

protocol StudentService {
	var favoriteCourseIds: Set<String> { get }

	func addFavoriteCourse(withId courseId: String)
	func removeFavoriteCourse(withId courseId: String)
	func toggleFavorite(with courseId: Course.ID)
}
