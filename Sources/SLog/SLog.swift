import Foundation

public class SLog {
    private static var directoryURL = URL(fileURLWithPath: "SLogs", isDirectory: true)
    
    public enum LogLevel {
        case fatal
        case error
        case warning
        case success
        case info
        case debug
        case custom(type: String)
    }
    
    let level: LogLevel
    let title: String
    var fileOutput: String?
    let shouldLogToConsole: Bool
    
    private var fileName: String {
        fileOutput ?? title
    }
    
    public init(level: LogLevel,
                title: String,
                fileName: String? = nil,
                shouldLogToConsole: Bool = true) {
        self.level = level
        self.title = title
        self.shouldLogToConsole = shouldLogToConsole
    }
}

public extension SLog {
    func entry(_ item: () -> Any) {
        
        let logEntry = item()
        
        log(itemToConsole: logEntry)
        log(itemToFile: logEntry)
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
        
        print(value(forLogItem: item))
    }
    
    func log(itemToFile item: Any) {
        let fileURL = SLog.directoryURL.appendingPathComponent("\(fileName).log")
        let previousLogEntry = (try? String(contentsOf: fileURL, encoding: .utf8)) ?? "SLog: \(title)" 
        guard let data = "\(previousLogEntry)\(value(forLogItem: item))"
                    .data(using: .utf8) else {
            return
        }
        
        do {
            
            
            try data.write(to: fileURL)
            
            print("Logged to: \(fileURL.absoluteString)")
        } catch {
            print(error.localizedDescription)
        }
    }
}
