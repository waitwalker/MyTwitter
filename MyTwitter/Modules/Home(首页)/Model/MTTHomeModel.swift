//
//  MTTHomeModel.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/25.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import SwiftyJSON

class MTTHomeModel: NSObject 
{
    var retwitterType:String?
    var retwitterImageString:String?
    var retwitterAccountString:String?
    
    var avatarImageString:String?
    var timeString:String?
    
    
    var accountString:String?
    var nickNameString:String?
    var contentTextString:String?
    var contentImageCount:Int?
    
    
    var contentImageStrings:[JSON]?
    
    var haveVideo:Bool?
    var contentVideoString:String?
    
    var commentCount:Int?
    var retwitterCount:Int?
    var likeCount:Int?
    var privateMessageCount:Int?
    
    var cellHeight:CGFloat?
    var contentHeight:CGFloat?
    
    var isLike:Bool?
    var isRetwitter:Bool?
    
}
