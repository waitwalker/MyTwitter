//
//  MTTAboutViewModel.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/21.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class MTTAboutViewModel: NSObject 
{
    typealias aboutCallBack = (_ originalData:[[MTTAboutModel]])->()
    class func getAboutTwitterData(callBack:@escaping aboutCallBack) -> Void 
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
        
        let urlString = kServer + kAboutAPI
        
        Alamofire.request(URL.init(string: urlString)!, method: HTTPMethod.get, parameters: [:], encoding: URLEncoding.default, headers: nil).responseJSON { (responseData) in
            
            switch responseData.result
            {
                case .success:
                    let value = responseData.result.value
                    print(value as Any)
                    let json = JSON(value as Any)
                    let result = json["result"].intValue
                    var typeOneArrays:[MTTAboutModel] = []
                    var typeTwoArrays:[MTTAboutModel] = []
                    var typeThreeArrays:[MTTAboutModel] = []
                    var dataSources:[[MTTAboutModel]] = [[]]
                    if result == 200
                    {
                        if let dataArrays = json["data"].array
                        {
                            for(subjson) in dataArrays
                            {
                                let aboutModel = MTTAboutModel()
                                aboutModel.title = subjson["title"].string
                                aboutModel.urlString = subjson["urlString"].string
                                aboutModel.type = subjson["type"].intValue
                                aboutModel.subType = subjson["subType"].intValue
                                if aboutModel.type == 0
                                {
                                    typeOneArrays.append(aboutModel)
                                } else if aboutModel.type == 1
                                {
                                    typeTwoArrays.append(aboutModel)
                                } else
                                {
                                    typeThreeArrays.append(aboutModel)
                                }
                                
                            }
                            
                            typeTwoArrays.sort(by: { (model1, model2) -> Bool in
                                model1.subType! < model2.subType!
                            })
                            
                            typeThreeArrays.sort(by: { (model1, model2) -> Bool in
                                model1.subType! < model2.subType!
                            })
                            
                            dataSources.append(typeOneArrays)
                            dataSources.append(typeTwoArrays)
                            dataSources.append(typeThreeArrays)
                            dataSources.remove(at: 0)
                        }
                        callBack(dataSources)
                        
                    } else
                    {
                        callBack(dataSource)
                    }
                    
                break
                
                case .failure:
                    callBack(dataSource)
                break
            }
        }
        
    }
}
