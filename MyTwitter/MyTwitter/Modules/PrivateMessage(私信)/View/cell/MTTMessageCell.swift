//
//  MTTMessageCell.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/10/21.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTMessageCell: MTTTableViewCell
{
    
    var lineView:UIView?
    
    var avatarImageView:UIImageView?
    var accountLabel:UILabel?
    var nickNameLabel:UILabel?
    var timeLabel:UILabel?
    var contentLabel:UILabel?
    
    
    var messageModel:MTTMessageModel?
    {
        didSet
        {
            layoutSubview()
            
        }
    }
    
    
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubview()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubview() -> Void
    {
        lineView = UIView()
        lineView?.backgroundColor = kMainGrayColor()
        self.contentView.addSubview(lineView!)
        
        avatarImageView = UIImageView()
        avatarImageView?.isUserInteractionEnabled = true
        avatarImageView?.layer.cornerRadius = 30
        avatarImageView?.clipsToBounds = true
        self.contentView.addSubview(avatarImageView!)
        
        accountLabel = UILabel()
        accountLabel?.textColor = UIColor.black
        accountLabel?.font = UIFont.systemFont(ofSize: 14)
        accountLabel?.sizeToFit()
        accountLabel?.textAlignment = NSTextAlignment.left
        self.contentView.addSubview(accountLabel!)
        
        nickNameLabel = UILabel()
        nickNameLabel?.textColor = kMainGrayColor()
        nickNameLabel?.font = UIFont.systemFont(ofSize: 14)
        nickNameLabel?.textAlignment = NSTextAlignment.left
        nickNameLabel?.sizeToFit()
        self.contentView.addSubview(nickNameLabel!)
        
        timeLabel = UILabel()
        timeLabel?.textColor = kMainGrayColor()
        timeLabel?.font = UIFont.systemFont(ofSize: 14)
        timeLabel?.textAlignment = NSTextAlignment.left
        self.contentView.addSubview(timeLabel!)
        
        contentLabel = UILabel()
        contentLabel?.textColor = kMainGrayColor()
        contentLabel?.textAlignment = NSTextAlignment.left
        contentLabel?.font = UIFont.systemFont(ofSize: 15)
        contentLabel?.numberOfLines = 2
        self.contentView.addSubview(contentLabel!)
    }
    
    private func layoutSubview() -> Void
    {
        lineView?.snp.makeConstraints({ (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(0.3)
        })
        
        avatarImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.height.width.equalTo(60)
            make.top.equalTo(10)
        })
        
        accountLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(85)
            make.height.equalTo(20)
            make.top.equalTo(10)
        })
        
        nickNameLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.accountLabel?.snp.right)!).offset(5)
            make.top.height.equalTo(self.accountLabel!)
        })
        
        timeLabel?.snp.makeConstraints({ (make) in
            make.top.height.equalTo(self.accountLabel!)
            make.right.equalTo(-20)
            make.width.equalTo(80)
        })
        
        contentLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(85)
            make.bottom.equalTo(-10)
            make.top.equalTo((self.accountLabel?.snp.bottom)!).offset(0)
            make.right.equalTo(-20)
        })
    }
}
