//
//  MTTNotificationModel.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/10/19.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import SwiftyJSON

class MTTNotificationModel: NSObject
{
    var cellType:MTTNotificationCellType?
    
    //包括回复和提及类型
    var avatarImage:String?
    var account:String?
    var nickName:String?
    var time:String?
    var replyNickName:String?
    var content:String?
    var contentImages:[JSON]?
    var contentVideo:String?
    var commentCount:String?
    var retwitterCount:String?
    var likeCount:String?
    var privateMessageCount:String?
    
    //关注
    var iconImage:String?
    var avatarImages:[JSON]?
    var followString:String?
    
    //multiType
    var isOther:Int?       //是否是别人 0是 1否
    var twitterType:Int?   //0 发推 1喜欢 2分享 3转推
    var multiTitle:String?
    var multiContent:String?
    
    var cellHeight:CGFloat?
    var contentTextHeight:CGFloat?
}
