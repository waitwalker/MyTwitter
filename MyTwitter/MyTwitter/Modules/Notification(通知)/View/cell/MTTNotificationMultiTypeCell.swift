//
//  MTTNotificationMultiTypeCell.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/10/19.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTNotificationMultiTypeCell: MTTTableViewCell 
{
    
    var lineView:UIView?
    var iconImageView:UIImageView?
    var avatarImageViews:MTTAvatarImagesView?
    var multiTitleLabel:UILabel?
    var multiContentLabel:UILabel?
    
    
    var notificationModel:MTTNotificationModel?
    {
        didSet
        {
            layoutSubview()
            iconImageView?.image = UIImage(named: String(format: "%@", (notificationModel?.iconImage)!))
            multiTitleLabel?.text = notificationModel?.multiTitle
            multiContentLabel?.text = notificationModel?.multiContent
            
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubview() -> Void 
    {
        lineView = UIView()
        lineView?.backgroundColor = kMainGrayColor()
        self.contentView.addSubview(lineView!)
        
        iconImageView = UIImageView()
        iconImageView?.isUserInteractionEnabled = true
        self.contentView.addSubview(iconImageView!)
        
        avatarImageViews = MTTAvatarImagesView()
        avatarImageViews?.isUserInteractionEnabled = true
        self.contentView.addSubview(avatarImageViews!)
        
        multiTitleLabel = UILabel()
        multiTitleLabel?.textColor = UIColor.black
        multiTitleLabel?.font = UIFont.systemFont(ofSize: 15)
        multiTitleLabel?.textAlignment = NSTextAlignment.left
        self.contentView.addSubview(multiTitleLabel!)
        
        multiContentLabel = UILabel()
        multiContentLabel?.textAlignment = NSTextAlignment.left
        multiContentLabel?.textColor = kMainGrayColor()
        multiContentLabel?.font = UIFont.systemFont(ofSize: 15)
        multiContentLabel?.numberOfLines = 0
        self.contentView.addSubview(multiContentLabel!)
    }
    
    private func layoutSubview() -> Void 
    {
        lineView?.snp.makeConstraints({ (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(0.3)
        })
        
        iconImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(60)
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.top.equalTo(10)
        })
        
        avatarImageViews?.frame = CGRect(x: 85, y: 10, width: kScreenWidth - 85 - 20, height: 40)
        
        multiTitleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.avatarImageViews!)
            make.top.equalTo((self.avatarImageViews?.snp.bottom)!).offset(5)
            make.height.equalTo(20)
            make.right.equalTo(-10)
        })
        
        multiContentLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.avatarImageViews!)
            make.right.equalTo(-10)
            make.top.equalTo((self.multiTitleLabel?.snp.bottom)!).offset(0)
            make.bottom.equalTo(-5)
        })
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
