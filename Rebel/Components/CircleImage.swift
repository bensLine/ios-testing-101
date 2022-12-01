import SwiftUI

struct CircleImage: View {
    var name: String
	var radius: CGFloat?

    var body: some View {
        Image(name)
            .resizable()
			.scaledToFill()
			.frame(width: radius, height: radius)
			.clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
		CircleImage(name: "ML", radius: 200)
    }
}
