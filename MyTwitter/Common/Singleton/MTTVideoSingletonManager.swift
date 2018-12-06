//
//  MTTVideoSingletonManager.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2018/2/23.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

import UIKit

class MTTVideoSingletonManager: NSObject 
{
    // 视频相关 
    var currentVideoPath:String!
    var currentVideoFileName:String!
    var currentVideoThumbnailPath:String!
    var currentVideoThumbnailFileName:String!
    
    
    static let videoSharedManager = MTTVideoSingletonManager()
    
    private override init() {
        super.init()
    }
    
    // 缓存路径 
    func getRecorderFilePath() -> String 
    {
        let filePath = getDocumentPath() + "/recorderFile"
        if FileManager.default.fileExists(atPath: filePath)
        {
            return filePath
        }
        
        do {
            try FileManager.default.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
            return filePath
        } catch
        {
            return getDocumentPath()
        }
        
    }
    
    /**工具相关**/
    func getDocumentPath() -> String 
    {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        return path!
    }
}
