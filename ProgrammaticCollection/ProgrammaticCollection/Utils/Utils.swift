//
//  Utils.swift
//  ProgrammaticCollection
//
//  Created by Emanuele Garolla on 22/11/2020.
//

import Foundation

func mainThread(_ block: () -> Void) {
    if !Thread.isMainThread {
        DispatchQueue.main.sync {
            block()
        }
    } else {
        block()
    }
}

func log<T>(_ value: T, file: StaticString = #file, line: UInt = #line) {
    #if DEBUG
    actualLog(value, file: file, line: line)
    #endif
}

private func actualLog<T>(_ value: T, file: StaticString, line: UInt) {
    let fileName = "\(file)".components(separatedBy: "/").last ?? ""
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone(abbreviation: "CET")
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    let date = formatter.string(from: Date())
    let stringToLog = "^ [\(date) \(fileName):\(line)] - \(value)"

    print(stringToLog)
}
