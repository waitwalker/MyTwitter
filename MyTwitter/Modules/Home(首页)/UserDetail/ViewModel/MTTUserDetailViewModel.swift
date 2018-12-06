//
//  MTTUserDetailViewModel.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2018/3/5.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

class MTTUserDetailViewModel: NSObject {

    var models:Driver<[MTTHomeModel]>
    
    init(parameters:Observable<[String:Any]>,service:MTTBaseService) 
    {
        models = parameters
            .observeOn(ConcurrentDispatchQueueScheduler(qos: DispatchQoS.background))
            .flatMap{ element in 
                return service.getTweetData(parameter: element)
        }.asDriver(onErrorJustReturn:[])
    }
    
    
    
}
