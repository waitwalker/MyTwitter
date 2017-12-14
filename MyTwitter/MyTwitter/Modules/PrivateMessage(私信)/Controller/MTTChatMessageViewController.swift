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
//        chatMessageView = MTTChatMessageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 50))
//        chatMessageView.delegate = self
//        self.view.addSubview(chatMessageView)
//        
//        chatMessageToolbar = MTTChatMessageToolBar(frame: CGRect(x: 0, y: kScreenHeight - 50 - 44 - 5, width: kScreenWidth, height: 50))
//        chatMessageToolbar.backgroundColor = UIColor.white
//        
//        chatMessageToolbar.maxLines = 9
//        self.view.addSubview(chatMessageToolbar)
        
        photosView = MTTPhotosView(frame: CGRect(x: 0, y: 300, width: kScreenWidth, height: kScreenHeight - 350))
        self.view.addSubview(photosView)
        
    }
    
    private func layoutSubview() -> Void
    {
        
    }
    
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

extension MTTChatMessageViewController:
MTTChatMessageViewDelegate
{
    func chatMessageViewDidScroll()
    {
        self.chatMessageToolbar.inputTextView.resignFirstResponder()
    }
    
    
}

