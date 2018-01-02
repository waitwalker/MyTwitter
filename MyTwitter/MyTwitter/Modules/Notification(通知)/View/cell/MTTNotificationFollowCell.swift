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
    var avatarImageViews:MTTAvatarImagesView?
    var followLabel:UILabel?
    
    
    
    
    var notificationModel:MTTNotificationModel?
    {
        didSet
        {
            
            layoutSubview(notificationModel: notificationModel!)
            iconImageView?.image = UIImage(named: String(format: "head%@", (notificationModel?.iconImage)!))
            followLabel?.text = notificationModel?.followString
            
            var notificationImages:[String] = []
            
            for _ in Int(0)...(notificationModel?.avatarImages?.count)!
            {
                let random = self.getRandomNum()
                
                notificationImages.append(random)
            }
            print(notificationImages as Any)
            notificationImages.remove(at: 0)
            avatarImageViews?.avatarImageViews = notificationImages
            
        }
    }
    
    func getRandomNum() -> String
    {
        let num = (arc4random() % 17)
        return String(format: "%d", num)
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) 
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubview()
    }
    
    private func setupSubview() -> Void 
    {
        lineView                                = UIView()
        lineView?.backgroundColor               = kMainLightGrayColor()
        self.contentView.addSubview(lineView!)

        iconImageView                           = UIImageView()
        iconImageView?.isUserInteractionEnabled = true
        iconImageView?.layer.cornerRadius       = 10
        iconImageView?.clipsToBounds            = true
        self.contentView.addSubview(iconImageView!)

        avatarImageViews                        = MTTAvatarImagesView()
        self.contentView.addSubview(avatarImageViews!)

        followLabel                             = UILabel()
        followLabel?.textColor                  = UIColor.black
        followLabel?.font                       = UIFont.systemFont(ofSize: 18)
        followLabel?.textAlignment              = NSTextAlignment.left
        self.contentView.addSubview(followLabel!)
        
    }
    
    private func layoutSubview(notificationModel:MTTNotificationModel) -> Void
    {
        lineView?.snp.makeConstraints({ (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(0.3)
        })
        
        iconImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(60)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.top.equalTo(10)
        })
        
        avatarImageViews?.frame = CGRect(x: 85, y: 10, width: kScreenWidth - 85 - 20, height: 40)
        
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
