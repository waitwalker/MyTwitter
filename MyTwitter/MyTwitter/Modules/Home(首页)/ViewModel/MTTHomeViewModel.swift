//
//  MTTHomeViewModel.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/25.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import SwiftyJSON

class MTTHomeViewModel: NSObject 
{
    typealias homeDataCallBack = (_ dataArray:Array<MTTHomeModel>)->()
    
    class func getHomeData(callBack:homeDataCallBack) -> Void
    {
        var data:Data?
        
        if let filePath = Bundle.main.path(forResource: "HomeData", ofType: "json")
        {
            data = try? Data.init(contentsOf: URL.init(fileURLWithPath: filePath))
        }
        
        let json = JSON.init(data: data!)
        
        let result = json["result"].intValue
        
        var homeModels:[MTTHomeModel] = []
        
        
        if result == 200
        {
            if let dataArray = json["data"].array
            {
                for(subjson) in dataArray
                {
                    let homeModel = MTTHomeModel()
                    homeModel.retwitterType = subjson["retwitterType"].stringValue
                    homeModel.retwitterImageString = subjson["retwitterImage"].stringValue
                    homeModel.retwitterAccountString = subjson["retwitterAccount"].stringValue
                    homeModel.avatarImageString = subjson["avatarImage"].stringValue
                    homeModel.nickNameString = subjson["nickName"].stringValue
                    
                    homeModel.contentTextString = subjson["content"].stringValue
                    homeModel.contentImageStrings = subjson["contentImages"].arrayValue
                    homeModel.contentVideoString = subjson["contentVideo"].stringValue
                    
                    homeModel.commentCount = subjson["commentCount"].intValue
                    homeModel.retwitterCount = subjson["retwitterCount"].intValue
                    homeModel.likeCount = subjson["likeCount"].intValue
                    homeModel.privateMessageCount = subjson["privateMessageCount"].intValue
                    homeModels.append(homeModel)
                }
                
                callBack(homeModels)
            }
        }
        
    }
    
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
