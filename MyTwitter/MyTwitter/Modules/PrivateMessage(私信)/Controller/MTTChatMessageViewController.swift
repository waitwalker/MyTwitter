//
//  MTTChatMessageViewController.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/11/28.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class MTTChatMessageViewController: MTTViewController {

    
    
    let messageType:[MTTChatMessageType] = [MTTChatMessageType.picture,MTTChatMessageType.text,MTTChatMessageType.picture,MTTChatMessageType.picture,MTTChatMessageType.voice]
    let imageString:[String] = ["1","2","3","4","5","6","7","8"]
    let messageText:[String] = [
        "初期对我很反感，一点也不热情，很傲，很抵触，也有不少废物测试，但是我的目的就是让她反感，刺激她，但要注意轻重，感受到我的与众不同，然后就是后期吸引了。。。",
        "至此，已经愿意和我聊天啦，然后她回家后（另一个城市）我转战QQ，继续吸引，因为已经有了联系感，所以我开始调戏、挑逗。",
        "作为一个男人，我想说，越是得不到的就会越想追求！你有可能太主动了，让一些男的感觉得到你很容易，当他的优先选项没有得到时，他还会回头找你，把你当备胎了！",
        "看了感觉你还是蛮好的，没碰到有缘的吧。每个人喜欢的类型不同，我相亲的女生兴趣爱好除了看美剧的，就是看书的，让我这种喜欢二次元，喜欢游戏的真心没什么聊天欲望",
        "我想了想，除了她们找到我倾诉的时候，我可以安慰、排解她们的烦恼，我想，她们的故事，也该被更多的人看到，我不是想给她们带去生活的影响，而是让更多的人，去重视婚姻！重视彼此的爱人！",
        "可是我的呐喊，终究是力量薄弱的，所以我要截图她们的故事，让更多的姐妹，也让更多的男人们看到，你们所谓的正常，你们的所作所为，给你的爱人，给你的女人，给你的孩子，甚至给你的家庭，给你自己，带来的都是什么！"
        ]
    
    let timeInterval:[TimeInterval] = [1.0,3.0,2.1,4.0,5.0,3.0,7.0,8.0]
    
    
    var chatMessageToolbar:MTTChatMessageToolBar!
    
    var chatMessageView:MTTChatMessageView!
    
    var photosView:MTTPhotosView!
    
    var videosView:MTTVideosView!
    
    
    var pictureButtonIsSelected:Bool?
    var addButtonIsSelected:Bool?
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupOriginal()
        setupSubview()
        layoutSubview()
    }
    
    func setupOriginal() -> Void
    {
        self.pictureButtonIsSelected = false
        self.addButtonIsSelected = false
    }
    
    private func setupSubview() -> Void
    {
        // 聊天视图
        chatMessageView = MTTChatMessageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 50))
        chatMessageView.delegate = self
        self.view.addSubview(chatMessageView)
        
        // 聊天toolBar
        chatMessageToolbar = MTTChatMessageToolBar(frame: CGRect(x: 0, y: kScreenHeight - 50 - 44 - 5, width: kScreenWidth, height: 50))
        chatMessageToolbar.delegate = self
        chatMessageToolbar.backgroundColor = UIColor.white
        
        chatMessageToolbar.maxLines = 9
        self.view.addSubview(chatMessageToolbar)
        
        // 选择图片
        photosView = MTTPhotosView(frame: CGRect(x: 0, y: kScreenHeight - 150, width: kScreenWidth, height: kScreenHeight))
        photosView.delegate = self
        photosView.isHidden = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.addSubview(photosView)
        
        // 选择视频
        videosView = MTTVideosView(frame: CGRect(x: 0, y: kScreenHeight - 88, width: kScreenWidth, height: 87))
        videosView.isHidden = true
        appDelegate.window?.addSubview(videosView)
        
        let timeInterval = -2000000
        
        
        let string = String.getSuitableDateHint(TimeInterval(timeInterval))
        
        print(string)
        
    }
    
    private func layoutSubview() -> Void
    {
        
    }
    
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

