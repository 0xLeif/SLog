import XCTest
@testable import SLog

final class SLogTests: XCTestCase {
    func testExample() {
        let flog = SLog.fatal(title: "Fatal Logs Test", fileName: "slog.fatallogs", shouldLogToConsole: true)
        let elog = SLog.error(title: "Error Logs To Test SLog If IT WORKS!", fileName: "slog.errorlogs", shouldLogToConsole: true)
        let wlog = SLog.warning(title: "Warning Log", fileName: "slog.warninglogs", shouldLogToConsole: true)
        let slog = SLog.success(title: "Success!", fileName: "slog.successlogs", shouldLogToConsole: true)
        let ilog = SLog.info(title: "Info Logs...", fileName: "slog.infologs", shouldLogToConsole: true)
        let dlog = SLog.debug(title: "Debug Logs!", fileName: "slog.debuglogs", shouldLogToConsole: true)
        
        flog.entry {
            "Could not unwrap value!"
        }
        elog.entry {
            [
            "fasdhjy6ui",
            "697895rjmgvhjbn"
            ]
        }
        wlog.entry {
            "Don't do this... It is depricated"
        }
        
        slog.entry {
            "Correct Value... Logged in!"
        }
        ilog.entry {
            ("Values:",
            45234,
            3467,
            976,
            423,
            "fgsdf",
            true,
            CGSize(width: 534, height: 768))
        }
        dlog.entry {
            "This is only for debug!"
        }
        dlog.entry(
            "Value For the First Cell",
            "v1",
            324,
            true,
            CGColor.black
        )
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
