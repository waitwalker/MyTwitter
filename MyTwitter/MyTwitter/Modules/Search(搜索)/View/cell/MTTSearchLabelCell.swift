//
//  MTTSearchLabelCell.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/10/12.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTSearchLabelCell: MTTTableViewCell {

    var SLineView:UIView?
    var STitleContainerView:UIView?
    var STitleLabel:UILabel?
    var SSubTitleLabel:UILabel?
    
    var searchModel:MTTSearchModel?
    {
        didSet
        {
            STitleLabel?.text = searchModel?.title
            SSubTitleLabel?.text = searchModel?.subTitle
        }
    }
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubview()
        layoutSubview()
    }
    
    private func setupSubview() -> Void
    {
        SLineView = UIView()
        SLineView?.backgroundColor = kMainGrayColor()
        self.contentView.addSubview(SLineView!)
        
        STitleContainerView = UIView()
        self.contentView.addSubview(STitleContainerView!)
        
        STitleLabel = UILabel()
        STitleLabel?.textAlignment = NSTextAlignment.left
        STitleLabel?.textColor = UIColor.black
        STitleLabel?.font = UIFont.systemFont(ofSize: 20)
        STitleContainerView?.addSubview(STitleLabel!)
        
        SSubTitleLabel = UILabel()
        SSubTitleLabel?.textAlignment = NSTextAlignment.left
        SSubTitleLabel?.textColor = kMainGrayColor()
        SSubTitleLabel?.font = UIFont.systemFont(ofSize: 15)
        STitleContainerView?.addSubview(SSubTitleLabel!)
    }
    
    private func layoutSubview() -> Void
    {
        SLineView?.snp.makeConstraints({ (make) in
            make.top.equalTo(0)
            make.left.right.equalTo(0)
            make.height.equalTo(0.3)
        })
        
        STitleContainerView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(15)
            make.bottom.equalTo(-15)
        })
        
        STitleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(0)
            make.height.equalTo(30)
        })
        
        SSubTitleLabel?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self.STitleLabel!)
            make.height.equalTo(20)
            make.top.equalTo((self.STitleLabel?.snp.bottom)!).offset(0)
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
