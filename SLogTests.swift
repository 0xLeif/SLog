import XCTest
import Rainbow
@testable import SLog

final class SLogTests: XCTestCase {
    func testExampleLog() {
        let log = SLog(level: .error, title: "ErrorLog", fileName: "error", shouldLogToConsole: true)
     
        log.entry { 
            "Hello World"
        }
    }

    static var allTests = [
        ("testExampleLog", testExampleLog),
    ]
}
