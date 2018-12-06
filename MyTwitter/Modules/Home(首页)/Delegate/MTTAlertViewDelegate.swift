//
//  MTTAlertViewDelegate.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/11/6.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

protocol MTTAlertViewDelegate
{
    func tappedRetwitter(alertView:MTTAlertView, retwitterButton:UIButton) -> Void
    func tappedQuoteTwitter(alertView:MTTAlertView, quoteTwitterButton:UIButton) -> Void
    func tappedCancel(alertView:MTTAlertView, cancelButton:UIButton) -> Void
}
