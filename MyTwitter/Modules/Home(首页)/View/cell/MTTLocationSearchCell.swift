//
//  MTTLocationSearchCell.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/10/10.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTLocationSearchCell: MTTTableViewCell 
{

    
    var locationSearchContainerView:UIView?
    var locationSearchButton:UIButton?
    var locationLineView:UIView?
    
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubview()
        layoutSubview()
    }
    
    private func setupSubview() -> Void
    {
        locationSearchContainerView                     = UIView()
        locationSearchContainerView?.backgroundColor    = kMainLightGrayColor()
        locationSearchContainerView?.layer.cornerRadius = 15
        locationSearchContainerView?.clipsToBounds      = true
        self.contentView.addSubview(locationSearchContainerView!)

        locationSearchButton                            = UIButton()
        locationSearchButton?.setImage(UIImage(named: "search_normal"), for: UIControlState.normal)
        locationSearchButton?.setTitle("搜索位置", for: UIControlState.normal)
        locationSearchButton?.setTitleColor(kMainGrayColor(), for: UIControlState.normal)

        locationSearchButton?.titleLabel?.font          = UIFont.systemFont(ofSize: 13)
        locationSearchButton?.addTarget(self, action: #selector(locationSearchButtonAction(searchButton:)), for: UIControlEvents.touchUpInside)
        locationSearchContainerView?.addSubview(locationSearchButton!)

        locationLineView                                = UIView()
        locationLineView?.backgroundColor               = kMainGrayColor()
        self.contentView.addSubview(locationLineView!)
        
    }
    
    private func layoutSubview() -> Void
    {
        locationSearchContainerView?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(10)
            make.height.equalTo(30)
        })
        
        locationSearchButton?.snp.makeConstraints({ (make) in
            make.width.equalTo(120)
            make.height.centerX.centerY.equalTo(self.locationSearchContainerView!)
        })
        locationSearchButton?.setImageWithPosition(postion: MTTButtonImagePostion.Left, spacing: 10)
        
        locationLineView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(0.3)
            make.bottom.equalTo(-0.3)
        })
    }
    
    @objc func locationSearchButtonAction(searchButton:UIButton) -> Void 
    {
        
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
