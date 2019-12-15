import Foundation

public class SLog {
    #if os(macOS) || os(iOS)
    	private static var directoryURL = (try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)) ?? URL(fileURLWithPath: "SLogs")
   #endif 

    public enum LogLevel {
        case fatal
        case error
        case warning
        case success
        case info
        case debug
        case custom(type: String)
        
        var logLabel: String {
            switch self {
            case .fatal:
                return "Fatal"
            case .error:
                return "Error"
            case .warning:
                return "Warning"
            case .success:
                return "Success"
            case .info:
                return "Information"
            case .debug:
                return "Debug"
            case .custom(let type):
                return type
            }
        }
    }
    
    let level: LogLevel
    let title: String
    var fileOutput: String?
    let shouldLogToConsole: Bool
    
    private var fileName: String {
        return fileOutput ?? title
    }
    
    public init(level: LogLevel,
                title: String,
                fileName: String? = nil,
                shouldLogToConsole: Bool = true) {
        self.level = level
        self.title = title
        self.fileOutput = fileName
        self.shouldLogToConsole = shouldLogToConsole
        
        self.log(itemToFile: "[\(Date().timeIntervalSince1970)] SLog: \(title)")
    }
}

public extension SLog {
    class func fatal(title: String,
                            fileName: String? = nil,
                            shouldLogToConsole: Bool = true) -> SLog {
        return SLog(level: .fatal,
                    title: title,
                    fileName: fileName,
                    shouldLogToConsole: shouldLogToConsole)
    }
    
    class func error(title: String,
                            fileName: String? = nil,
                            shouldLogToConsole: Bool = true) -> SLog {
        return SLog(level: .error,
                    title: title,
                    fileName: fileName,
                    shouldLogToConsole: shouldLogToConsole)
    }
    
    class func warning(title: String,
                              fileName: String? = nil,
                              shouldLogToConsole: Bool = true) -> SLog {
        return SLog(level: .warning,
                    title: title,
                    fileName: fileName,
                    shouldLogToConsole: shouldLogToConsole)
    }
    
    class func success(title: String,
                              fileName: String? = nil,
                              shouldLogToConsole: Bool = true) -> SLog {
        return SLog(level: .success,
                    title: title,
                    fileName: fileName,
                    shouldLogToConsole: shouldLogToConsole)
    }
    
    class func info(title: String,
                           fileName: String? = nil,
                           shouldLogToConsole: Bool = true) -> SLog {
        return SLog(level: .info,
                    title: title,
                    fileName: fileName,
                    shouldLogToConsole: shouldLogToConsole)
    }
    
    class func debug(title: String,
                            fileName: String? = nil,
                            shouldLogToConsole: Bool = true) -> SLog {
        return SLog(level: .debug,
                    title: title,
                    fileName: fileName,
                    shouldLogToConsole: shouldLogToConsole)
    }
    
    class func custom(type: String,
                             title: String,
                             fileName: String? = nil,
                             shouldLogToConsole: Bool = true) -> SLog {
        return SLog(level: .custom(type: type),
                    title: title,
                    fileName: fileName,
                    shouldLogToConsole: shouldLogToConsole)
    }
}

public extension SLog {
    func entry(_ item: () -> Any) {
        
        let logEntry = item()
        
        log(itemToConsole: logEntry)
        log(itemToFile: logEntry)
    }
    
    func entry(_ items: Any...) {
        
        let logEntry = items.map { "\($0) " }.reduce("", +)
        
        log(itemToConsole: logEntry)
        #if os(macOS) || os(iOS)
        log(itemToFile: logEntry)
        #endif
    }
}

extension SLog {
    func value(forLogItem item: Any) -> String {
        if let string = item as? CustomStringConvertible {
            return string.description
        }
        
        return "\(item)"
    }
    
    func log(itemToConsole item: Any) {
        guard shouldLogToConsole else {
            return
        }
        
        print("\(level.logLabel): \(value(forLogItem: item))")
    }
    
    func log(itemToFile item: Any) {
        let fileURL = SLog.directoryURL.appendingPathComponent("\(fileName).log")
        let previousLogEntry = (try? String(contentsOf: fileURL, encoding: .utf8)) ?? ""
        let logEntry = "\(value(forLogItem: item))"
        guard let data = "\(previousLogEntry)\(logEntry)\n"
            .data(using: .utf8) else {
                return
        }
        
        do {
            try data.write(to: fileURL)
        } catch {
            print("Error: Attempted to log to file (\(fileURL.absoluteString))")
            print(error.localizedDescription)
        }
    }
}
