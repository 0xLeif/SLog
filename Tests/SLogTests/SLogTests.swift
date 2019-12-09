import XCTest
@testable import SLog

final class SLogTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SLog().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
