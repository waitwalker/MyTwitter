//
//  MTTChatMessageCell.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/12/5.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTChatMessageCell: MTTTableViewCell {

    var avatarImageView:UIImageView!
    var timeLabel:UILabel!
    
    
    var chatMessageModel:MTTChatMessageModel?
    {
        didSet
        {
            layoutSubview(model: chatMessageModel!)
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubview()
    }
    
    func setupSubview() -> Void
    {
        timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = UIColor.black
        timeLabel.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(timeLabel)
        
        avatarImageView = UIImageView()
        avatarImageView.layer.cornerRadius = 25
        avatarImageView.clipsToBounds = true
        avatarImageView.backgroundColor = kMainRandomColor()
        avatarImageView.isUserInteractionEnabled = true
        self.contentView.addSubview(avatarImageView)
    }
    
    func layoutSubview(model:MTTChatMessageModel) -> Void
    {
        timeLabel.frame = CGRect(x: 10, y: 10, width: kScreenWidth - 20, height: 20)
        timeLabel.text = getTimeString()
        
        if model.messageFrom == MTTChatMessageFromType.My
        {
           self.layoutMyMessageSubview(model: model)
        } else
        {
            self.layoutOthersMessageSubview(model: model)
        }
    }
    
    func layoutMyMessageSubview(model:MTTChatMessageModel) -> Void
    {
        avatarImageView.frame = CGRect(x: 10, y: 30, width: 50, height: 50)
        
    }
    
    func layoutOthersMessageSubview(model:MTTChatMessageModel) -> Void
    {
        avatarImageView.frame = CGRect(x: kScreenWidth - 50 - 10, y: 30, width: 50, height: 50)
        
    }
    
    // MARK: - 获取当前时间string
    func getTimeString() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd天 HH:mm:ss"
        let dateStr = dateFormatter.string(from: Date.init(timeIntervalSinceNow: 0))
        return dateStr
    }
    
    
    required init?(coder aDecoder: NSCoder) {
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
