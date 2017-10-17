//
//  MTTSearchPopularCell.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/10/17.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTSearchPopularCell: MTTTableViewCell {
    
    var lineView:UIView?
    var websiteLabel:UILabel?
    var titleLabel:UILabel?
    var avatarImageView:UIImageView?
    var twitterLabel:UILabel?
    var iconImageView:UIImageView?
    
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubview()
        layoutSubview()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubview() -> Void
    {
        lineView = UIView()
        lineView?.backgroundColor = kMainLightGrayColor()
        self.contentView.addSubview(lineView!)
        
        websiteLabel = UILabel()
        websiteLabel?.textColor = kMainGrayColor()
        websiteLabel?.textAlignment = NSTextAlignment.left
        websiteLabel?.font = UIFont.systemFont(ofSize: 10)
        self.contentView.addSubview(websiteLabel!)
        
        titleLabel = UILabel()
        titleLabel?.textAlignment = NSTextAlignment.left
        titleLabel?.font = UIFont.systemFont(ofSize: 18)
        titleLabel?.textColor = UIColor.black
        titleLabel?.numberOfLines = 0
        
        avatarImageView = UIImageView()
        avatarImageView?.isUserInteractionEnabled = true
        avatarImageView?.layer.cornerRadius = 10
        avatarImageView?.clipsToBounds = true
        self.contentView.addSubview(avatarImageView!)
        
        twitterLabel = UILabel()
        twitterLabel?.textColor = kMainGrayColor()
        twitterLabel?.font = UIFont.systemFont(ofSize: 15)
        twitterLabel?.textAlignment = NSTextAlignment.left
        self.contentView.addSubview(twitterLabel!)
        
        iconImageView = UIImageView()
        iconImageView?.isUserInteractionEnabled = true
        self.contentView.addSubview(iconImageView!)
    }
    
    private func layoutSubview() -> Void
    {
        lineView?.snp.makeConstraints({ (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(0.3)
        })
        
        websiteLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.height.equalTo(10)
            make.top.equalTo(20)
            make.width.equalTo(200)
        })
        
        iconImageView?.snp.makeConstraints({ (make) in
            make.right.equalTo(-20)
            make.top.equalTo(10)
            make.width.equalTo(70)
            make.height.equalTo(80)
        })
        
        avatarImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.bottom.equalTo(-10)
            make.height.width.equalTo(20)
        })
        
        twitterLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.avatarImageView?.snp.right)!).offset(5)
            make.right.equalTo((self.iconImageView?.snp.left)!).offset(-10)
            make.bottom.height.equalTo(self.avatarImageView!)
        })
        
        titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.right.equalTo((self.iconImageView?.snp.left)!).offset(-10)
            make.top.top.equalTo((self.websiteLabel?.snp.bottom)!).offset(5)
            make.bottom.equalTo((self.avatarImageView?.snp.top)!).offset(5)
        })
    }

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
