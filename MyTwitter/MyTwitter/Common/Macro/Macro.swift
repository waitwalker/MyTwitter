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


// MARK: - RGB颜色
func kRGBColor(r:Float,g:Float,b:Float) -> UIColor
{
    return UIColor.init(red: CGFloat((r) / 255.0), green: CGFloat((g) / 255.0), blue: CGFloat((b) / 255.0), alpha: 1.0)
}

// MARK: - 主色调
func kMainBlueColor() -> UIColor
{
    return UIColor.init(red: (51) / 255.0, green: (153) / 255.0, blue: (255) / 255.0, alpha: 1.0)
}

// MARK: - 主灰色
func kMainGrayColor() -> UIColor
{
    return UIColor.init(red: (102) / 255.0, green: (102) / 255.0, blue: (153) / 255.0, alpha: 1.0)
}

// MARK: - 主白色
func kMainWhiteColor() -> UIColor
{
    return UIColor.white
}
