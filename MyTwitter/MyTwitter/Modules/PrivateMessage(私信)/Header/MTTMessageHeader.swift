//
//  MTTMessageHeader.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/10/21.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

// MARK: - 私信类型
enum MTTMessageDataSourceType
{
    case mailBoxType //收件箱
    case requestType //请求
}

enum MTTChatMessageType:Int
{
    case text = 0         //文本
    case picture = 1      //图片
    case voice = 2        //语音
    case expression = 3   //表情
    case file  = 4        //文件
}

enum MTTChatMessageFromType:Int {
    case My = 0     //自己发的
    case Others = 1 //别人发的
}
