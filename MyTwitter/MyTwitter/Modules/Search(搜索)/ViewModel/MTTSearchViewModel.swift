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
        }
        
        
        
    }
}
