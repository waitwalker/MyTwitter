//
//  MTTUIColorExtension.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/11/11.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

extension UIColor
{
    class public func colorWithString(colorString:String) -> UIColor 
    {
        var color = UIColor.red  
        var cStr : String = colorString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()  
        
        if cStr.hasPrefix("#") 
        {  
            let index = cStr.index(after: cStr.startIndex)  
            cStr = cStr.substring(from: index)  
        }  
        if cStr.count != 6 
        {  
            return UIColor.black  
        }  
        
        //两种不同截取字符串的方法  
        let rRange = cStr.startIndex ..< cStr.index(cStr.startIndex, offsetBy: 2)  
        let rStr = cStr.substring(with: rRange)  
        
        let gRange = cStr.index(cStr.startIndex, offsetBy: 2) ..< cStr.index(cStr.startIndex, offsetBy: 4)  
        let gStr = cStr.substring(with: gRange)  
        
        let bIndex = cStr.index(cStr.endIndex, offsetBy: -2)  
        let bStr = cStr.substring(from: bIndex)  
        
        color = UIColor(red: CGFloat(changeToInt(numStr: rStr)) / 255, green: CGFloat(changeToInt(numStr: gStr)) / 255, blue: CGFloat(changeToInt(numStr: bStr)) / 255, alpha: 1.0)
        return color  
    }
    
    class private func changeToInt(numStr:String) -> Int 
    {  
        let str = numStr.uppercased()  
        var sum = 0  
        for i in str.utf8 
        {  
            sum = sum * 16 + Int(i) - 48  
            if i >= 65 
            {  
                sum -= 7  
            }  
        }  
        return sum  
    }  
}
