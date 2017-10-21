//
//  MTTMessageHintCell.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/10/21.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTMessageHintCell: MTTTableViewCell
{
    var hintLabel:UILabel?
    
    
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
        hintLabel = UILabel()
        hintLabel?.text = "这里显示你未关注用户发来的私信.在你接收之前他们不会知道你已经看过申请."
        hintLabel?.textColor = kMainGrayColor()
        hintLabel?.font = UIFont.systemFont(ofSize: 16)
        hintLabel?.textAlignment = NSTextAlignment.left
        hintLabel?.numberOfLines = 2
        self.contentView.addSubview(hintLabel!)
    }
    
    private func layoutSubview() -> Void
    {
        hintLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(15)
            make.bottom.equalTo(-15)
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
