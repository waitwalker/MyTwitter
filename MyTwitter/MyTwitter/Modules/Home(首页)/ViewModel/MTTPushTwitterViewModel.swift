//
//  MTTPushTwitterViewModel.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/10/24.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MTTPushTwitterViewModel: NSObject
{
    var delegate:MTTPushNewTwitterDelegate?
    
    
    typealias pushTwitterCallBack = (_ responseObject:NSDictionary) -> ()
    
    func getPushTwitterStatus(parameters:NSDictionary) -> Void
    {
        let urlString = kServer + kPushNewTwitter
        
        MTTNetworkManager.requestHandler(methods: kMethodType.POST, urlString: urlString, parameters: parameters, successCallBack: { (responseObj) in
            self.delegate?.successCallBack(data: responseObj as! NSDictionary)
        }) { (error) in
            self.delegate?.failureCallBack(error: error)
        }
        
        
    }
}
