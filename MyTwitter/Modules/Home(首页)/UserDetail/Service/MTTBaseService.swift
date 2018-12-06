//
//  MTTBaseService.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2018/3/5.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SwiftyJSON

class MTTBaseService: NSObject 
{
    static let sharedService = MTTBaseService()
    private override init() {
        
    }
    
    // MARK: - 获取数据 
    func getTweetData(parameter:[String:Any]) -> Observable<[MTTHomeModel]> 
    {
        var data:Data?
        
        if let filePath = Bundle.main.path(forResource: "HomeData", ofType: "json")
        {
            data = try? Data.init(contentsOf: URL.init(fileURLWithPath: filePath))
        }
        
        let json   = JSON.init(data: data!)
        
        let result = json["result"].intValue
        
        var homeModels:[MTTHomeModel] = []
        
        
        if result == 200
        {
            if let dataArray = json["data"].array
            {
                for(subjson) in dataArray
                {
                    let homeModel                    = MTTHomeModel()
                    homeModel.retwitterType          = subjson["retwitterType"].stringValue
                    homeModel.retwitterImageString   = subjson["retwitterImage"].stringValue
                    homeModel.retwitterAccountString = subjson["retwitterAccount"].stringValue
                    homeModel.avatarImageString      = subjson["avatarImage"].stringValue
                    homeModel.accountString          = subjson["account"].stringValue
                    homeModel.nickNameString         = subjson["nickName"].stringValue
                    homeModel.timeString             = subjson["time"].stringValue
                    homeModel.contentImageCount      = self.getRandomNum()
                    homeModel.contentTextString      = subjson["content"].stringValue
                    
                    homeModel.contentHeight          = self.calculateTextHeight(text: homeModel.contentTextString!) + 150
                    
                    if (homeModel.retwitterType?.count)! > Int(0)
                    {
                        homeModel.cellHeight = 255 + homeModel.contentHeight! - 150
                    } else
                    {
                        homeModel.cellHeight = 230 + homeModel.contentHeight! - 150 + 15
                    }
                    
                    homeModel.contentImageStrings = subjson["contentImages"].arrayValue
                    homeModel.contentVideoString  = subjson["contentVideo"].stringValue
                    
                    homeModel.commentCount        = subjson["commentCount"].intValue
                    homeModel.retwitterCount      = subjson["retwitterCount"].intValue
                    homeModel.likeCount           = subjson["likeCount"].intValue
                    homeModel.privateMessageCount = subjson["privateMessageCount"].intValue
                    homeModels.append(homeModel)
                }
            }
        }
        return Observable.just(homeModels).observeOn(MainScheduler.instance)
    }
    
    func getRandomNum() -> Int
    {
        var num = (arc4random() % 4)
        if num == 0
        {
            num = 1
        }
        return Int(num)
    }
    
    
    
    func calculateTextHeight(text:String) -> CGFloat
    {
        let attributeString = NSMutableAttributedString.init(string: text)
        let style           = NSMutableParagraphStyle.init()
        style.lineSpacing   = 5
        let font            = UIFont.systemFont(ofSize: 14)
        attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, text.count))
        attributeString.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, text.count))
        let options         = UInt8(NSStringDrawingOptions.usesLineFragmentOrigin.rawValue) | UInt8(NSStringDrawingOptions.usesFontLeading.rawValue)
        let rect            = attributeString.boundingRect(
            with: CGSize.init(width: kScreenWidth - 60 - 20, height: CGFloat.greatestFiniteMagnitude), 
            options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.RawValue(options)), 
            context: nil)
        return rect.size.height
    }
    
}
