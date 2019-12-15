import XCTest
@testable import SLog

final class SLogTests: XCTestCase {
    func testExample() {
        let logger = SLogger()
        
        logger.fatal.entry {
            "Could not unwrap value!"
        }
        logger.error.entry {
            [
            "fasdhjy6ui",
            "697895rjmgvhjbn"
            ]
        }
        logger.warning.entry {
            "Don't do this... It is depricated"
        }
        
        logger.success.entry {
            "Correct Value... Logged in!"
        }
        logger.info.entry {
            ("Values:",
            45234,
            3467,
            976,
            423,
            "fgsdf",
            true,
            CGSize(width: 534, height: 768))
        }
        logger.debug.entry {
            "This is only for debug!"
        }
        logger.debug.entry(
            "Value For the First Cell",
            "v1",
            324,
            true
        )
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
