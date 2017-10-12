//
//  MTTSearchHeaderView.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/10/12.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTSearchHeaderView: MTTView
{

    var titleLabel:UILabel?
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setupSubview()
        layoutSubview()
        
    }
    
    override func setupSubview()
    {
        super.setupSubview()
        titleLabel = UILabel()
        titleLabel?.textColor = UIColor.black
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel?.textAlignment = NSTextAlignment.left
        self.addSubview(titleLabel!)
    }
    
    override func layoutSubview()
    {
        super.layoutSubview()
        titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.top.equalTo(0)
            make.height.equalTo(self)
            make.right.equalTo(self.snp.right).offset(0)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
