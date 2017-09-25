//
//  MTTHomeViewModel.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/25.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTHomeViewModel: NSObject 
{

    
    
    func calculateTextHeight(text:String) -> CGFloat 
    {
        let attributeString = NSMutableAttributedString.init(string: text)
        let style = NSMutableParagraphStyle.init()
        style.lineSpacing = 0
        let font = UIFont.systemFont(ofSize: 14)
        attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, text.characters.count))
        attributeString.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, text.characters.count))
        let options = UInt8(NSStringDrawingOptions.usesLineFragmentOrigin.rawValue) | UInt8(NSStringDrawingOptions.usesFontLeading.rawValue)
        let rect = attributeString.boundingRect(with: CGSize.init(width: kScreenWidth - 60 - 20, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.RawValue(options)), context: nil)
        return rect.size.height
    }
    
}
