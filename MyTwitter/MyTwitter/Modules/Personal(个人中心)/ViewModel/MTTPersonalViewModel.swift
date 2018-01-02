

//
//  MTTPersonalViewModel.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/10/25.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTPersonalViewModel: NSObject 
{
    typealias personalCallBack = (_ dataArray:[MTTPersonalModel]) -> ()
    
    
    class func getPersoalData(callBack:personalCallBack) -> Void 
    {
        let icons:[String]  = ["twitter_profile","twitter_list","twitter_flash"]
        let titles:[String] = ["个人资料","列表","瞬间"]
        var dataArray:[MTTPersonalModel] = []
        
        for index in Int(0)...icons.count - 1 
        {
            let personalModel             = MTTPersonalModel()
            personalModel.iconImageString = icons[index]
            personalModel.title           = titles[index]
            dataArray.append(personalModel)
        }
        callBack(dataArray)
    }
}
