import SwiftUI

struct CourseDetailView: View {
	@ObservedObject private var model: CourseDetailsViewModel
	let courseSummary: CourseSummary

	init(courseSummary: CourseSummary, model: CourseDetailsViewModel) {
		self.courseSummary = courseSummary
		self.model = model
	}

    var body: some View {
		Group {
			if let course = model.course {
				courseView(for: course)
			} else {
				loadingView()
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
		.navigationBarItems(trailing:
			Button(action: {
				model.toggleFavorite(with: courseSummary.id)
			}, label: {
				Image(systemName: model.isFavorite ? "heart.fill" : "heart")
			})
			.disabled(model.course == nil)
		)
		.navigationTitle(courseSummary.title)
		.navigationBarTitleDisplayMode(.inline)
    }

	func loadingView() -> some View {
		ZStack(alignment: .center) {
			Color.white
				.edgesIgnoringSafeArea(.all)
			Text("Loading..")
				.font(.title2)
		}
	}

	func courseView(for course: Course) -> some View {
		VStack(alignment: .leading) {
            VStack(alignment: .center){
                CircleImage(name:  course.imageName, radius: 140)
                Text(course.title)
                    .font(.title)
                HStack {
                    ForEach(course.tags, id: \.self) { tag in
                        Tag(text: tag)
                    }
                }
                Spacer()
                    .frame(height: 30)
                Text(course.description)
            }
			VStack(alignment: .leading, spacing: 10) {
				Text("🗓️ Timetable")
					.font(.title3)
					.padding(.top)
				ForEach(course.timetable, id: \.self) { timetable in
					Text("\(timetable.day), \(timetable.startTime) - \(timetable.endTime)")
						.foregroundColor(.accentColor)
						.padding(.horizontal)
				}
			}
			Text("🎤 Lecturer: \(course.lecturer)")
				.font(.headline)
				.padding(.top)
		}
		.padding()
	}
}

struct CourseDetailView_Previews: PreviewProvider {
    static var previews: some View {
		// Exercise: Get this preview running to display a course
		let courseSummary: CourseSummary = .softwarePatterns
		CourseDetailView(courseSummary: courseSummary, model: .init(courseId: courseSummary.id))
    }
}
