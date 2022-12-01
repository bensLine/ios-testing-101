import SwiftUI

struct FavoriteSwipeButton: View {
	let isFavorite: Bool
	let favoriteChangedTo: (Bool) -> (Void)

	var body: some View {
		Button {
			withAnimation {
				favoriteChangedTo(isFavorite)
			}
		} label: {
			Image(systemName: isFavorite ? "heart.slash.fill" : "heart")
		}
		.tint(isFavorite ? .red : .accentColor)
	}
}

struct FavoriteSwipeView_Previews: PreviewProvider {
	static var previews: some View {
		HStack {
			FavoriteSwipeButton(isFavorite: false, favoriteChangedTo: { _ in })
			FavoriteSwipeButton(isFavorite: true, favoriteChangedTo: { _ in })
		}
	}
}
