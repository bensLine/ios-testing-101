import Foundation

protocol CourseService {
	func curriculum() -> [CourseSummary]
	func course(for courseId: Course.ID) -> Course?
    func allCourseTags() -> [TechTag]
}
