import Foundation

struct Course: Identifiable, Codable {
	let id: String
	let title: String
	let lecturer: String
	let description: AttributedString
	let timetable: [Timeslot]
	let tags: [String]
    let imageName: String
}

extension Course {
	static let item0 = Course(id: "0", title: "Orange", lecturer: "Dr. Evil", description: "fruity", timetable: [], tags: [], imageName: "ML")
	static let item1 = Course(id: "1", title: "Rock", lecturer: "Dr. Evil", description: "dance", timetable: [], tags: [], imageName: "ML")
	static let item2 = Course(id: "2", title: "Plant", lecturer: "Dr. Evil", description: "green", timetable: [], tags: [], imageName: "ML")
	static let item3 = Course(id: "3", title: "Chair", lecturer: "Dr. Evil", description: "comfy", timetable: [], tags: [], imageName: "ML")

	static let all: [Course] = [
		.item0,
		.item1,
		.item2,
		.item3,
	]
}

