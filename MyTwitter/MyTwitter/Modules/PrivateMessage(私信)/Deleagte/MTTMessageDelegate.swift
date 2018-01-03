//
//  MTTMessageDelegate.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/10/21.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit


protocol MTTMessagetButtonDelegate
{
    func tappedMailBoxButton(mailBoxButton:UIButton, cell:MTTMessageButtonCell) -> Void
    func tappedRequestButton(requestButton:UIButton, cell:MTTMessageButtonCell) -> Void
}

// MARK: - 聊天页面delegate
protocol MTTChatMessageViewDelegate
{
    func chatMessageViewDidScroll() -> Void
    
}

// MARK: - 聊天toolBar delegate
protocol MTTChatMessageToolBarDelegate
{
    func tappedPictureButton(button:UIButton) -> Void
    
    func tappedAddVideoButton(button:UIButton) -> Void
    
    func tappedSendButton(text:String) -> Void
}

// MARK: - 聊天相片相关 delegate 
protocol MTTPhotosViewDelegate
{
    func photosViewDragDelegate() -> Void
}

// MARK: - 聊天音视频滚动视图相关 delegate     
protocol MTTVideosViewDelegate 
{
    // 选中录音 
    func selectMicroRecorderAction(with view:MTTVideosView) -> Void
}
