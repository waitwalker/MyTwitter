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
            let dataDict = json["data"].dictionaryValue
            print(dataDict)
            var labelList:[MTTSearchModel] = []
            var twitterList:[MTTSearchModel] = []
            var searchList:[MTTSearchModel] = []
            var popularList:[MTTSearchModel] = []
            
            
            
            let labelCellList = dataDict["labelCellList"]?.array
            
            for subLabel in labelCellList!
            {
                let searchModel = MTTSearchModel()
                searchModel.title = subLabel["title"].stringValue
                searchModel.subTitle = subLabel["subTitle"].stringValue
                searchModel.cellHeight = 80
                labelList.append(searchModel)
            }
            
            let twitterCellList = dataDict["twitterCellList"]?.array
            for subTwitter in twitterCellList!
            {
                let searchModel = MTTSearchModel()
                searchModel.avatarImage = subTwitter["avatarImage"].stringValue
                searchModel.account = subTwitter["account"].stringValue
                searchModel.nickName = subTwitter["nickName"].stringValue
                searchModel.time = subTwitter["time"].stringValue
                searchModel.content = subTwitter["content"].stringValue
                searchModel.contentImages = subTwitter["contentImages"].array
                searchModel.contentVideo = subTwitter["contentVideo"].stringValue
                searchModel.commentCount = subTwitter["commentCount"].stringValue
                searchModel.retwitterCount = subTwitter["retwitterCount"].stringValue
                searchModel.likeCount = subTwitter["likeCount"].stringValue
                searchModel.privateMessageCount = subTwitter["privateMessageCount"].stringValue
                
                twitterList.append(searchModel)
            }
            
            let searchAllCellList = dataDict["searchAllCellList"]?.array
            for subSearch in searchAllCellList!
            {
                let searchModel = MTTSearchModel()
                searchModel.website = subSearch["website"].stringValue
                searchModel.title = subSearch["title"].stringValue
                searchModel.avatarImage = subSearch["avatarImage"].stringValue
                searchModel.iconImage = subSearch["iconImage"].stringValue
                searchModel.twitter = subSearch["twitter"].stringValue
                searchModel.cellHeight = 120
                searchList.append(searchModel)
            }
            
            let popularCellList = dataDict["popularCellList"]?.array
            for subPopular in popularCellList!
            {
                let searchModel = MTTSearchModel()
                searchModel.title = subPopular["title"].stringValue
                searchModel.subTitle = subPopular["subTitle"].stringValue
                searchModel.cellHeight = 80
                popularList.append(searchModel)
            }
            
            callDataArray.append(labelList)
            callDataArray.append(twitterList)
            callDataArray.append(searchList)
            callDataArray.append(popularList)
            
        }
        print(callDataArray as Any)
        callBack(callDataArray)
        
    }
}
