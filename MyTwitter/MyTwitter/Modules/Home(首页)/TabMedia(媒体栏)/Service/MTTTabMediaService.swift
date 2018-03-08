//
//  MTTTabMediaService.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2018/3/8.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MTTTabMediaService: NSObject {

    static let sharedMediaService = MTTTabMediaService()
    override init() {
        
    }
    
    func networkRequest(parameter:[String:Any]) -> Observable<[MTTTabMediaModel]> {
        
        let model = MTTTabMediaModel()
        
        var arr:[MTTTabMediaModel] = []
        arr.append(model)
        
        return Observable.just(arr).observeOn(MainScheduler.instance)
    }
    
}
