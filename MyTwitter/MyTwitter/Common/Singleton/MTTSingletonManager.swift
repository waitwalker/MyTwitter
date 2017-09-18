//
//  MTTSingletonManager.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/18.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import Foundation

class MTTSingletonManager: NSObject 
{
    var user_name:String = ""
    var email:String = ""
    var phone_num:String = ""
    var password:String = ""
    
    static let sharedInstance = MTTSingletonManager()
    
    private override init
    () {
        super.init()
    }
    
    
}
