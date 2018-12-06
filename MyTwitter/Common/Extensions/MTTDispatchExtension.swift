//
//  MTTDispatchExtension.swift
//  MyTwitter
//
//  Created by WangJunZi on 2018/1/8.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

import Foundation

extension DispatchQueue
{
    private static var _onceTracker = [String]()
    public class func once(_ token: String, block:()->Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        _onceTracker.append(token)
        block()
    }
}
