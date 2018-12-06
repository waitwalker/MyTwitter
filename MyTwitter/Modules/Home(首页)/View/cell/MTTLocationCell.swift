//
//  MTTLocationCell.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/10/9.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTLocationCell: MTTTableViewCell {

    var locationTitleLabel:UILabel?
    var locationImageView:UIImageView?
    var locationLineView:UIView?
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubview()
        layoutSubview()
    }
    
    private func setupSubview() -> Void
    {
        locationTitleLabel                          = UILabel()
        locationTitleLabel?.textColor               = UIColor.black
        locationTitleLabel?.textAlignment           = NSTextAlignment.left
        locationTitleLabel?.font                    = UIFont.boldSystemFont(ofSize: 16)
        self.contentView.addSubview(locationTitleLabel!)

        locationImageView                           = UIImageView()
        locationImageView?.isHidden                 = true
        locationImageView?.isUserInteractionEnabled = true
        locationImageView?.image                    = UIImage(named: "twitter_check_mark")
        self.contentView.addSubview(locationImageView!)

        locationLineView                            = UIView()
        locationLineView?.backgroundColor           = kMainGrayColor()
        self.contentView.addSubview(locationLineView!)
    }
    
    private func layoutSubview() -> Void
    {
        locationTitleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.top.equalTo(0)
            make.height.equalTo(50)
            make.width.equalTo(kScreenWidth - 60)
        })
        
        locationImageView?.snp.makeConstraints({ (make) in
            make.right.equalTo(-20)
            make.height.width.equalTo(20)
            make.centerY.equalTo(self.locationTitleLabel!)
        })
        
        locationLineView?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.right.equalTo(0)
            make.height.equalTo(0.3)
            make.bottom.equalTo(-0.3)
        })
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
