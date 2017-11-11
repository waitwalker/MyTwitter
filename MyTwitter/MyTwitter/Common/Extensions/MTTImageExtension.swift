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
}

