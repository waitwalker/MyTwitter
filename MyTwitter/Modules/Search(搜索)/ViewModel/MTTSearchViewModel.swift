//
//  MTTSearchViewModel.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/10/13.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import SwiftyJSON
import UIKit

class MTTSearchViewModel: NSObject
{
    typealias searchCallBack = (_ dataArray:[[MTTSearchModel]]) -> ()
    
    class func getSearchData(callBack:searchCallBack) -> Void
    {
        var data:Data?
        var callDataArray:[[MTTSearchModel]] = []
        if let filePath = Bundle.main.path(forResource: "MTTSearchData", ofType: "json")
        {
            data = try? Data.init(contentsOf: URL.init(fileURLWithPath: filePath))
        }
        
        let json = JSON.init(data: data!)
        
        let result = json["result"].intValue
        
        if result == 200
        {
            let dataDict                     = json["data"].dictionaryValue
            var labelList:[MTTSearchModel]   = []
            var twitterList:[MTTSearchModel] = []
            var searchList:[MTTSearchModel]  = []
            var popularList:[MTTSearchModel] = []
            let labelCellList                = dataDict["labelCellList"]?.array
            
            for subLabel in labelCellList!
            {
                let searchModel        = MTTSearchModel()
                searchModel.title      = subLabel["title"].stringValue
                searchModel.subTitle   = subLabel["subTitle"].stringValue
                searchModel.cellHeight = 80
                labelList.append(searchModel)
            }
            
            let twitterCellList = dataDict["twitterCellList"]?.array
            for subTwitter in twitterCellList!
            {
                let searchModel                 = MTTSearchModel()
                searchModel.avatarImage         = subTwitter["avatarImage"].stringValue
                searchModel.account             = subTwitter["account"].stringValue
                searchModel.nickName            = subTwitter["nickName"].stringValue
                searchModel.time                = subTwitter["time"].stringValue
                searchModel.content             = subTwitter["content"].stringValue
                searchModel.contentImages       = subTwitter["contentImages"].array
                searchModel.contentVideo        = subTwitter["contentVideo"].stringValue
                searchModel.commentCount        = subTwitter["commentCount"].stringValue
                searchModel.retwitterCount      = subTwitter["retwitterCount"].stringValue
                searchModel.likeCount           = subTwitter["likeCount"].stringValue
                searchModel.privateMessageCount = subTwitter["privateMessageCount"].stringValue
                searchModel.contentTextHeight   = searchModel.content?.calculateTextHeight(text: searchModel.content!)
                searchModel.cellHeight          = 225 + searchModel.contentTextHeight!

                twitterList.append(searchModel)
            }
            
            let popularCellList = dataDict["popularCellList"]?.array
            for subPopular in popularCellList!
            {
                let searchModel         = MTTSearchModel()
                searchModel.website     = subPopular["website"].stringValue
                searchModel.title       = subPopular["title"].stringValue
                searchModel.avatarImage = subPopular["avatarImage"].stringValue
                searchModel.iconImage   = subPopular["iconImage"].stringValue
                searchModel.twitter     = subPopular["twitter"].stringValue
                searchModel.cellHeight  = 120
                popularList.append(searchModel)
            }
            
            let searchAllCellList = dataDict["searchAllCellList"]?.array
            for subSearch in searchAllCellList!
            {
                let searchModel        = MTTSearchModel()
                searchModel.title      = subSearch["title"].stringValue
                searchModel.subTitle   = subSearch["subTitle"].stringValue
                searchModel.cellHeight = 80
                searchList.append(searchModel)
            }
            
            
            callDataArray.append(labelList)
            callDataArray.append(twitterList)
            callDataArray.append(popularList)
            callDataArray.append(searchList)
            
        }
        callBack(callDataArray)
        
    }
}
