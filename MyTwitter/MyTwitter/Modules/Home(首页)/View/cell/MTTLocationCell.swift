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
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubview()
        layoutSubview()
    }
    
    private func setupSubview() -> Void
    {
        
    }
    
    private func layoutSubview() -> Void
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
