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
        
        return Observable.just(self.getModels()).observeOn(MainScheduler.instance)
    }
    
    func getModels() -> [MTTTabMediaModel] 
    {
        var models:[MTTTabMediaModel] = []
        for _ in 0...30 {
            let model = MTTTabMediaModel()
            model.backgroundImageString = String(format: "media%d", String.getRandomValue(peakValue: 11))
            model.mediaType = String.getRandomValue(peakValue: 2) == 1 ? MTTMediaType.MTTMediaPicture: MTTMediaType.MTTMediaVideo
            model.videoTime = String(format: "%d%d: %d%d", String.getRandomValue(peakValue: 5),String.getRandomValue(peakValue: 9),String.getRandomValue(peakValue: 5),String.getRandomValue(peakValue: 9))
            models.append(model)
        }
        return models
    }
    
    
    
}
