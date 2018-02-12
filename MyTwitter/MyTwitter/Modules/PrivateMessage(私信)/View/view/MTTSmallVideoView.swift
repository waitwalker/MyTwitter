//
//  MTTSmallVideoView.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2018/2/12.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

/********
 小视频视图 
 ********/

import UIKit

class MTTSmallVideoView: MTTView {

    var containerView:UIView!
    
    
    
    override init(frame: CGRect) 
    {
        super.init(frame: frame)
    }
    
    override func setupSubview() 
    {
        containerView = UIView()
        containerView.backgroundColor = kMainGrayColor().withAlphaComponent(0.3)
        self.addSubview(containerView)
    }
    
    override func layoutSubview() 
    {
        containerView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalTo(self)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
