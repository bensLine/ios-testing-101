import Foundation

struct TechTag: Identifiable, Hashable {
	let name: String

	// for simplification we use the name as ID
	var id: String {
		name
	}
}
