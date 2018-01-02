//
//  MTTNotificationViewModel.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/10/19.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import SwiftyJSON

class MTTNotificationViewModel: NSObject
{
    typealias allDataCallBack = (_ dataArray:[MTTNotificationModel]) -> ()
    typealias mentionDataCallBack = (_ dataArray:[MTTNotificationModel]) -> ()
    
    class func getNotificationAllData(callBack:allDataCallBack) -> Void 
    {
        var data:Data?
        
        if let filePath = Bundle.main.path(forResource: "MTTNotificationAllData", ofType: "json") 
        {
            data = try? Data(contentsOf: URL(fileURLWithPath: filePath))
        }
        
        let json = JSON(data: data!)
        
        let result = json["result"].intValue
        
        var dataArr:[MTTNotificationModel] = []
        
        if result == 200 
        {
            if let dataArray = json["data"].array
            {
                for subjson in dataArray
                {
                    let notificationModel = MTTNotificationModel()
                    let cellType          = subjson["cellType"].stringValue
                    
                    if cellType == "replyType"
                    {
                        notificationModel.cellType            = MTTNotificationCellType.replyType
                        notificationModel.avatarImage         = subjson["avatarImage"].stringValue
                        notificationModel.account             = subjson["account"].stringValue
                        notificationModel.nickName            = subjson["nickName"].stringValue
                        notificationModel.time                = subjson["time"].stringValue
                        notificationModel.replyNickName       = subjson["replyNickName"].stringValue
                        notificationModel.content             = subjson["content"].stringValue
                        notificationModel.contentImages       = subjson["contentImages"].array
                        notificationModel.contentVideo        = subjson["contentVideo"].stringValue
                        notificationModel.commentCount        = subjson["commentCount"].stringValue
                        notificationModel.retwitterCount      = subjson["retwitterCount"].stringValue
                        notificationModel.likeCount           = subjson["likeCount"].stringValue
                        notificationModel.privateMessageCount = subjson["privateMessageCount"].stringValue
                        notificationModel.contentTextHeight   = notificationModel.content?.calculateTextHeight(text: notificationModel.content!)
                        notificationModel.cellHeight = 245 + notificationModel.contentTextHeight!
                    } else if cellType == "mentionType"
                    {
                        notificationModel.cellType            = MTTNotificationCellType.mentionType
                        notificationModel.avatarImage         = subjson["avatarImage"].stringValue
                        notificationModel.account             = subjson["account"].stringValue
                        notificationModel.nickName            = subjson["nickName"].stringValue
                        notificationModel.time                = subjson["time"].stringValue
                        notificationModel.content             = subjson["content"].stringValue
                        notificationModel.contentImages       = subjson["contentImages"].array
                        notificationModel.contentVideo        = subjson["contentVideo"].stringValue
                        notificationModel.commentCount        = subjson["commentCount"].stringValue
                        notificationModel.retwitterCount      = subjson["retwitterCount"].stringValue
                        notificationModel.likeCount           = subjson["likeCount"].stringValue
                        notificationModel.privateMessageCount = subjson["privateMessageCount"].stringValue
                        notificationModel.contentTextHeight   = notificationModel.content?.calculateTextHeight(text: notificationModel.content!)
                        notificationModel.cellHeight = 225 + notificationModel.contentTextHeight!
                        
                    } else if cellType == "followType"
                    {
                        notificationModel.cellType     = MTTNotificationCellType.followType
                        notificationModel.iconImage    = subjson["iconImage"].stringValue
                        notificationModel.avatarImages = subjson["avatarImages"].array
                        notificationModel.followString = subjson["followString"].stringValue
                        notificationModel.cellHeight   = 80
                        
                    } else
                    {
                        notificationModel.cellType          = MTTNotificationCellType.multiType
                        notificationModel.iconImage         = subjson["iconImage"].stringValue
                        notificationModel.avatarImages      = subjson["avatarImages"].array
                        notificationModel.multiTitle        = subjson["multiTitle"].stringValue
                        notificationModel.multiContent      = subjson["multiContent"].stringValue
                        notificationModel.contentTextHeight = notificationModel.multiContent?.calculateTextHeight(text: notificationModel.multiContent!)
                        notificationModel.cellHeight        = notificationModel.contentTextHeight! + 80
                    }
                    
                    dataArr.append(notificationModel)
                }
            }
            callBack(dataArr)
        }
    }
    
    class func getNotificationMentionData(callBack:mentionDataCallBack) -> Void 
    {
        var data:Data?
        var dataArr:[MTTNotificationModel] = []
        
        if let filePath = Bundle.main.path(forResource: "MTTNotificationMention", ofType: "json") 
        {
            data = try? Data(contentsOf: URL(fileURLWithPath: filePath))
        }
        
        let json = JSON(data: data!)
        
        let result = json["result"].intValue
        
        if result == 200 
        {
            if let dataArray = json["data"].array
            {
                for subjson in dataArray
                {
                    let notificationModel         = MTTNotificationModel()
                    notificationModel.avatarImage = subjson["avatarImage"].stringValue
                    let cellType = subjson["cellType"].stringValue
                    
                    if cellType == "replyType"
                    {
                        notificationModel.cellType = MTTNotificationCellType.replyType
                    } else
                    {
                        notificationModel.cellType = MTTNotificationCellType.mentionType
                    }
                    notificationModel.account             = subjson["account"].stringValue
                    notificationModel.nickName            = subjson["nickName"].stringValue
                    notificationModel.time                = subjson["time"].stringValue
                    notificationModel.replyNickName       = subjson["replyNickName"].stringValue
                    notificationModel.content             = subjson["content"].stringValue
                    notificationModel.contentImages       = subjson["contentImages"].array
                    notificationModel.contentVideo        = subjson["contentVideo"].stringValue
                    notificationModel.commentCount        = subjson["commentCount"].stringValue
                    notificationModel.retwitterCount      = subjson["retwitterCount"].stringValue
                    notificationModel.likeCount           = subjson["likeCount"].stringValue
                    notificationModel.privateMessageCount = subjson["privateMessageCount"].stringValue
                    notificationModel.contentTextHeight   = notificationModel.content?.calculateTextHeight(text: notificationModel.content!)
                    notificationModel.cellHeight          = 245 + notificationModel.contentTextHeight!
                    dataArr.append(notificationModel)
                }
            }
        }
        callBack(dataArr)
    }
}
