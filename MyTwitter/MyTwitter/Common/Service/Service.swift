//
//  Service.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/9/5.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa

class ValidationService
{
    
    static let instance = ValidationService()
    
    private init ()
    {
        
    }
    
    let kAccountCharactersCount:Int = 20
    
    func validAccount(_ account:String) -> Observable<Result>
    {
        if account.characters.count == 0
        {
            return Observable.just(Result.empty)
        }
        
        if account.characters.count > kAccountCharactersCount
        {
            return Observable.just(Result.failed(messsage: "你的全名不能多于20个字符"))
        }
        
        
        return .just(.ok(message:""))
    }
    
    func accountValid(account:String) -> Bool
    {
        _ = ""
        let parameters =
        NSDictionary.init()
        parameters.setValue(account, forKey: "account")
        
        return true
    }
    
    
}
