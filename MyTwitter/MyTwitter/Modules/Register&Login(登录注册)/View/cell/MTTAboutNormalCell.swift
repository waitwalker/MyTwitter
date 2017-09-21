//
//  MTTAboutNormalCell.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/9/20.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTAboutNormalCell: MTTTableViewCell {

    var lineView:UIView?
    var titleLable:UILabel?
    var versionLabel:UILabel?
    var arrowImageView:UIImageView?
    
    
    var aboutModel:MTTAboutModel?
    {
        didSet
        {
            titleLable?.text = aboutModel?.title
        }
    }
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSubview()
        self.layoutSubview()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubview() -> Void
    {
        //lineView
        lineView = UIView()
        lineView?.backgroundColor = kMainGrayColor()
        self.contentView.addSubview(lineView!)
        
        //titleLable
        titleLable = UILabel()
        titleLable?.font = UIFont.boldSystemFont(ofSize: 15)
        titleLable?.textColor = UIColor.black
        titleLable?.textAlignment = NSTextAlignment.left
        self.contentView.addSubview(titleLable!)
        
        //versionLabel
        versionLabel = UILabel()
        versionLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        versionLabel?.textColor = kMainGrayColor()
        versionLabel?.text = "7.6"
        versionLabel?.textAlignment = NSTextAlignment.right
        self.contentView.addSubview(versionLabel!)
        
        //arrowImageView
        arrowImageView = UIImageView()
        arrowImageView?.isUserInteractionEnabled = true
        arrowImageView?.image = UIImage.init(named: "twitter_right_arrow")
        self.contentView.addSubview(arrowImageView!)
    }
    
    private func layoutSubview() -> Void
    {
        //lineView
        lineView?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.top.equalTo(0)
            make.height.equalTo(0.2)
            make.right.equalTo(self.contentView).offset(0)
        })
        
        //titleLable
        titleLable?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.height.equalTo(self.contentView)
            make.top.equalTo(self.contentView).offset(0)
            make.width.equalTo(200)
        })
        
        //versionLabel
        versionLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-20)
            make.height.equalTo(self.contentView)
            make.width.equalTo(50)
            make.top.equalTo(self.contentView).offset(0)
        })
        
        //arrowImageView
        arrowImageView?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-20)
            make.height.width.equalTo(15)
            make.centerY.equalTo(self.titleLable!)
        })
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
