//
//  MTTSearchSectionHeaderView.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/8.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTSearchSectionHeaderView: MTTView 
{

    var titleLabel:UILabel?
    
    
    override init(frame: CGRect) 
    {
        super.init(frame: frame)
        self.backgroundColor = kRGBColor(r: 230, g: 236, b: 240)
        self.setupSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() 
    {
        super.layoutSubviews()
        self.layoutSubview()
    }
    
    override func setupSubview() -> Void 
    {
        titleLabel = UILabel()
        titleLabel?.textColor = kRGBColor(r: 92, g: 112, b: 127)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel?.textAlignment = NSTextAlignment.left
        self.addSubview(titleLabel!)
    }
    
    override func layoutSubview() -> Void 
    {
        titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(0)
            make.bottom.top.equalTo(self).offset(0)
        })
        
    }
}
