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
        avatarImageView = UIImageView()
        avatarImageView.layer.cornerRadius = 25
        avatarImageView.clipsToBounds = true
        avatarImageView.backgroundColor = kMainRandomColor()
        avatarImageView.isUserInteractionEnabled = true
        self.contentView.addSubview(avatarImageView)
    }
    
    func layoutSubview(model:MTTChatMessageModel) -> Void
    {
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
        avatarImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(50)
            make.right.equalTo(-10)
            make.bottom.equalTo(-10)
        }
    }
    
    func layoutOthersMessageSubview(model:MTTChatMessageModel) -> Void
    {
        avatarImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(50)
            make.left.equalTo(10)
            make.top.equalTo(10)
        }
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
