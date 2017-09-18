//
//  MTTRegisterViewModelDelegate.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/9/16.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol MTTRegitserViewModelDelegate
{
    //请求成功的回调
    func successCallBack(data:JSON) -> Void
    
    //请求失败的回调
    func failureCallBack(error:NSError) -> Void
}
