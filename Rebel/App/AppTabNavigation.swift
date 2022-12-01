import SwiftUI

struct AppTabNavigation: View {
	enum Tab {
		case home
		case favorites
	}

	@State private var selection: Tab = .home

	var body: some View {
		TabView(selection: $selection) {
			NavigationView {
				CourseFeedView()
			}
			.tabItem {
				Label {
					Text("Home")
				} icon: {
					Image(systemName: "list.bullet")
				}
			}
			.tag(Tab.home)

			NavigationView {
				FavoritesView()
			}
			.tabItem {
				Label {
					Text("Favorites")
				} icon: {
					Image(systemName: "heart.fill")
				}
			}
			.tag(Tab.favorites)
		}
	}
}

struct AppTabNavigation_Previews: PreviewProvider {
	static var previews: some View {
		AppTabNavigation()
	}
}
