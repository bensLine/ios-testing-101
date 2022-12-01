import Foundation
import SwiftUI
import Factory

@main
struct RebelApp: App {

	init() {
		let libraryDirectory = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first
		NSLog("Started app, libraryDirectory: \(libraryDirectory?.absoluteString ?? "nil")")

		guard CommandLine.arguments.contains(UITesting.launchArgument) else { return }
		Container.registerUITestDependencies()
	}

    var body: some Scene {
		WindowGroup {
			if isRunningUnitTests {
				testingContent
			} else {
				appContent
			}
		}
    }

	private var appContent: some View {
		AppTabNavigation()
	}

	/// do not load normal app views, view models, services and so on if we're running unit tests
	/// instead use a placeholder without further dependencies.
	private var testingContent: some View {
		ZStack {
			Color.black
				.edgesIgnoringSafeArea(.all)
			Text("🛠️ Testing...")
				.foregroundColor(.green)
				.font(.title2)
		}
	}
}


extension RebelApp {
	private var isRunningUnitTests: Bool {
		NSClassFromString("XCTest") != nil
	}
}
