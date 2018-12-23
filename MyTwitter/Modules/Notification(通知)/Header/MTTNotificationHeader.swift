//
//  MTTNotificationHeader.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/10/19.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import Foundation


/// 通知页面下数据源类型
///
/// - all: 全部
/// - mention: 提及
enum MTTNotificationDataSourceType 
{
    case all
    case mention
}

enum MTTNotificationCellType 
{
    case replyType          //回复类型
    case mentionType        //提及类型(也就是@了)
    case followType         //关注类型
    case multiType          //多种类型(其中包括:别人转推/喜欢/分享自己的推文,也包括关注对象推文被转推/喜欢/分享)
}
