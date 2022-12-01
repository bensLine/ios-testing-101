import Foundation

class FavoritesViewModel: ObservableObject {
	private(set) var courseSummaries: [CourseSummary] = []
	private let courseService: CourseService
	private let studentService: StudentService

	init(courseService: CourseService = CourseServiceImpl(), studentService: StudentService = StudentServiceImpl()) {
		self.courseService = courseService
		self.studentService = studentService
	}

	func refresh() {
		courseSummaries = courseService.curriculum()
			.filter { studentService.favoriteCourseIds.contains($0.id) }
			.sorted(by: { $0.title.localizedCompare($1.title) == .orderedAscending })

		objectWillChange.send()
	}

	func toggleFavorite(with courseId: Course.ID) {
		studentService.toggleFavorite(with: courseId)
		refresh()
	}
}
