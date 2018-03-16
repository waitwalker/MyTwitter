//
//  MTTImageExtension.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/11/11.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

extension UIImage
{
    class func imageNamed(name:String) -> UIImage 
    {
        let image = UIImage(named: name)
        return image!
    }
    
    
    /// 生成颜色图片 
    ///
    /// - Parameter color: 颜色
    /// - Returns: 生成的图片 
    class func imageWithColor(color:UIColor) -> UIImage 
    {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    
    /// 重置图片到希望的尺寸 
    ///
    /// - Parameter exceptSize: 期望的尺寸 
    /// - Returns: 重置后的图片 
    func resetImageSize(exceptSize:CGSize) -> UIImage 
    {
        UIGraphicsBeginImageContextWithOptions(exceptSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: exceptSize.width, height: exceptSize.height))
        let exceptImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return exceptImage
    }
    
    
    /// 等比例缩放图片 
    ///
    /// - Parameter scale: 比例 
    /// - Returns: 缩放后的图片 
    func scaleImage(scale:CGFloat) -> UIImage 
    {
        let scaledSize = CGSize(width: self.size.width * scale, height: self.size.height * scale)
        return resetImageSize(exceptSize: scaledSize)
    }
}

