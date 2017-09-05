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
    
    //类方法
    class func requestHandler(methods:kMethodType,urlString:String,parameters:NSDictionary,callBack:@escaping kCallBack) -> Void 
    {
        let httpMethod:HTTPMethod
        
        switch methods 
        {
        case .GET:
            httpMethod = HTTPMethod.get
        case .POST:
            httpMethod = HTTPMethod.post
        }
        
        assert(urlString.characters.count == 0, "输入地址不能为空")
            
        Alamofire.request(URL.init(string: urlString)!, method: httpMethod, parameters: (parameters as! Parameters), encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            callBack(response.result.value as AnyObject, response.result.error!)
        }
    }
}

class MTTRegisterNetworkHandler: MTTNetworkManager 
{
    
}
