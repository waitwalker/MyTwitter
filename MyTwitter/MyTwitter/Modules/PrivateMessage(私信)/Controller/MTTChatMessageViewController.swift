//
//  MTTChatMessageViewController.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/11/28.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTChatMessageViewController: MTTViewController {

    var chatMessageToolbar:MTTChatMessageToolBar!
    
    var chatMessageView:MTTChatMessageView!
    
    var photosView:MTTPhotosView!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupSubview()
        layoutSubview()
    }
    
    private func setupSubview() -> Void
    {
        chatMessageView = MTTChatMessageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 50))
        chatMessageView.delegate = self
        self.view.addSubview(chatMessageView)
        
        chatMessageToolbar = MTTChatMessageToolBar(frame: CGRect(x: 0, y: kScreenHeight - 50 - 44 - 5, width: kScreenWidth, height: 50))
        chatMessageToolbar.delegate = self
        chatMessageToolbar.backgroundColor = UIColor.white
        
        chatMessageToolbar.maxLines = 9
        self.view.addSubview(chatMessageToolbar)
        
        photosView = MTTPhotosView(frame: CGRect(x: 0, y: kScreenHeight - 150, width: kScreenWidth, height: kScreenHeight))
        photosView.delegate = self
        photosView.isHidden = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.addSubview(photosView)
        
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
    // photosView 拖动超过一定距离后的回调
    func photosViewDragDelegate()
    {
        self.chatMessageToolbar.y = kScreenHeight - 50 - 44 - 5
        self.photosView.isHidden = true
        let homeVC = MTTHomeViewController()
        self.navigationController?.pushViewController(homeVC, animated: false)
        
    }
    
    // 图片按钮点击回调
    func tappedPictureButton()
    {
        UIView.animate(withDuration: 0.3) {
            self.chatMessageToolbar.y = kScreenHeight - 50 - 150
            self.photosView.isHidden = false
        }
    }
    
    // 聊天页面滚动回调
    func chatMessageViewDidScroll()
    {
        self.chatMessageToolbar.inputTextView.resignFirstResponder()
    }
    
    
}

