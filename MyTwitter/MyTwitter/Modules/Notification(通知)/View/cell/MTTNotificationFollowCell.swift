//
//  MTTNotificationFollowCell.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/10/19.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTNotificationFollowCell: MTTTableViewCell 
{
    var lineView:UIView?
    var iconImageView:UIImageView?
    var avatarImageViews:UIImageView?
    var followLabel:UILabel?
    
    
    
    
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) 
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubview()
        layoutSubview()
    }
    
    private func setupSubview() -> Void 
    {
        lineView = UIView()
        lineView?.backgroundColor = kMainLightGrayColor()
        self.contentView.addSubview(lineView!)
        
        iconImageView = UIImageView()
        iconImageView?.isUserInteractionEnabled = true
        self.contentView.addSubview(iconImageView!)
        
        avatarImageViews = UIImageView()
        avatarImageViews?.isUserInteractionEnabled = true
        self.contentView.addSubview(avatarImageViews!)
        
        followLabel = UILabel()
        followLabel?.textColor = UIColor.black
        followLabel?.font = UIFont.systemFont(ofSize: 18)
        followLabel?.textAlignment = NSTextAlignment.left
        self.contentView.addSubview(followLabel!)
        
    }
    
    private func layoutSubview() -> Void 
    {
        lineView?.snp.makeConstraints({ (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(0.3)
        })
        
        iconImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(65)
            make.width.equalTo(15)
            make.height.equalTo(20)
            make.top.equalTo(10)
        })
        
        avatarImageViews?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.iconImageView?.snp.right)!).offset(5)
            make.top.equalTo(10)
            make.height.width.equalTo(40)
        })
        
        followLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.iconImageView?.snp.right)!).offset(5)
            make.right.equalTo(0)
            make.top.equalTo((self.avatarImageViews?.snp.bottom)!).offset(5)
            make.bottom.equalTo(-5)
        })
    }
    
    required init?(coder aDecoder: NSCoder) 
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
