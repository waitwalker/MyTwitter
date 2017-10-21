//
//  MTTMessageViewModel.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/10/21.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import SwiftyJSON

class MTTMessageViewModel: NSObject
{
    typealias mailBoxCallBack = (_ dataArray:[MTTMessageModel])->()
    typealias requestCallBack = (_ dataArray:[MTTMessageModel])->()
    
    class func getMailBoxData(callBack:mailBoxCallBack) -> Void
    {
        var dataArray:[MTTMessageModel] = []
        
        var data:Data?
        if let filePath = Bundle.main.path(forResource: "MTTMessageMailBoxData", ofType: "json")
        {
            data = try? Data(contentsOf: URL(fileURLWithPath: filePath))
        }
        
        let json = JSON(data: data!)
        
        let result = json["result"].intValue
        
        if result == 200
        {
            if let dataArr = json["data"].array
            {
                for subjson in dataArr
                {
                    let messageModel = MTTMessageModel()
                    messageModel.account = subjson["account"].stringValue
                    messageModel.nickName = subjson["nickName"].stringValue
                    messageModel.avatarImage = subjson["avatarImage"].stringValue
                    messageModel.time = subjson["time"].stringValue
                    messageModel.content = subjson["content"].stringValue
                    dataArray.append(messageModel)
                }
            }
        }
        callBack(dataArray)
    }
    
    class func getRequestData(callBack:requestCallBack) -> Void
    {
        var dataArray:[MTTMessageModel] = []
        
        var data:Data?
        if let filePath = Bundle.main.path(forResource: "MTTMessageRequestData", ofType: "json")
        {
            data = try? Data(contentsOf: URL(fileURLWithPath: filePath))
        }
        
        let json = JSON(data: data!)
        
        let result = json["result"].intValue
        
        if result == 200
        {
            if let dataArr = json["data"].array
            {
                for subjson in dataArr
                {
                    let messageModel = MTTMessageModel()
                    messageModel.account = subjson["account"].stringValue
                    messageModel.nickName = subjson["nickName"].stringValue
                    messageModel.avatarImage = subjson["avatarImage"].stringValue
                    messageModel.time = subjson["time"].stringValue
                    messageModel.content = subjson["content"].stringValue
                    dataArray.append(messageModel)
                }
            }
        }
        callBack(dataArray)
    }
}
