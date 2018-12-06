//
//  MTTChatMessageModel.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/12/5.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import RealmSwift

class MTTChatMessageModel: Object
{
    @objc dynamic var id                     = UUID().uuidString

    @objc dynamic var messageType            = 0

    @objc dynamic var messageFrom            = 0
    @objc dynamic var contentVoiceIsPlaying  = 0
    @objc dynamic var contentVoiceTotalTime  = 0

    @objc dynamic var cellHeight             = 0.0
    @objc dynamic var messageContent         = ""
    @objc dynamic var messagePicture         = ""
    @objc dynamic var messageVoiceName       = ""

    @objc dynamic var contentTextHeight      = 0.0
    @objc dynamic var contentPictureHeight   = 0.0
    @objc dynamic var contentVoiceHeight     = 0.0
    @objc dynamic var contentBackImageHeight = 0.0

    // 聊天时间戳
    @objc dynamic var chatDateStamp          = 0
    @objc dynamic var chatDate               = Date()

    @objc dynamic var pictureData:Data!
    
    override static func primaryKey() -> String?
    {
        return "id"
    }
    
}
