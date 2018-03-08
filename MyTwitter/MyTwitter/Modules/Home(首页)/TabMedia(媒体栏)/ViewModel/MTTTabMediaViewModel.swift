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
    var mediaModels:Driver<[MTTTabMediaModel]> = Variable<[MTTTabMediaModel]>([]).asDriver()
    
    func getMediaData(parameter:Observable<[String:Any]>) -> Void
    {
        mediaModels = parameter
            .observeOn(ConcurrentDispatchQueueScheduler(qos: DispatchQoS.background))
            .flatMap{para in 
                
                return MTTTabMediaService.sharedMediaService.networkRequest(parameter: para)
        }.asDriver(onErrorJustReturn: [])
    }
    
}
