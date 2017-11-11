//
//  MTTUserDetailHeaderCell.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/11/11.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTUserDetailHeaderCell: MTTTableViewCell {

    
    var avatarImageView:UIImageView!
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) 
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = kMainRandomColor()
        setupSubview()
        layoutSubview()
    }
    
    func setupSubview() -> Void 
    {
        avatarImageView = UIImageView()
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.layer.cornerRadius = 25
        avatarImageView.clipsToBounds = true
        avatarImageView.backgroundColor = kMainRandomColor()
        self.contentView.addSubview(avatarImageView)
    }
    
    func layoutSubview() -> Void 
    {
        avatarImageView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.height.width.equalTo(50)
            make.left.equalTo(40)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
