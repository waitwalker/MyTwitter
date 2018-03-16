//
//  MTTTabMediaCell.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2018/3/8.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MTTTabMediaCell: UITableViewCell {

    var backgroundImageView:UIImageView!
    var playButton:UIButton!
    var timeLabel:UILabel!
    
    let disposeBag = DisposeBag()
    
    
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
        setupEvent()
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
        
        playButton = UIButton()
        playButton.setImage(UIImage.imageNamed(name: "user_detail_play"), for: UIControlState.normal)
        playButton.adjustsImageWhenHighlighted = true
        playButton.layer.cornerRadius = 16
        playButton.clipsToBounds = true
        backgroundImageView.addSubview(playButton)
        
        timeLabel = UILabel()
        timeLabel.textColor = UIColor.white
        timeLabel.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        timeLabel.textAlignment = NSTextAlignment.center
        timeLabel.layer.cornerRadius = 2
        timeLabel.clipsToBounds = true
        timeLabel.text = "16:02"
        timeLabel.font = UIFont.systemFont(ofSize: 15)
        backgroundImageView.addSubview(timeLabel)
        
    }
    
    func layoutSubview() -> Void 
    {
        backgroundImageView.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
        
        playButton.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.center.equalTo(backgroundImageView)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.height.equalTo(20)
            make.width.equalTo(60)
            make.bottom.equalTo(-20)
        }
    }
    
    func setupEvent() -> Void 
    {
        playButton.rx.tap
            .subscribe(onNext:{ element in
                
            }).disposed(by: disposeBag)
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
