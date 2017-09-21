//
//  MTTAboutViewModel.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/21.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import SwiftyJSON

class MTTAboutViewModel: NSObject 
{
    typealias aboutCallBack = (_ originalData:[[MTTAboutModel]])->()
    class func getAboutTwitterData(callBack:aboutCallBack) -> Void 
    {
        var data:Data?
        
        if let filePath = Bundle.main.path(forResource: "AboutTwitterData", ofType: "json") 
        {
            data = try? Data.init(contentsOf: URL.init(fileURLWithPath: filePath))
        }
        
        
        var typeOneArray:[MTTAboutModel] = []
        var typeTwoArray:[MTTAboutModel] = []
        var typeThreeArray:[MTTAboutModel] = []
        var dataSource:[[MTTAboutModel]] = [[]]
        
        
        let json = JSON.init(data: data!)
        
        let result = json["result"].intValue
        
        if result == 1
        {
            if let dataArray = json["data"].array
            {
                for(subjson) in dataArray
                {
                    let aboutModel = MTTAboutModel()
                    aboutModel.title = subjson["title"].string
                    aboutModel.urlString = subjson["urlString"].string
                    aboutModel.type = subjson["type"].intValue
                    aboutModel.subType = subjson["subType"].intValue
                    if aboutModel.type == 0
                    {
                        typeOneArray.append(aboutModel)
                    } else if aboutModel.type == 1
                    {
                        typeTwoArray.append(aboutModel)
                    } else
                    {
                        typeThreeArray.append(aboutModel)
                    }
                    
                }
                
                typeTwoArray.sort(by: { (model1, model2) -> Bool in
                    model1.subType! < model2.subType!
                })
                
                typeThreeArray.sort(by: { (model1, model2) -> Bool in
                    model1.subType! < model2.subType!
                })
                
                dataSource.append(typeOneArray)
                dataSource.append(typeTwoArray)
                dataSource.append(typeThreeArray)
                dataSource.remove(at: 0)
            }
        }
        
        callBack(dataSource)
    }
}
