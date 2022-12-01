import SwiftUI

struct FavoritesView: View {
	@ObservedObject private var model = FavoritesViewModel()

	var body: some View {
		List(model.courseSummaries) { courseSummary in
			NavigationLink() {
				CourseDetailView(courseSummary: courseSummary, model:  .init(courseId: courseSummary.id))
			} label: {
				CourseThumbnail(courseSummary: courseSummary)
			}
			.swipeActions {
				FavoriteSwipeButton(isFavorite: true) { _ in
					model.toggleFavorite(with: courseSummary.id)
				}
			}
		}
		.overlay {
			if model.courseSummaries.isEmpty {
				Text("Add some courses to your favorites!")
					.foregroundStyle(.secondary)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.background()
					.ignoresSafeArea()
			}
		}
		.navigationTitle(Text("Favorites"))
		.onAppear {
			model.refresh()
		}
	}
}

struct FavoritesView_Previews: PreviewProvider {
	static var previews: some View {
		FavoritesView()
	}
}
