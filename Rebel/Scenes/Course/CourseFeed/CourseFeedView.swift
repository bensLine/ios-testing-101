import SwiftUI

struct CourseFeedView: View {
	@ObservedObject private var model = CourseFeedViewModel()

	var body: some View {
		List(model.listedCourses) { courseSummary in
			NavigationLink() {
				CourseDetailView(courseSummary: courseSummary, model:  .init(courseId: courseSummary.id))
			} label: {
				CourseThumbnail(courseSummary: courseSummary)
			}
			.swipeActions {
				FavoriteSwipeButton(isFavorite: model.containsFavorite(withId: courseSummary.id)) { _ in
					model.toggleFavorite(withId: courseSummary.id)
				}
			}
		}
		.searchable(text: $model.searchString) {
			ForEach(model.searchSuggestions) { suggestion in
				Text(suggestion.name).searchCompletion(suggestion.name)
			}
		}
		.navigationTitle(Text("Courses"))
		.onAppear {
			model.refresh()
		}
	}
}

struct CourseFeedView_Previews: PreviewProvider {
	static var previews: some View {
		ForEach([ColorScheme.light, .dark], id: \.self) { scheme in
			NavigationView {
				CourseFeedView()
					.navigationTitle(Text("Courses"))
			}
			.preferredColorScheme(scheme)
		}
	}
}
