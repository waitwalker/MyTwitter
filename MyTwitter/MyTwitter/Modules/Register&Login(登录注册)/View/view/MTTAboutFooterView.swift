//
//  MTTAboutFooterView.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/21.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTAboutFooterView: MTTView {

    var titleLabel:UILabel?
    
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
        titleLabel = UILabel()
        titleLabel?.textAlignment = NSTextAlignment.center
        titleLabel?.text = "版权所有 © 2017 Twitter,Inc."
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        titleLabel?.textColor = kMainTextGrayColor()
        self.addSubview(titleLabel!)
    }
    
    internal override func layoutSubview() 
    {
        titleLabel?.snp.makeConstraints({ (make) in
            make.top.left.bottom.right.equalTo(self)
        })
    }

}
