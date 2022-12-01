import Foundation
import SwiftUI

struct CourseSummary: Identifiable, Codable, Hashable {
	let id: String
	let title: String
	let tags: [String]
    let imageName: String
}
