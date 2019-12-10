import Foundation

public class SLog {
    private static var directoryURL = URL(fileURLWithPath: "SLogs", isDirectory: true)
    private static var temporaryDirectoryURL: URL = {
        guard let url = try? FileManager.default.url(for: .itemReplacementDirectory,
                                                     in: .userDomainMask,
                                                     appropriateFor: directoryURL,
                                                     create: true) else {
                                                        return SLog.directoryURL
        }
        return url
    }()
    
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
    
    deinit {
        do {
            
            print("Moving temp from: \(SLog.temporaryDirectoryURL.absoluteString)")
            print("To: \(SLog.directoryURL.absoluteString)")
            
            try FileManager.default.moveItem(at: SLog.temporaryDirectoryURL,
                                             to: SLog.directoryURL)
            
            print("Logs moved to: \(SLog.directoryURL.absoluteString)")
        } catch {
            print(error.localizedDescription)
        }
    }
}

public extension SLog {
    func entry(item: () -> Any) {
        
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
        guard let data = value(forLogItem: item).data(using: .utf8) else {
            return
        }
        
        do {
            let fileURL = SLog.temporaryDirectoryURL.appendingPathComponent("\(fileName).log")
            
            try data.write(to: fileURL)
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
