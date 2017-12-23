//
//  Macro.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/5.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

var disposeBag = DisposeBag()

// MARK: - 屏幕宽高
let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

// MARK: - 单例
let shardInstance = MTTSingletonManager.sharedInstance


// MARK: - RGB颜色
func kRGBColor(r:Float,g:Float,b:Float) -> UIColor
{
    return UIColor.init(red: CGFloat((r) / 255.0), green: CGFloat((g) / 255.0), blue: CGFloat((b) / 255.0), alpha: 1.0)
}

// MARK: - 主色调 #3399FF
func kMainBlueColor() -> UIColor
{
    return UIColor.init(red: (51) / 255.0, green: (153) / 255.0, blue: (255) / 255.0, alpha: 1.0)
}

// MARK: - 主亮灰色
func kMainLightGrayColor() -> UIColor
{
    return UIColor.init(red: (230) / 255.0, green: (236) / 255.0, blue: (240) / 255.0, alpha: 1.0)
}

// MARK: - 文字灰色
func kMainTextGrayColor() -> UIColor
{
    return UIColor.init(red: (86) / 255.0, green: (107) / 255.0, blue: (123) / 255.0, alpha: 1.0)
}

// MARK: - 主灰色
func kMainGrayColor() -> UIColor
{
    return UIColor.init(red: (102) / 255.0, green: (102) / 255.0, blue: (153) / 255.0, alpha: 1.0)
}

// MARK: - 主灰色
func kMainChatBackgroundGrayColor() -> UIColor
{
    return UIColor.init(red: (231) / 255.0, green: (236) / 255.0, blue: (239) / 255.0, alpha: 1.0)
}

// MARK: - 主红色
func kMainRedColor() -> UIColor
{
    return UIColor.init(red: (221) / 255.0, green: (41) / 255.0, blue: (96) / 255.0, alpha: 1.0)
}

// MARK: - 主绿色
func kMainGreenColor() -> UIColor
{
    return UIColor.init(red: (0) / 255.0, green: (183) / 255.0, blue: (83) / 255.0, alpha: 1.0)
}

// MARK: - 主白色
func kMainWhiteColor() -> UIColor
{
    return UIColor.white
}

// MARK: - 随机色
func kMainRandomColor() -> UIColor
{
    return UIColor.init(red: CGFloat((arc4random() % 256)) / 255.0, green: CGFloat((arc4random() % 256)) / 255.0, blue: CGFloat((arc4random() % 256)) / 255.0, alpha: 1.0)
}
