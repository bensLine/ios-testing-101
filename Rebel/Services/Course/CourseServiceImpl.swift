import Foundation

class CourseServiceImpl: CourseService {
	private lazy var coursesMap: [Course.ID: Course] = {
		guard let url = Bundle.main.url(forResource: "courses", withExtension: "json") else {
			NSLog("❌ Get courses.json url failed")
			return [:]
		}

		do {
			let data = try Data(contentsOf: url)
			let jsonDecoder = JSONDecoder()
			let courses = try jsonDecoder.decode([Course].self, from: data)

			return courses.reduce(into: [:]) { dictionary, item in
				dictionary[item.id] = item
			}
		} catch {
			NSLog("❌ Read courses: \(error)")
			return [:]
		}
	}()

	func curriculum() -> [CourseSummary] {
		coursesMap.values.map { course in
            CourseSummary(id: course.id, title: course.title, tags: course.tags, imageName: course.imageName)
		}
	}
    
    func allCourseTags() -> [TechTag] {
		var tags: Set<TechTag> = .init()
        coursesMap.values.forEach { course in
            course.tags.forEach { tag in
                tags.insert(TechTag(name: tag))
            }
        }
		return Array(tags)
    }

	func course(for courseId: Course.ID) -> Course? {
		coursesMap[courseId]
	}
}
