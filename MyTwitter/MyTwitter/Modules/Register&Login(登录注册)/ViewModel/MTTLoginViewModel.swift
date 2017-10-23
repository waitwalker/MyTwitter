//
//  MTTLoginViewModel.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/10/23.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import Alamofire

class MTTLoginViewModel: NSObject 
{
    typealias loginCallBack = (_ data:NSDictionary) -> ()
    var delegate:MTTLoginViewModelDelegate?
    
    func getLoginStatus(parameter:NSDictionary) -> Void 
    {
        let urlString = kServer + kLoginAPI
        
        MTTNetworkManager.requestHandler(methods: kMethodType.POST, urlString: urlString, parameters: parameter, successCallBack: { (responseObject) in
            self.delegate?.successCallBack(data: responseObject as! NSDictionary)
        }) { (error) in
            self.delegate?.failureCallBack(error: error)
        }
        
        
    }
}
