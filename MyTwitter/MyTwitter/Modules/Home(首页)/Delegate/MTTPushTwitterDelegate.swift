//
//  MTTPushTwitterDelegate.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/10/24.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

protocol MTTPushNewTwitterDelegate
{
    //请求成功的回调
    func successCallBack(data:NSDictionary) -> Void
    
    //请求失败的回调
    func failureCallBack(error:NSError) -> Void
}
