//
//  MTTNetworkManager.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/5.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import Alamofire

enum kMethodType {
    case GET,POST
}

class MTTNetworkManager: NSObject 
{
    
    typealias kCallBack = (_ responseObject:AnyObject,_ error:Error)->()
    typealias kSuccessCallBack = (_ responseObject:AnyObject) -> ()
    typealias kFailureCallBack = (_ error:NSError) -> ()
    
    //类方法
    class func requestHandler(methods:kMethodType,urlString:String,parameters:NSDictionary,successCallBack:@escaping kSuccessCallBack,failureCallBack:@escaping kFailureCallBack) -> Void 
    {
        let httpMethod:HTTPMethod
        
        switch methods 
        {
        case .GET:
            httpMethod = HTTPMethod.get
        case .POST:
            httpMethod = HTTPMethod.post
        }
        
            
        Alamofire.request(URL.init(string: urlString)!, method: httpMethod, parameters: (parameters as! Parameters), encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
        
            switch response.result
            {
                
                case .success:
                    successCallBack(response.result.value as AnyObject)
                
                break
                
                case .failure:
                    failureCallBack(response.error! as NSError)
                break
            }
            
        }
    }
}
