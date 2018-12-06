//
//  MTTSearchModel.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/10/17.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import SwiftyJSON

class MTTSearchModel: NSObject
{
    var title:String?
    var subTitle:String?
    
    var avatarImage:String?
    var account:String?
    var nickName:String?
    var time:String?
    var content:String?
    var contentImages:[JSON]?
    var contentVideo:String?
    var commentCount:String?
    var retwitterCount:String?
    var likeCount:String?
    var privateMessageCount:String?
    
    var website:String?
    var iconImage:String?
    var twitter:String?
    
    var cellHeight:CGFloat?
    var contentTextHeight:CGFloat?
    
}
