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

    // 灰色背景容器 
    var containerView:UIView!
    
    // 视频相关容器 
    var videoContainerView:UIView!
    
    // 视频顶部bar
    var videoTopBarView:UIView!
    
    
    
    override init(frame: CGRect) 
    {
        super.init(frame: frame)
    }
    
    override func setupSubview() 
    {
        containerView = UIView()
        containerView.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
        self.addSubview(containerView)
        
        videoContainerView = UIView()
        videoContainerView.backgroundColor = UIColor.black
        containerView.addSubview(videoContainerView)
    }
    
    override func layoutSubview() 
    {
        containerView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalTo(self)
        }
        
        videoContainerView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(self).offset(260)
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