extension MTTChatMessageViewController:
MTTChatMessageViewDelegate,
MTTChatMessageToolBarDelegate,
MTTPhotosViewDelegate
{
    // 发送按钮的点击回调
    func tappedSendButton(text: String)
    {
        let model = MTTChatMessageModel()
        model.messageFrom = MTTChatMessageFromType.My
        model.messageType = MTTChatMessageType.text
        model.chatDate = Date()
        model.chatDateStamp = Date().timeIntervalSince1970
        model.messageContent = text
        model.contentTextHeight = model.messageContent.heightWithFont(fontSize: 18, fixedWidth: 220) > 30 ? model.messageContent.heightWithFont(fontSize: 18, fixedWidth: 220) : 40
        model.contentBackImageHeight = 5 + model.contentTextHeight + 5
        model.cellHeight = 10 + 20 + 10 + model.contentBackImageHeight
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(model)
        }
        self.chatMessageView.dataSource.append(model)
        self.chatMessageView.chatMessageTableView.reloadData()
        print("realm数据库目录:\(realm.configuration.fileURL)")
        self.chatMessageView.chatMessageTableView.scrollToRow(at: IndexPath.init(item: self.chatMessageView.dataSource.count - 1, section: 0), at: UITableViewScrollPosition.bottom, animated: false)
        self.chatMessageToolbar.inputTextView.text = ""
        self.chatMessageToolbar.inputTextView.resignFirstResponder()
        self.messageFromOthers()
    }
    
    // photosView 拖动超过一定距离后的回调
    func photosViewDragDelegate()
    {
        let photosVC = MTTPhotosViewController()
        let nav = UINavigationController(rootViewController: photosVC)
        self.present(nav, animated: false) {
            self.chatMessageToolbar.y = kScreenHeight - 50 - 44 - 5
            self.photosView.isHidden = true
            self.photosView.y = kScreenHeight - 150
        }
    }
    
    // 图片按钮点击回调
    func tappedPictureButton(button: UIButton)
    {
        self.videosView.isHidden = true
        self.chatMessageToolbar.addButton.isSelected = false
        self.addButtonIsSelected = false
        self.chatMessageToolbar.addButton.setImage(UIImage.imageNamed(name: "twitter_add_normal"), for: UIControlState.normal)
        button.isSelected = !button.isSelected
        button.setImage(UIImage.imageNamed(name: "twitter_pictures_selected"), for: UIControlState.selected)
        self.pictureButtonIsSelected = button.isSelected
        if button.isSelected
        {
            UIView.animate(withDuration: 0.1) {
                self.view.endEditing(true)
                let timeInterval:TimeInterval = 0.3
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeInterval, execute: {
                    self.chatMessageToolbar.y = kScreenHeight - 50 - 150
                    self.photosView.isHidden = false
                })
            }
        } else
        {
            UIView.animate(withDuration: 0.1, animations: {
                self.chatMessageToolbar.inputTextView.becomeFirstResponder()
                self.photosView.isHidden = true
                self.videosView.isHidden = true
            })
        }
    }
    
    // 添加视频按钮
    func tappedAddVideoButton(button: UIButton)
    {
        self.photosView.isHidden = true
        self.chatMessageToolbar.pictureButton.isSelected = false
        self.pictureButtonIsSelected = false
        self.chatMessageToolbar.pictureButton.setImage(UIImage.imageNamed(name: "twitter_pictures_normal"), for: UIControlState.normal)
        button.isSelected = !button.isSelected
        button.setImage(UIImage.imageNamed(name: "twitter_add_selected"), for: UIControlState.selected)
        self.addButtonIsSelected = button.isSelected
        if button.isSelected
        {
            UIView.animate(withDuration: 0.1) {
                self.view.endEditing(true)
                let timeInterval:TimeInterval = 0.3
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeInterval, execute: {
                    self.chatMessageToolbar.y = kScreenHeight - 50 - 88
                    self.videosView.isHidden = false
                })
            }
        } else
        {
            UIView.animate(withDuration: 0.1, animations: {
                self.chatMessageToolbar.inputTextView.becomeFirstResponder()
                self.videosView.isHidden = true
                self.photosView.isHidden = true
            })
        }
    }
    
    
    
    // 聊天页面滚动回调
    func chatMessageViewDidScroll()
    {
        if self.chatMessageToolbar.inputTextView.text.count == 0
        {
            self.chatMessageToolbar.inputTextView.resignFirstResponder()
            self.videosView.isHidden = true
            self.photosView.isHidden = true
            if self.pictureButtonIsSelected!
            {
                self.photosView.isHidden = false
                self.videosView.isHidden = true
            } else if self.addButtonIsSelected!
            {
                self.videosView.isHidden = false
                self.photosView.isHidden = true
            }
        }
    }
    
    
}

extension MTTChatMessageViewController
{
    
    
    func messageFromOthers() -> Void
    {
        let mType = self.messageType[String.getRandomValue(peakValue: 5)]
        
        let model = MTTChatMessageModel()
        model.messageFrom = MTTChatMessageFromType.Others
        model.messageType = mType
        model.chatDate = Date()
        model.chatDateStamp = Date().timeIntervalSince1970
        
        switch model.messageType
        {
        case .text:
            model.messageContent = messageText[String.getRandomValue(peakValue: 6)]
            model.contentTextHeight = model.messageContent.heightWithFont(fontSize: 18, fixedWidth: 220) > 30 ? model.messageContent.heightWithFont(fontSize: 18, fixedWidth: 220) : 40
            model.contentBackImageHeight = 5 + model.contentTextHeight + 5
            model.cellHeight = 10 + 20 + 10 + model.contentBackImageHeight
            break
        case .picture:
            model.pictureData = UIImagePNGRepresentation(UIImage.imageNamed(name: imageString[String.getRandomValue(peakValue: 6)]))
            model.contentPictureHeight = 250
            model.contentBackImageHeight = 5 + model.contentPictureHeight + 5
            model.cellHeight = 10 + 20 + 10 + model.contentPictureHeight
            break
        case .voice:
            model.contentVoiceHeight = 40
            model.contentBackImageHeight = 5 + model.contentVoiceHeight + 5
            model.cellHeight = 10 + 20 + 10 + model.contentBackImageHeight
            break
        case .expression:
            break
        case .file:
            break
            
        default:
            break
            
        }
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(model)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeInterval[String.getRandomValue(peakValue: 8)]) {
            self.chatMessageView.dataSource.append(model)
            self.chatMessageView.chatMessageTableView.reloadData()
            self.chatMessageView.chatMessageTableView.scrollToRow(at: IndexPath.init(item: self.chatMessageView.dataSource.count - 1, section: 0), at: UITableViewScrollPosition.bottom, animated: false)
        }
        
        
    }
}

