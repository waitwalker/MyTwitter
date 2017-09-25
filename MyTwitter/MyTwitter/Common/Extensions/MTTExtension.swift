//
//  MTTExtension.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/9/20.
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

// MARK: - String拓展
extension String
{
    /// 截取第一个到第任意位置
    ///
    /// - Parameter end: 结束的位值
    /// - Returns: 截取后的字符串
    func stringCut(end: Int) ->String{
        print(self.characters.count)
        if !(end < characters.count) { return "截取超出范围" }
        let sInde = index(startIndex, offsetBy: end)
        return substring(to: sInde)
    }
    
    /// 截取人任意位置到结束
    ///
    /// - Parameter end:
    /// - Returns: 截取后的字符串
    func stringCutToEnd(star: Int) -> String {
        if !(star < characters.count) { return "截取超出范围" }
        let sRang = index(startIndex, offsetBy: star)..<endIndex
        return substring(with: sRang)
    }
    
    /// 字符串任意位置插入
    ///
    /// - Parameters:
    ///   - content: 插入内容
    ///   - locat: 插入的位置
    /// - Returns: 添加后的字符串
    func stringInsert(content: String,locat: Int) -> String {
        if !(locat < characters.count) { return "截取超出范围" }
        let str1 = stringCut(end: locat)
        let str2 = stringCutToEnd(star: locat)
        return str1 + content + str2
    }
    
    /// 计算字符串的尺寸
    ///
    /// - Parameters:
    ///   - text: 字符串
    ///   - rectSize: 容器的尺寸
    ///   - fontSize: 字体
    /// - Returns: 尺寸
    func  getStringSize(text: String, rectSize: CGSize,fontSize: CGFloat) -> CGSize {
        let str = text as NSString
        let rect = str.boundingRect(with: rectSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)], context: nil)
        
        return rect.size
    }
    
    
    
    
    /// 输入字符串 输出数组
    /// e.g  "qwert" -> ["q","w","e","r","t"]
    /// - Returns: ["q","w","e","r","t"]
    func stringToArr() -> [String] {
        let num = characters.count
        if !(num > 0) { return [""] }
        var arr: [String] = []
        for i in 0..<num {
            let tempStr: String = self[self.index(self.startIndex, offsetBy: i)].description
            arr.append(tempStr)
        }
        return arr
    }
    
    /// 字符串截取         3  6
    /// e.g let aaa = "abcdefghijklmnopqrstuvwxyz"  -> "cdef"
    /// - Parameters:
    ///   - start: 开始位置 3
    ///   - end: 结束位置 6
    /// - Returns: 截取后的字符串 "cdef"
    func startToEnd(start: Int,end: Int) -> String {
        if !(end < characters.count) || start > end { return "取值范围错误" }
        var tempStr: String = ""
        for i in start...end {
            let temp: String = self[self.index(self.startIndex, offsetBy: i - 1)].description
            tempStr += temp
        }
        return tempStr
    }
    
    /// 字符URL格式化
    ///
    /// - Returns: 格式化的 url
    func stringEncoding() -> String {
        let url = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        return url!
    }
}

// MARK: - UIView拓展
extension UIView
{
    var x:CGFloat{
        get{
            return self.frame.origin.x
        } set{
            self.frame.origin.x = newValue
        }
    }
    
    var y:CGFloat{
        get{
            return self.frame.origin.y
        }set{
            self.frame.origin.y = newValue
        }
    }
    
    
    var width:CGFloat{
        get{
            return self.frame.size.width
        }set{
            self.frame.size.width = newValue
        }
    }
    
    var height:CGFloat{
        get{
            return self.frame.size.height
        }set{
            self.frame.size.height = newValue
        }
    }
    var size:CGSize{
        get{
            return self.frame.size
        }set{
            self.frame.size = newValue
        }
    }
    
    var centerX:CGFloat{
        get{
            return self.center.x
        }set{
            self.centerX = newValue
        }
    }
    
    var centerY:CGFloat{
        get{
            return self.center.y
        }set{
            self.centerY = newValue
        }
    }
    
    // 关联 SB 和 XIB
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable public var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        
        set {
            layer.shadowRadius = newValue
        }
    }
    @IBInspectable public var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        
        set {
            layer.shadowOpacity = newValue
        }
    }
    @IBInspectable public var shadowColor: UIColor? {
        get {
            return layer.shadowColor != nil ? UIColor(cgColor: layer.shadowColor!) : nil
        }
        
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    @IBInspectable public var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        
        set {
            layer.shadowOffset = newValue
        }
    }
    @IBInspectable public var zPosition: CGFloat {
        get {
            return layer.zPosition
        }
        
        set {
            layer.zPosition = newValue
        }
    }
}


extension UIButton
{
    func setImageWithPosition(postion:MTTButtonImagePostion,spacing:CGFloat) -> Void 
    {
        self.setTitle(self.currentTitle, for: UIControlState.normal)
        self.setImage(self.currentImage, for: UIControlState.normal)
        
        let imageWidth = self.imageView?.image?.size.width
        let imageHeight = self.imageView?.image?.size.height
        
        let titleLabelTitle:NSString = (self.titleLabel?.text! as NSString?)!
        
        let labelWidth = titleLabelTitle.size(attributes: [NSFontAttributeName : self.titleLabel?.font as Any]).width
        let labelHeight = titleLabelTitle.size(attributes: [NSFontAttributeName : self.titleLabel?.font as Any]).height
        
        let imageOffsetX = (imageWidth! + labelWidth) / 2 - imageWidth! / 2 //image中心移动的x距离
        let imageOffsetY = imageHeight! / 2 + spacing / 2 //image中心移动的y距离
        let labelOffsetX = (imageWidth! + labelWidth / 2) - (imageWidth! + labelWidth) / 2 //label中心移动的x距离
        let labelOffsetY = labelHeight / 2 + spacing / 2 //label中心移动的y距离
        
        let tempWidth = max(labelWidth, labelWidth)
        let changedWidth = labelWidth + imageWidth! - tempWidth;
        let tempHeight = max(labelHeight, imageHeight!) 
        let changedHeight = labelHeight + imageHeight! + spacing - tempHeight 
        
        switch postion 
        {
        case MTTButtonImagePostion.Left:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break
        case MTTButtonImagePostion.Right:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing/2, 0, -(labelWidth + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth! + spacing/2), 0, imageWidth! + spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break
        case MTTButtonImagePostion.Top:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -changedWidth/2, changedHeight-imageOffsetY, -changedWidth/2);
            break
        case MTTButtonImagePostion.Bottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(changedHeight-imageOffsetY, -changedWidth/2, imageOffsetY, -changedWidth/2);
            break
            
        }
    }
}

