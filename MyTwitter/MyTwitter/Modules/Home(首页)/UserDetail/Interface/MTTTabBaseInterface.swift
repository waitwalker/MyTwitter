//
//  MTTTabBaseInterface.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2018/2/26.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

import UIKit

// MARK: - tab 基类 
protocol MTTTabBaseInterface:NSObjectProtocol 
{
    // 类 构造方法 
    static func setupTabView(tabType:MTTTabBaseType) -> MTTTabBaseView 
}
