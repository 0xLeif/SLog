import Foundation

public struct SLogger {
    public var fatal: SLog
    public var error: SLog
    public var warning: SLog
    public var success: SLog
    public var info: SLog
    public var debug: SLog
    
    public init(fatalTitle: String = "Fatal Logs",
                errorTitle: String = "Error Logs",
                warningTitle: String = "Warning Logs",
                successTitle: String = "Success Logs",
                infoTitle: String = "Information Logs",
                debugTitle: String = "Debug Logs",
                fileNamePrefix: String = "yourapp") {
        
        fatal = SLog.fatal(title: fatalTitle, fileName: "\(fileNamePrefix).fatallogs", shouldLogToConsole: true)
        error = SLog.error(title: fatalTitle, fileName: "\(fileNamePrefix).errorlogs", shouldLogToConsole: true)
        warning = SLog.warning(title: fatalTitle, fileName: "\(fileNamePrefix).warninglogs", shouldLogToConsole: true)
        success = SLog.success(title: fatalTitle, fileName: "\(fileNamePrefix).successlogs", shouldLogToConsole: true)
        info = SLog.info(title: fatalTitle, fileName: "\(fileNamePrefix).infologs", shouldLogToConsole: true)
        debug = SLog.debug(title: fatalTitle, fileName: "\(fileNamePrefix).debuglogs", shouldLogToConsole: true)
    }
}
