//
//  MTTPersonalCell.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/10/25.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTPersonalCell: MTTTableViewCell 
{
    
    var iconImageView:UIImageView?
    var titleLabelP:UILabel?
    
    var personalModel:MTTPersonalModel?
    {
        didSet
        {
            iconImageView?.image = UIImage(named: (personalModel?.iconImageString)!)
            titleLabelP?.text = personalModel?.title
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
        iconImageView = UIImageView()
        iconImageView?.isUserInteractionEnabled = true
        self.contentView.addSubview(iconImageView!)
        
        titleLabelP = UILabel()
        titleLabelP?.font = UIFont.systemFont(ofSize: 18)
        titleLabelP?.textColor = kMainGrayColor()
        titleLabelP?.textAlignment = NSTextAlignment.left
        self.contentView.addSubview(titleLabelP!)
    }
    
    private func layoutSubview() -> Void 
    {
        iconImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.height.equalTo(20)
            make.centerY.equalTo(self.contentView)
            make.width.equalTo(15)
        })
        
        titleLabelP?.snp.makeConstraints({ (make) in
            make.left.equalTo((iconImageView?.snp.right)!).offset(20)
            make.height.equalTo(30)
            make.width.equalTo(80)
            make.centerY.equalTo(self.contentView)
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
