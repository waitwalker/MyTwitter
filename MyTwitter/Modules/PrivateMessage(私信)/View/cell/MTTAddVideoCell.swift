//
//  MTTAddVideoCell.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/12/18.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTAddVideoCell: MTTCollectionViewCell
{
    var iconImageView:UIImageView!
    var vTitleLabel:UILabel!
    var lineView:UIView!
    
    
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setupSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        layoutSubview()
    }
    
    func setupSubview() -> Void
    {
        self.contentView.backgroundColor       = UIColor.white

        iconImageView                          = UIImageView()
        iconImageView.isUserInteractionEnabled = true
        self.contentView.addSubview(iconImageView)

        lineView                               = UIView()
        lineView.backgroundColor               = kMainLightGrayColor()
        self.contentView.addSubview(lineView)

        vTitleLabel                            = UILabel()
        vTitleLabel.textColor                  = UIColor.black
        vTitleLabel.font                       = UIFont.boldSystemFont(ofSize: 18)
        vTitleLabel.textAlignment              = NSTextAlignment.left
        vTitleLabel.sizeToFit()
        self.contentView.addSubview(vTitleLabel)
    }
    
    func layoutSubview() -> Void
    {
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(0)
            make.height.equalTo(1)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(24)
            make.left.equalTo(20)
            make.centerY.equalTo(self.contentView)
        }
        
        vTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconImageView.snp.right).offset(10)
            make.height.top.equalTo(self.contentView)
        }
    }
}
