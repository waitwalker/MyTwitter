//
//  MTTDataBaseManager.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/12/23.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class MTTDataBaseManager: NSObject
{
    
    func setDefaultRealmForUser(username: String)
    {
        //let realm = try! Realm()
        //print(realm.configuration.fileURL!)
        
        var config = Realm.Configuration()
        
        // 使用默认的目录，但是请将文件名替换为用户名
        //config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("Library/Caches/\(username).realm")
        
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("Library/Caches/myTwitter.realm")
        
        // 将该配置设置为默认 Realm 配置
        Realm.Configuration.defaultConfiguration = config
    }
    
    
    class func setDefaultRealmConfiguration() -> Realm.Configuration
    {
        //let realm = try! Realm()
        //print(realm.configuration.fileURL!)
        
        var config = Realm.Configuration()
        
        // 使用默认的目录，但是请将文件名替换为用户名
        //config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("Library/Caches/\(username).realm")
        
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("Library/Caches/myTwitter.realm")
        
        // 将该配置设置为默认 Realm 配置
        Realm.Configuration.defaultConfiguration = config
        
        return Realm.Configuration.defaultConfiguration
    }
    
    // 保存单条数据
    class func saveChatMessageModel(with model:MTTChatMessageModel) -> Void
    {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(model)
        }
    }
    
    // 获取缓存数据
    class func getAllCacheChatData() -> Results<MTTChatMessageModel>
    {
        let realm = try! Realm()
        
        print(realm.configuration.fileURL as Any)
        
        let models = realm.objects(MTTChatMessageModel.self)
        
        if models.count > 0
        {
            print(models[0].messageContent)
        }
        
        return models
    }
    
}
