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
    
    
    /// 图片按照指定宽度缩放
    ///
    /// - Parameters:
    ///   - expectWidth: 指定宽度 
    ///   - sourceImage: 原图 
    /// - Returns: 缩放后的图片 
    func scaleImageWithWidth(expectWidth:CGFloat,sourceImage:UIImage) -> UIImage 
    {
        let imageSize = sourceImage.size
        let width = imageSize.width
        let height = imageSize.height
        let targetWidth:CGFloat = expectWidth
        let targetHeight = height / (width / targetWidth)
        let size = CGSize(width: targetWidth, height: targetHeight)
        
        var scaleFactor:CGFloat = 0.0
        var scaleWidth = targetWidth
        var scaleHeight = targetHeight
        var thumbnailPoint = CGPoint(x: 0, y: 0)
        
        if __CGSizeEqualToSize(imageSize, size) == false 
        {
            let widthFactor = targetWidth / width
            let heightFactor = targetHeight / height
            if widthFactor > heightFactor
            {
                scaleFactor = widthFactor
            } else 
            {
                scaleFactor = heightFactor
            }
            scaleWidth = width * scaleFactor
            scaleHeight = height * scaleFactor
            
            if widthFactor > heightFactor
            {
                thumbnailPoint.y = (targetHeight - scaleHeight) * 0.5
            } else if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaleWidth) * 0.5
            }
            
        }
        
        UIGraphicsBeginImageContext(size)
        var thumbnailRect = CGRect.zero
        thumbnailRect.origin = thumbnailPoint
        thumbnailRect.size.width = scaleWidth
        thumbnailRect.size.height = scaleHeight
        sourceImage.draw(in: thumbnailRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        if newImage == nil 
        {
            print("scale image failed")
        }
        UIGraphicsEndImageContext()
        return newImage!
        
    }
}

