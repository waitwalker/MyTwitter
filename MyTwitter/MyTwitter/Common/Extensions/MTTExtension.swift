//
//  MTTExtension.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/9/20.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


enum Result
{
    case ok(message:String)
    case empty
    case failed(messsage:String)
}

extension Result
{
    var isValid:Bool
    {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
    
}

extension Result
{
    var description:String
    {
        switch self {
        case let .ok(message):
            return message
        case .empty:
            return ""
        case let .failed(message):
            return message
        }
    }
    
}



