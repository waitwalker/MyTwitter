//
//  MTTTabMediaCell.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2018/3/8.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

import UIKit

class MTTTabMediaCell: UITableViewCell {

    var backgroundImageView:UIImageView!
    var playButton:UIButton!
    var timeLabel:UILabel!
    
    var mediaModel:MTTTabMediaModel?
    {
        didSet{
            
        }
    }
    
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) 
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.none
        setupSubview()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubview() -> Void 
    {
        backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage.imageNamed(name: "1")
        self.contentView.addSubview(backgroundImageView)
    }
    
    func layoutSubview() -> Void 
    {
        backgroundImageView.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
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
