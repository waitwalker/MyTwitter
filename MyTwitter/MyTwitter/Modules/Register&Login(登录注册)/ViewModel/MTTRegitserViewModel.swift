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


class MTTRegitserViewModel: NSObject 
{
    
    
    class func requestRegister(parameters:NSDictionary) -> String 
    {
        var resultString:String = ""
        
        let urlString = kServer + kRegisterAPI
        
//        Alamofire.request(URL.init(string: urlString)!, method: HTTPMethod.post, parameters: parameters as? Parameters, encoding:URLEncoding.default, headers: nil).responseJSON { (reponse) in
//        
//            resultString = "2"
//            return resultString
//        }
        
        MTTNetworkManager.requestHandler(methods: kMethodType.POST, urlString: urlString, parameters: parameters, successCallBack: { (responseObject) in
            
            print("返回的结果",responseObject)
            resultString = "1"
            print("successResultString:",resultString)
            
        }) { (error) in
            print(error)
            resultString = "0"
            print("failureResultString:",resultString)
        }
        print("resultString",resultString)
        
        return resultString
    }
}
