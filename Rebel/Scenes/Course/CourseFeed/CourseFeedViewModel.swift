import Foundation

class CourseFeedViewModel: ObservableObject {
	@Published var searchString = ""

	private(set) var courseSummaries: [CourseSummary] = []
	private let courseService: CourseService = CourseServiceImpl()
	private let studentService: StudentService = StudentServiceImpl()

	var listedCourses: [CourseSummary] {
		courseSummaries
			.filter { $0.matches(searchString) }
			.sorted(by: { $0.title.localizedCompare($1.title) == .orderedAscending })
	}

	var searchSuggestions: [TechTag] {
        courseService.allCourseTags().filter {
			$0.name.localizedCaseInsensitiveContains(searchString) &&
			$0.name.localizedCaseInsensitiveCompare(searchString) != .orderedSame
		}
	}

	func toggleFavorite(withId courseId: Course.ID) {
		studentService.toggleFavorite(with: courseId)
		objectWillChange.send()
	}

	func containsFavorite(withId courseId: Course.ID) -> Bool {
		studentService.favoriteCourseIds.contains(courseId)
	}

	func course(for courseId: Course.ID) -> Course? {
		courseService.course(for: courseId)
	}

	func refresh() {
		courseSummaries = courseService.curriculum()
		objectWillChange.send()
	}
}

extension CourseSummary {
	func matches(_ string: String) -> Bool {
		return string.isEmpty
		|| title.localizedCaseInsensitiveContains(string)
		|| tags.contains { $0.localizedCaseInsensitiveContains(string) }
	}
}
