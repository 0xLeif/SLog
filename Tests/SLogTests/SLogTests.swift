import XCTest
@testable import SLog

final class SLogTests: XCTestCase {
    func testExample() {
        let log = SLog(level: .error, title: "error", fileName: "error", shouldLogToConsole: true)
        
        log.entry {
            "asdfasldkjfhalsk"
        }
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
