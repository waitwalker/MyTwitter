//
//  MTTRegitserViewModel.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/6.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Alamofire
import SwiftyJSON


class MTTRegitserViewModel: NSObject
{
    
    var delegate:MTTRegitserViewModelDelegate?
    
    func requestRegister(parameters:NSDictionary) -> Void
    {
        let urlString = kServer + kRegisterAPI
        
        MTTNetworkManager.requestHandler(methods: kMethodType.POST, urlString: urlString, parameters: parameters, successCallBack: { (responseObject) in
            
            let json = JSON(responseObject)
            
            print("json:",json)
            
            self.delegate?.successCallBack(data: responseObject as! NSDictionary)
            
        }) { (error) in
            self.delegate?.failureCallBack(error: error)
            print(error)
        }
    }
}
