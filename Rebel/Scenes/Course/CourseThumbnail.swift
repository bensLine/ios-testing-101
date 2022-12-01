import SwiftUI

struct CourseThumbnail: View {
	let courseSummary: CourseSummary

	var body: some View {
		HStack {
			CircleImage(name: courseSummary.imageName, radius: 60)
            Spacer()
                .frame(width: 30)
			Text(courseSummary.title)
				.frame(maxWidth: .infinity, alignment: .leading)
		}
		.padding()
	}
}

struct CourseSummary_Previews: PreviewProvider {
	static var previews: some View {
		CourseThumbnail(courseSummary: CourseSummary(id: "Some Id", title: "Title", tags: ["Tag"], imageName: "ML"))
	}
}
