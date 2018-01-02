//
//  MTTPushBottomCell.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/10/4.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTPushBottomCell: MTTCollectionViewCell
{
    var innerImageView:UIImageView?
    var innerTitleLabel:UILabel?
    var backgroundImageView:UIImageView?
    
    
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setupSubview()
        layoutSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubview() -> Void
    {
        //backgroundImageView
        backgroundImageView                           = UIImageView()
        backgroundImageView?.isUserInteractionEnabled = true
        backgroundImageView?.layer.cornerRadius       = 10
        backgroundImageView?.clipsToBounds            = true
        backgroundImageView?.layer.borderColor        = kMainLightGrayColor().cgColor
        backgroundImageView?.layer.borderWidth        = 1
        self.contentView.addSubview(backgroundImageView!)

        //innerImageView
        innerImageView                                = UIImageView()
        innerImageView?.isUserInteractionEnabled      = true
        innerImageView?.image                         = UIImage.init(named: "twitter_camera")
        backgroundImageView?.addSubview(innerImageView!)

        //innerTitleLabel
        innerTitleLabel                               = UILabel()
        innerTitleLabel?.textAlignment                = NSTextAlignment.center
        innerTitleLabel?.text                         = "相机"
        innerTitleLabel?.textColor                    = kMainGrayColor()
        innerTitleLabel?.font                         = UIFont.systemFont(ofSize: 15)
        backgroundImageView?.addSubview(innerTitleLabel!)
        
    }
    
    private func layoutSubView() -> Void
    {
        //backgroundImageView
        backgroundImageView?.snp.makeConstraints({ (make) in
            make.left.right.bottom.top.equalTo(0)
        })
        
        //innerImageView
        innerImageView?.snp.makeConstraints({ (make) in
            make.top.equalTo(10)
            make.width.height.equalTo(32)
            make.centerX.equalTo(self.backgroundImageView!)
        })
        
        //innerTitleLabel
        innerTitleLabel?.snp.makeConstraints({ (make) in
            make.width.equalTo(60)
            make.height.equalTo(15)
            make.top.equalTo((self.innerImageView?.snp.bottom)!).offset(2)
            make.centerX.equalTo(self.innerImageView!)
        })
    }
}
