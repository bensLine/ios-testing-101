import SwiftUI

struct Tag: View {
	let text: String

    var body: some View {
		Text(text.uppercased())
			.fontWeight(.light)
			.padding(.horizontal, 16)
			.padding(.vertical, 5)
			.background(Color.white)
			.cornerRadius(6)
			.foregroundColor(.accentColor)
			.overlay(Capsule().stroke(Color.accentColor, lineWidth: 1))
    }
}

struct Tag_Previews: PreviewProvider {
    static var previews: some View {
		HStack {
			Tag(text: "Testing")
			Tag(text: "Data")
			Tag(text: "ML")
		}
    }
}
