//
//  MTTStringExtension.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/30.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import DateTools

// MARK: - String拓展
extension String
{
    /// 截取第一个到第任意位置
    ///
    /// - Parameter end: 结束的位值
    /// - Returns: 截取后的字符串
    func stringCut(end: Int) ->String{
        print(self.count)
        if !(end < count) { return "截取超出范围" }
        let sInde = index(startIndex, offsetBy: end)
        return substring(to: sInde)
    }
    
    /// 截取人任意位置到结束
    ///
    /// - Parameter end:
    /// - Returns: 截取后的字符串
    func stringCutToEnd(star: Int) -> String {
        if !(star < count) { return "截取超出范围" }
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
        if !(locat < count) { return "截取超出范围" }
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
        let num = count
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
        if !(end < count) || start > end { return "取值范围错误" }
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
    
    public static func contentsOfFileWithResourceName(_ name: String, ofType type: String, fromBundle bundle: Bundle, encoding: String.Encoding, error: NSErrorPointer) -> String? {
        if let path = bundle.path(forResource: name, ofType: type) {
            do {
                return try String(contentsOfFile: path, encoding: encoding)
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
    
    public func startsWith(_ other: String) -> Bool {
        // rangeOfString returns nil if other is empty, destroying the analogy with (ordered) sets.
        if other.isEmpty {
            return true
        }
        if let range = self.range(of: other,
                                  options: NSString.CompareOptions.anchored) {
            return range.lowerBound == self.startIndex
        }
        return false
    }
    
    public func endsWith(_ other: String) -> Bool {
        // rangeOfString returns nil if other is empty, destroying the analogy with (ordered) sets.
        if other.isEmpty {
            return true
        }
        if let range = self.range(of: other,
                                  options: [NSString.CompareOptions.anchored, NSString.CompareOptions.backwards]) {
            return range.upperBound == self.endIndex
        }
        return false
    }
    
    func escape() -> String {
        let raw: NSString = self as NSString
        let allowedEscapes = CharacterSet(charactersIn: ":/?&=;+!@#$()',*")
        let str = raw.addingPercentEncoding(withAllowedCharacters: allowedEscapes)
        return str as String!
    }
    
    func unescape() -> String {
        return CFURLCreateStringByReplacingPercentEscapes(
            kCFAllocatorDefault,
            self as CFString,
            "[]." as CFString) as String
    }
    
    /**
     Ellipsizes a String only if it's longer than `maxLength`
     
     "ABCDEF".ellipsize(4)
     // "AB…EF"
     
     :param: maxLength The maximum length of the String.
     
     :returns: A String with `maxLength` characters or less
     */
    func ellipsize(maxLength: Int) -> String {
        if (maxLength >= 2) && (self.count > maxLength) {
            let index1 = self.index(self.startIndex, offsetBy: (maxLength + 1) / 2) // `+ 1` has the same effect as an int ceil
            let index2 = self.index(self.endIndex, offsetBy: maxLength / -2)
            
            return self.substring(to: index1) + "…\u{2060}" + self.substring(from: index2)
        }
        return self
    }
    
    private var stringWithAdditionalEscaping: String {
        return self.replacingOccurrences(of: "|", with: "%7C", options: NSString.CompareOptions(), range: nil)
    }
    
    public var asURL: URL? {
        // Firefox and NSURL disagree about the valid contents of a URL.
        // Let's escape | for them.
        // We'd love to use one of the more sophisticated CFURL* or NSString.* functions, but
        // none seem to be quite suitable.
        return URL(string: self) ??
            URL(string: self.stringWithAdditionalEscaping)
    }
    
    /// Returns a new string made by removing the leading String characters contained
    /// in a given character set.
    public func stringByTrimmingLeadingCharactersInSet(_ set: CharacterSet) -> String {
        var trimmed = self
        while trimmed.rangeOfCharacter(from: set)?.lowerBound == trimmed.startIndex {
            trimmed.remove(at: trimmed.startIndex)
        }
        return trimmed
    }
    
    /// Adds a newline at the closest space from the middle of a string.
    /// Example turning "Mark as Read" into "Mark as\n Read"
    public func stringSplitWithNewline() -> String {
        let mid = self.count/2
        
        let arr: [Int] = self.indices.flatMap {
            if self[$0] == " " {
                return self.distance(from: startIndex, to: $0)
            }
            
            return nil
        }
        guard let closest = arr.enumerated().min(by: { abs($0.1 - mid) < abs($1.1 - mid) }) else {
            return self
        }
        var newString = self
        newString.insert("\n", at: newString.index(newString.startIndex, offsetBy: closest.element))
        return newString
    }
    
    public func calculateTextHeight(text:String) -> CGFloat
    {
        let attributeString = NSMutableAttributedString.init(string: text)
        let style = NSMutableParagraphStyle.init()
        style.lineSpacing = 5
        let font = UIFont.systemFont(ofSize: 14)
        attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, text.count))
        attributeString.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, text.count))
        let options = UInt8(NSStringDrawingOptions.usesLineFragmentOrigin.rawValue) | UInt8(NSStringDrawingOptions.usesFontLeading.rawValue)
        let rect = attributeString.boundingRect(with: CGSize.init(width: kScreenWidth - 60 - 20, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.RawValue(options)), context: nil)
        return rect.size.height
    }
    
