//
//  MTTNotificationDelegate.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/10/19.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import Foundation
import UIKit

protocol MTTNotificationButtonDelegate 
{
    
    func tappedAllButton(allButton:UIButton, cell:MTTNotificationButtonCell) -> Void
    func tappedMentionButton(mentionButton:UIButton, cell:MTTNotificationButtonCell) -> Void 
    
}
