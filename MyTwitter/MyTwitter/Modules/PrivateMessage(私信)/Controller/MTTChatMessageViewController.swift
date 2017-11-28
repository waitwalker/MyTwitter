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
        chatMessageToolbar.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(50)
            make.bottom.equalTo(self.view.snp.bottom).offset(-54)
        }
    }


}
