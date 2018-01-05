//
//  MTTChatMessageView.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/12/5.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class MTTChatMessageView: MTTView {

    var reusedChatMessageNoneCellId:String = "reusedChatMessageNoneCellId"
    var reusedChatMessageCellId:String     = "reusedChatMessageCellId"
    
    var chatMessageTableView:UITableView!
    
    var dataSource:Results<MTTChatMessageModel>?
    
    var delegate:MTTChatMessageViewDelegate?
    
    var currentSelectId:String = "bb"
    var currentSelectIndexPath:IndexPath = IndexPath(item: 1, section: 100)
    
    
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        //loadChatMessageData()
        
        loadDataFromLocal()
        
        setupNotification()
    }
    
    override func setupSubview()
    {
        chatMessageTableView                 = UITableView()
        chatMessageTableView.backgroundColor = UIColor.white
        chatMessageTableView.delegate        = self
        chatMessageTableView.dataSource      = self
        chatMessageTableView.register(UITableViewCell.self, forCellReuseIdentifier: reusedChatMessageNoneCellId)
        chatMessageTableView.register(MTTChatMessageCell.self, forCellReuseIdentifier: reusedChatMessageCellId)
        chatMessageTableView.separatorStyle  = UITableViewCellSeparatorStyle.none
        self.addSubview(chatMessageTableView)
    }
    
    override func layoutSubview()
    {
        super.layoutSubview()
        chatMessageTableView.frame = self.bounds
    }
    
    public func loadDataFromLocal() -> Void
    {
        self.dataSource = MTTDataBaseManager.getAllCacheChatData()
        
        self.chatMessageTableView.reloadData()
        if (self.dataSource?.count)! > Int(1)
        {
            self.chatMessageTableView.scrollToRow(at: IndexPath(item: (self.dataSource?.count)! - 1, section: 0), at: UITableViewScrollPosition.bottom, animated: false)
        }
        
        let queue = DispatchQueue(
            label: "realmQueue", 
            qos: DispatchQoS.default, 
            attributes: DispatchQueue.Attributes.concurrent, 
            autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.never, 
            target: nil)
        queue.async {
            //let realm = try! Realm(configuration: MTTDataBaseManager.setDefaultRealmConfiguration())
            
            autoreleasepool {
                
            }
//            DispatchQueue.main.async {
//                self.chatMessageTableView.reloadData()
//            }
        }
        
    }
    
        
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNotification() -> Void
    {
        NotificationCenter.default.addObserver(self, selector: #selector(handleRecorderPlayFinish), name: NSNotification.Name(rawValue: kRecorderPlayFinishNotificationString), object: nil)
    }
    
    func handleRecorderPlayFinish() -> Void
    {
        resetData()
        self.chatMessageTableView.reloadData()
    }
    
    func resetData() -> Void
    {
        let realm = try! Realm()
        realm.beginWrite()
        let predicate = NSPredicate(format: "id = %@", self.currentSelectId)
        
        let theModels = realm.objects(MTTChatMessageModel.self).filter(predicate)
        let theModel = theModels.first
        
        if theModel?.contentVoiceIsPlaying == 0
        {
            theModel?.contentVoiceIsPlaying = 1
        } else
        {
            theModel?.contentVoiceIsPlaying = 0
        }
        
        try! realm.commitWrite()
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    

}

extension MTTChatMessageView:
UITableViewDelegate,
UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataSource!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if (self.dataSource?.count)! > Int(0)
        {
            var cell = tableView.dequeueReusableCell(withIdentifier: reusedChatMessageCellId) as? MTTChatMessageCell
            if cell == nil
            {
                cell = MTTChatMessageCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedChatMessageCellId)
            }
            print(self.dataSource![indexPath.item])
            //cell?.chatMessageModel = self.dataSource[indexPath.item]
            cell?.setChatMessageModel(model: self.dataSource![indexPath.item])
            return cell!
        } else
        {
            var cell = tableView.dequeueReusableCell(withIdentifier: reusedChatMessageNoneCellId)
            if cell == nil
            {
                cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: reusedChatMessageNoneCellId)
            }
            cell?.textLabel?.text = "\(indexPath.item)"
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if (self.dataSource?.count)! > 0
        {
            let model = self.dataSource![indexPath.item]
            return CGFloat(model.cellHeight)
        } else
        {
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if (self.dataSource?.count)! > 0 
        {
            let model = self.dataSource![indexPath.item]
            
            switch model.messageType
            {
                // 文本
            case 0:
                break
                
                // 图片 
            case 1:
                break
                
                // 语音 
            case 2:
                
                
                self.currentSelectId = model.id
                if self.currentSelectIndexPath == indexPath
                {
                    
                    let realm = try! Realm()
                    realm.beginWrite()
                    
                    if model.contentVoiceIsPlaying == 0
                    {
                        model.contentVoiceIsPlaying = 1
                    } else
                    {
                        model.contentVoiceIsPlaying = 0
                    }
                    try! realm.write {
                        realm.add(model, update: true)
                    }
                } else
                {
                    self.resetData()
                    
                    self.currentSelectIndexPath = indexPath
                    
                }
                self.chatMessageTableView.reloadData()
                
                print("model.contentVoiceIsPlaying:\(model.contentVoiceIsPlaying)")
                
                print("model.contentVoiceIsPlaying:\(model.contentVoiceIsPlaying)")
                
                break
                
            default:
                break
            }
            
            
        }
        
        print("选中行数:\(indexPath.item)")
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let contentOffset = scrollView.contentOffset
        
        if contentOffset.y < -64
        {
            
        }
        print(contentOffset)
        self.delegate?.chatMessageViewDidScroll()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView)
    {
        self.delegate?.chatMessageViewDidScroll()
    }
    
}
