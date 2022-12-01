import XCTest
import SnapshotTesting
import SwiftUI

extension XCTestCase {
	func expectSnapshot<Content: View>(matching view: Content,
									   file: StaticString = #file,
									   testName: String = #function,
									   line: UInt = #line) {
		let hostingVC = UIHostingController(rootView: view)
		_ = hostingVC.view.intrinsicContentSize
		
		assertSnapshot(matching: hostingVC,
					   as: .image,
					   file: file,
					   testName: testName,
					   line: line)
	}
}
