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
