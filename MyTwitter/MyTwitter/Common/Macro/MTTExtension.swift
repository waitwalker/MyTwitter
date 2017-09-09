//
//  MTTExtension.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/9/5.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


enum Result
{
    case ok(message:String)
    case empty
    case failed(messsage:String)
}

extension Result
{
    var isValid:Bool
    {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
    
}

extension Result
{
    var description:String
    {
        switch self {
        case let .ok(message):
            return message
        case .empty:
            return ""
        case let .failed(message):
            return message
        }
    }
    
}

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

