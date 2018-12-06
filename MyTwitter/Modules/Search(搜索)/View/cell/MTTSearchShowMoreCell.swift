//
//  MTTSearchShowMoreCell.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/10/12.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTSearchShowMoreCell: MTTTableViewCell
{
    var SLineView:UIView?
    var SShowMoreLabel:UILabel?
    var SRightArrowImageView:UIImageView?
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubview()
        layoutSubview()
    }
    
    private func setupSubview() -> Void
    {
        SLineView                                      = UIView()
        SLineView?.backgroundColor                     = kMainGrayColor()
        self.contentView.addSubview(SLineView!)

        SShowMoreLabel                                 = UILabel()
        SShowMoreLabel?.text                           = "显示更多"
        SShowMoreLabel?.textColor                      = kMainBlueColor()
        SShowMoreLabel?.textAlignment                  = NSTextAlignment.left
        SShowMoreLabel?.font                           = UIFont.systemFont(ofSize: 18)
        self.contentView.addSubview(SShowMoreLabel!)

        SRightArrowImageView                           = UIImageView()
        SRightArrowImageView?.isUserInteractionEnabled = true
        SRightArrowImageView?.image                    = UIImage(named: "twitter_right_arrow")
        self.contentView.addSubview(SRightArrowImageView!)
    }
    
    private func layoutSubview() -> Void
    {
        SLineView?.snp.makeConstraints({ (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(0.3)
        })
        
        SShowMoreLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.height.equalTo(20)
            make.top.equalTo(10)
            make.width.equalTo(180)
        })
        
        SRightArrowImageView?.snp.makeConstraints({ (make) in
            make.right.equalTo(-20)
            make.centerY.equalTo(self.contentView)
            make.height.width.equalTo(10)
        })
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
