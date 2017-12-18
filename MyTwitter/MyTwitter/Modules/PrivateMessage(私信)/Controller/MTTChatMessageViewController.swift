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
    
    var pictureButtonIsSelected:Bool?
    
    
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
            })
        }
        
        
    }
    
    // 聊天页面滚动回调
    func chatMessageViewDidScroll()
    {
        if self.chatMessageToolbar.inputTextView.text.count == 0
        {
            self.chatMessageToolbar.inputTextView.resignFirstResponder()
            if self.pictureButtonIsSelected!
            {
                self.photosView.isHidden = false
            } else
            {
                self.photosView.isHidden = true
            }
            return
        }
    }
    
    
}

