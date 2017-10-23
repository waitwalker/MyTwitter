//
//  MTTLoginViewModelDelegate.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/10/23.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

protocol MTTLoginViewModelDelegate 
{
    //请求成功的回调
    func successCallBack(data:NSDictionary) -> Void
    
    //请求失败的回调
    func failureCallBack(error:NSError) -> Void
}
