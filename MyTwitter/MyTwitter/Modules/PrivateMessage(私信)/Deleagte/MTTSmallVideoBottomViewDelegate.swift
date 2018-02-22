//
//  MTTSmallVideoBottomViewDelegate.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2018/2/22.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

import UIKit

// MARK: - 小视频底部视图delegate 
protocol MTTSmallVideoBottomViewDelegate 
{
    // 移除按钮delegate 回调 
    func tappedRemoveButton(bottomView:MTTSmallVideoBottomView) -> Void 
    
    // 录制相关 
    // 开始录制 
    func recordCircleViewDidStartRecord(bottomView:MTTSmallVideoBottomView) -> Void
    
    // 录制上移即将取消录制 
    func recordCircleViewMoveUpWillCancel(bottomView:MTTSmallVideoBottomView) -> Void
}
