//
//  MTTTabBaseHeader.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2018/2/26.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

import UIKit


/// 底部tab类型 
///
/// - MTTTabTweetType: 推文
/// - MTTTabTweetAndReplyType: 推文和回复
/// - MTTTabMediaType: 媒体
/// - MTTTabLikeType: 喜欢 
enum MTTTabBaseType:Int 
{
    case MTTTabTweetType         = 0
    case MTTTabTweetAndReplyType = 1
    case MTTTabMediaType         = 2
    case MTTTabLikeType          = 3

}
