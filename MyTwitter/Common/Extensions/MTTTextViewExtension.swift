//
//  MTTTextViewExtension.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/30.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

extension UITextView
{
    class func addLinkToString(allString:NSString,changedStrings:[String],changedStringColor:UIColor,stringStyle:NSInteger) -> NSMutableAttributedString
    {
        let originalString = NSString.init(format: "%@", allString)
        
        let mutableAttrStr = NSMutableAttributedString(string: originalString as String)
        
        for string in changedStrings
        {
            let range = originalString.range(of: string as String)
            
            mutableAttrStr.addAttribute(NSLinkAttributeName, value: string, range: range)
            
            mutableAttrStr.addAttribute(NSForegroundColorAttributeName, value: changedStringColor, range: range)
            mutableAttrStr.addAttribute(NSUnderlineStyleAttributeName, value: stringStyle, range: range)
            
        }
        mutableAttrStr.endEditing()
        return mutableAttrStr
    }
}
