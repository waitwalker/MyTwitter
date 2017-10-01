//
//  MTTLogger.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/30.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import Foundation
import XCGLogger

public struct MTTLogger {}

public extension MTTLogger
{
    static let logPII = false
    
    static let homeLogger = MTTRollingFileLogger(filenameRoot: "home", logDirectoryPath: MTTLogger.logFileDirectoryPath())
    static let corruptLogger:MTTRollingFileLogger =
    {
        let logger = MTTRollingFileLogger(filenameRoot: "corruptLogger", logDirectoryPath: MTTLogger.logFileDirectoryPath())
        logger.newLogWithDate(date: Date())
        return logger
    }()
    
    
    static func logFileDirectoryPath() -> String
    {
        if let cahceDir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        {
            let logDir = "\(cahceDir)/Logs"
            if !FileManager.default.fileExists(atPath: logDir)
            {
                do {
                    try FileManager.default.createDirectory(atPath: logDir, withIntermediateDirectories: false, attributes: nil)
                    return logDir
                } catch _ as NSError
                {
                    return ""
                }
            } else
            {
                return logDir
            }
        }
        return ""
    }
    
    
    func fileLoggerWithName(name:String) -> XCGLogger
    {
        let log = XCGLogger()
        let logFileURL = urlForLogNamed(name: name)
        let fileDestination = FileDestination(owner: log, writeToFile: logFileURL, identifier: "cn.waitwalker.mytwitter.filelogger.\(name)", shouldAppend: false, appendMarker: nil)
        log.add(destination: fileDestination)
        return log
    }
    
    func urlForLogNamed(name:String) -> URL
    {
        let logDirs = MTTLogger.logFileDirectoryPath() as String
        
        return URL(string: "\(logDirs)/\(name).log")!
    }
    
    func diskLogFilenamesAndData() throws -> [(String,Data?)]
    {
        var filenamesAndURLs = [(String,URL)]()
        
        filenamesAndURLs.append(("home",urlForLogNamed(name: "home")))
        filenamesAndURLs.append(("keychain",urlForLogNamed(name: "keychain")))
        do
        {
            filenamesAndURLs += try MTTLogger.homeLogger.logFileNamesAndURLs()
            filenamesAndURLs += try MTTLogger.corruptLogger.logFileNamesAndURLs()
        }
        catch _ as NSError
        {}
        
        return filenamesAndURLs.map { ($0, try? Data(contentsOf: URL(fileURLWithPath: $1.absoluteString))) }
    }
    
}


