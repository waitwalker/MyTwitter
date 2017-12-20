//
//  MTTChatMessageModel.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/12/5.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTChatMessageModel: NSObject
{
    var messageType:MTTChatMessageType!
    
    var messageFrom:MTTChatMessageFromType!
    var cellHeight:CGFloat!
    var messageContent:String!
    var messagePicture:String!
    var messageVoice:String!
    
    var contentTextHeight:CGFloat!
    var contentPictureHeight:CGFloat!
    var contentVoiceHeight:CGFloat!
    var contentBackImageHeight:CGFloat!
    
    // 聊天时间戳 
    var chatDateStamp:Int!
    
    
    
    
    
    
    
}
