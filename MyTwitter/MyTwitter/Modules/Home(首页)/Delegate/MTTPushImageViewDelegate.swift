//
//  MTTPushImageViewDelegate.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/10/4.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import Foundation
import UIKit

protocol MTTPushImageViewDelegate {
    
    func tappedCloseImageView(closeImageView:UIImageView) -> Void           //关闭回调
    
    func tappedEditImageView(editImageView:UIImageView) -> Void             //编辑回调
    
    func tappedExpressionImageView(expressionImageView:UIImageView) -> Void //表情回调
    
}
