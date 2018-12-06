//
//  MTTTabMediaViewModel.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2018/3/8.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MTTTabMediaViewModel: NSObject 
{
    var mediaModels:Driver<[MTTTabMediaModel]>
    
    init(parameter:Observable<[String:Any]>) {
        mediaModels = parameter
            .observeOn(ConcurrentDispatchQueueScheduler(qos: DispatchQoS.background))
            .flatMap{ element in 
                return MTTTabMediaService.sharedMediaService.networkRequest(parameter: element)
            }.asDriver(onErrorJustReturn: [])
    }
    
    
}