    /**
     Get the height with font.
     
     - parameter font:       The font.
     - parameter fixedWidth: The fixed width.
     
     - returns: The height.
     */
    func heightWithFont(fontSize : CGFloat, fixedWidth : CGFloat) -> CGFloat
    {
        let attributeString = NSMutableAttributedString.init(string: self)
        let style = NSMutableParagraphStyle.init()
        style.lineSpacing = 5
        let font = UIFont.systemFont(ofSize: fontSize)
        attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, self.count))
        attributeString.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, self.count))
        let options = UInt8(NSStringDrawingOptions.usesLineFragmentOrigin.rawValue) | UInt8(NSStringDrawingOptions.usesFontLeading.rawValue)
        let rect = attributeString.boundingRect(with: CGSize.init(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.RawValue(options)), context: nil)
        return rect.size.height
    }
    
    
    /// 根据聊天内容时间戳 获取相应的时间提示
    ///
    /// - Parameter chatTimeStamp: 聊天时间戳
    /// - Returns: 时间字符串提示
    static func getSuitableDateHint(_ chatTimeStamp: TimeInterval) -> String
    {
        
        let tmpDate = Date(timeIntervalSince1970: chatTimeStamp) as NSDate
        
        let yearLength = tmpDate.yearsAgo()
        
        let monthLength = tmpDate.monthsAgo()
        
        let weekLength = tmpDate.weeksAgo()
        
        let dayLength = tmpDate.daysAgo()
        
        let hourLenght = tmpDate.hoursAgo()
        
        let minuteLength = tmpDate.minutesAgo()
        
        let secondLength = tmpDate.secondsAgo()
        
        if yearLength >= 1
        {
            return String(format: "%.0f年前", yearLength)
        } else if monthLength >= 1
        {
            return String(format: "%.0f个月前", monthLength)
        } else if weekLength >= 1
        {
            return String(format: "%.0f周前", weekLength)
        } else if dayLength >= 1
        {
            return String(format: "%.0f天前", dayLength)
        } else if hourLenght >= 1
        {
            return String(format: "%.0f个小时前", hourLenght)
        } else if minuteLength >= 1
        {
            return String(format: "%.0f分钟前", minuteLength)
        } else if secondLength >= 1
        {
            return String(format: "%.0f秒前", secondLength)
        } else
        {
            return "刚刚"
        }
    }
    
    
    
    // MARK: - 获取当前时间string
    static func getTimeString(date:Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        let dateStr = dateFormatter.string(from:date)
        return dateStr
    }
    
    
    /// 获取随机数
    ///
    /// - Parameter peakValue: 最大随机数
    /// - Returns: 随机数 
    static func getRandomValue(peakValue:Int) -> Int
    {
        return Int(arc4random_uniform(UInt32(peakValue)))
    }
}

