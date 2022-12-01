import Foundation

class CourseDetailsViewModel: ObservableObject {
	@Published private(set) var course: Course?

	private let courseId: Course.ID
	private let courseService: CourseService
	private let studentService: StudentService

	init(courseId: Course.ID, courseService: CourseService = CourseServiceImpl(), studentService: StudentService = StudentServiceImpl()) {
		self.courseId = courseId
		self.courseService = courseService
		self.studentService = studentService

		course = courseService.course(for: courseId)
	}

	func toggleFavorite(with courseId: Course.ID) {
		studentService.toggleFavorite(with: courseId)
		objectWillChange.send()
	}

	var isFavorite: Bool {
		studentService.favoriteCourseIds.contains(courseId)
	}
}
