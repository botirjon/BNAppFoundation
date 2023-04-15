//
//  Logger.swift
//  AppFoundation
//
//  Created by Botirjon Nasridinov on 05/04/22.
//

import Foundation

public enum LogType : Int {
    case verbose = 0
    case debug
    case info
    case warning
    case error
    
    var prefix: String {
        switch self {
        case .verbose:
            return "VERBOSE"
        case .debug:
            return "DEBUG"
        case .info:
            return "INFO"
        case .warning:
            return "WARNING"
        case .error:
            return "ERROR"
        }
    }
}

public final class Logger {
    public static var logLevel : LogType = .info
    
//    public class func verbose( _ msg : String ) {
//        log(msg, logType: .verbose)
//    }
    
    public class func verbose(_ items: Any...) {
        log(items, logType: .verbose)
    }
    
//    public class func debug( _ msg : String ) {
//        log(msg, logType: .debug)
//    }
    
    public class func debug(_ items: Any...) {
        log(items, logType: .debug)
    }
    
//    public class func info( _ msg : String ) {
//        log(msg, logType: .info)
//    }
    
    public class func info(_ items: Any...) {
        log(items, logType: .info)
    }
    
//    public class func warning( _ msg : String ) {
//        log(msg, logType: .warning)
//    }
    
    public class func warning(_ items: Any...) {
        log(items, logType: .warning)
    }
    
//    public class func error( _ msg : String ) {
//        log(msg, logType: .error)
//    }
    
    public class func error(_ items: Any...) {
        log(items, logType: .error)
    }
    
//    class func log(_ msg : String, logType : LogType) {
//        #if DEBUG
//        let date = Date().string(withDateFormat: "yyyy-MM-dd HH:mm:ss")
//        let message = "\n[JOYDA Business/\(logType.prefix) - \(date)] >>> \(msg)\n"
//        print(message)
//        #endif
//    }
    
    class func log(_ items: Any..., logType: LogType, separator: String = " ", terminator: String = "\n") {
        #if DEBUG
        let eventDate = Date().string(withDateFormat: "yyyy-MM-dd HH:mm:ss")
        print("\n[JOYDA Business/\(logType.prefix) - \(eventDate)] >>> ", items, separator: separator, terminator: terminator)
        #endif
    }
}

