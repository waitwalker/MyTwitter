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
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupSubview()
        layoutSubview()

    }
    
    private func setupSubview() -> Void
    {
        chatMessageToolbar = MTTChatMessageToolBar()
        chatMessageToolbar.backgroundColor = UIColor.orange
        self.view.addSubview(chatMessageToolbar)
    }
    
    private func layoutSubview() -> Void
    {
        chatMessageToolbar.frame = CGRect(x: 0, y: kScreenHeight - 50 - 44, width: kScreenWidth, height: 50)
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
