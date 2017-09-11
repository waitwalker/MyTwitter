//
//  MTTRegularMatchManager.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/9/11.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTRegularMatchManager: NSObject
{
    // MARK: - 匹配邮箱
    class func validateEmail(email:String) -> Bool
    {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    // MARK: - 匹配手机号
    class func validateMobile(phone:String) -> Bool
    {
        let phoneRegex: String = "^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
    
    // MARK: - 匹配密码
    class func validatePassword(password:String) -> Bool
    {
        let  passWordRegex = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$"
        let passWordPredicate = NSPredicate(format: "SELF MATCHES%@", passWordRegex)
        return passWordPredicate.evaluate(with: password)
    }
    
    // MARK: - 匹配用户名
    class func validateUserName(username:String) -> Bool
    {
        let userNameRegex = "^[A-Za-z0-9]{6,20}+$"
        let userNamePredicate = NSPredicate(format: "SELF MATCHES %@", userNameRegex)
        let peopleName = userNamePredicate.evaluate(with: username)
        return peopleName
    }
    
    
}
