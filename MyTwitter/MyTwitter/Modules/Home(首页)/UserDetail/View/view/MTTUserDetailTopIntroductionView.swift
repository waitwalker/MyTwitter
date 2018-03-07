//
//  MTTUserDetailTopIntroductionView.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2018/3/7.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

/*********
 个人详情顶部简介视图 
 *********/

import UIKit
import SnapKit

class MTTUserDetailTopIntroductionView: MTTView 
{
    
    var titleLabel:UILabel!
    var subtitleLabel:UILabel!
    var introductionLabel:UILabel!
    var localLabel:UILabel!
    var hyperlinkButton:UIButton!
    var followingLabel:UILabel! //关注label
    var followerLabel:UILabel!  //关注者label 
    
    
    
    
    
    
    

    override init(frame: CGRect) 
    {
        super.init(frame: frame)
    }
    
    override func setupSubview() 
    {
        super.setupSubview()
        
        titleLabel               = UILabel()
        titleLabel.text = "华尔街中文网"
        titleLabel.textColor     = UIColor.black
        titleLabel.textAlignment = NSTextAlignment.left
        titleLabel.font          = UIFont.boldSystemFont(ofSize: 18)
        self.addSubview(titleLabel)
        
        subtitleLabel = UILabel()
        subtitleLabel.textColor = kMainGrayColor()
        subtitleLabel.font = UIFont.systemFont(ofSize: 15)
        subtitleLabel.textAlignment = NSTextAlignment.left
        self.addSubview(subtitleLabel)
        
        
    }
    
    override func layoutSubview() 
    {
        super.layoutSubview()
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(self).offset(20)
            make.top.equalTo(self)
            make.height.equalTo(25)
            make.right.equalTo(self).offset(-20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

}
