//
//  MTTRollingFileLogger.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/30.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import Foundation
import XCGLogger

open class MTTRollingFileLogger: XCGLogger 
{
    fileprivate static let TwoMBsInBytes:Int64 = 2 * 100000  //2MB
    fileprivate var sizeLimit:Int64 = 0                      //大小
    fileprivate var logDirectoryPath:String? = nil           //log路径
    
    let fileLogIdentifierPrefix = "cn.waitwalker.mytwitter.filelogger."
    
    fileprivate static let DateFormatter:DateFormatter = 
    {
        let formatter = Foundation.DateFormatter()
        formatter.dateFormat = "yyyyMMdd'T'HHmmssZ"
        return formatter
    }()
    
    let root:String
    
    public init(filenameRoot:String,logDirectoryPath:String?,sizeLimit:Int64 = TwoMBsInBytes) 
    {
        root = filenameRoot
        self.sizeLimit = sizeLimit
        self.logDirectoryPath = logDirectoryPath
        super.init()
    }
    
    /**
     根据时间戳创建一个日志
     
     Create a new log file with the given timestamp to log events into
     
     :param: date Date for with to start and mark the new log file
     */
    open func newLogWithDate(date:Date) ->Void
    {
        if logDirectoryPath == nil
        {
            return
        }
        
        if let filename = filenameWithRoot(root: root, withDate: date)
        {
            remove(destinationWithIdentifier: root)
            add(destination: FileDestination(owner: self, writeToFile: filename, identifier: fileLogIdentifierWithRoot(root: root), shouldAppend: false, appendMarker: nil))
            info("Created file destination for logger with root: \(self.root) and timestamp: \(date)")
        } else
        {
            error("Failed to create a new log with root name:\(self.root) and timestamp:\(date)")
        }
    }
    
    open func deleteOldLogsDownToSizeLimit() -> Void 
    {
        while sizeOfAllLogFilesWithPrefix(prefix: self.root, exceedsSizeInBytes: sizeLimit) 
        {
            deleteOldestLogWithPrefix(self.root)
        }
    }
    
    open func logFileNamesAndURLs() throws -> [(String,URL)] 
    {
        guard let logPath = logDirectoryPath else 
        {
            return []
        }
        
        let files = try FileManager.default.contentsOfDirectoryAtPath(logPath, withFilenamePrefix: root)
        return files.flatMap{ filename in 
            if let url = URL(string: "\(logPath)/\(filename)")
            {
                return (filename,url)
            }
            return nil
        }
    }
    
    fileprivate func deleteOldestLogWithPrefix(_ prefix: String) ->Void
    {
        if logDirectoryPath == nil 
        {
            return
        }
        
        do {
            let logFiles = try FileManager.default.contentsOfDirectoryAtPath(logDirectoryPath!, withFilenamePrefix: prefix)
            if let oldestLogFilename = logFiles.first 
            {
                try FileManager.default.removeItem(atPath: "\(logDirectoryPath!)/\(oldestLogFilename)")
            }
        } catch _ as NSError 
        {
            error("Shouldn't get here")
            return
        }
    }
    
    fileprivate func sizeOfAllLogFilesWithPrefix(prefix:String, exceedsSizeInBytes threshold:Int64) -> Bool 
    {
        guard let path = logDirectoryPath else 
        {
            return false
        }
        
        let logDirURL = URL(fileURLWithPath: path)
        do {
            return try FileManager.default.allocatedSizeOfDirectoryAtURL(logDirURL, forFilesPrefixedWith: prefix, isLargerThanBytes: threshold)
        } catch let errorValue as NSError
        {
            error("error determining log directory size:\(errorValue)")
        }
        return false
    }
    
    fileprivate func filenameWithRoot(root:String,withDate date:Date) -> String? 
    {
        if let dir = logDirectoryPath 
        {
            return "\(dir)/\(root).\(MTTRollingFileLogger.DateFormatter.string(from: date)).log"
        }
        return nil
    }
    
    fileprivate func fileLogIdentifierWithRoot(root:String) -> String 
    {
        return "\(fileLogIdentifierPrefix).\(root)"
    }
    
}
