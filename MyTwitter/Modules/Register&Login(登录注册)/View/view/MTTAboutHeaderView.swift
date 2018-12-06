//
//  MTTAboutHeaderView.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/21.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTAboutHeaderView: MTTView 
{
    var headerTitleLabel:UILabel?
    
    
    override init(frame: CGRect) 
    {
        super.init(frame: frame)
        self.setupSubview()
        self.layoutSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal override func setupSubview() 
    {
        headerTitleLabel                = UILabel()
        headerTitleLabel?.textColor     = kMainTextGrayColor()
        headerTitleLabel?.textAlignment = NSTextAlignment.left
        headerTitleLabel?.font          = UIFont.boldSystemFont(ofSize: 18)
        self.addSubview(headerTitleLabel!)
    }
    
    internal override func layoutSubview() 
    {
        headerTitleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.height.equalTo(self)
            make.right.equalTo(self.snp.right).offset(0)
            make.top.equalTo(self).offset(0)
        })
    }

}
