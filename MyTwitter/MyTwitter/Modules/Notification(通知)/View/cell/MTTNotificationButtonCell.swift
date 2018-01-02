//
//  MTTNotificationButtonCell.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/10/19.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTNotificationButtonCell: MTTTableViewCell 
{
    
    var buttonContainerView:UIView?
    var allButton:UIButton?
    var mentionButtion:UIButton?
    var delegate:MTTNotificationButtonDelegate?
    
    
    
    
    
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
        buttonContainerView                     = UIView()
        buttonContainerView?.layer.borderWidth  = 1
        buttonContainerView?.layer.borderColor  = kMainBlueColor().cgColor
        buttonContainerView?.layer.cornerRadius = 12.5
        buttonContainerView?.clipsToBounds      = true
        self.contentView.addSubview(buttonContainerView!)

        allButton                               = UIButton()
        allButton?.setTitle("全部", for: UIControlState.normal)
        allButton?.setTitleColor(kMainWhiteColor(), for: UIControlState.normal)
        allButton?.backgroundColor              = kMainBlueColor()
        allButton?.titleLabel?.font             = UIFont.systemFont(ofSize: 15)
        allButton?.addTarget(self, action: #selector(allButtonAction(button:)), for: UIControlEvents.touchUpInside)
        buttonContainerView?.addSubview(allButton!)

        mentionButtion                          = UIButton()
        mentionButtion?.setTitle("提及", for: UIControlState.normal)
        mentionButtion?.setTitleColor(kMainBlueColor(), for: UIControlState.normal)
        mentionButtion?.titleLabel?.font        = UIFont.systemFont(ofSize: 15)
        mentionButtion?.backgroundColor         = kMainWhiteColor()
        mentionButtion?.addTarget(self, action: #selector(mentionButtonAction(button:)), for: UIControlEvents.touchUpInside)
        buttonContainerView?.addSubview(mentionButtion!)
    }
    
    private func layoutSubview() -> Void 
    {
        buttonContainerView?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(5)
            make.height.equalTo(25)
        })
        
        allButton?.snp.makeConstraints({ (make) in
            make.left.top.equalTo(0)
            make.height.equalTo(25)
            make.width.equalTo((kScreenWidth - 60) / 2)
        })
        
        mentionButtion?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.allButton?.snp.right)!).offset(0)
            make.right.top.equalTo(0)
            make.height.equalTo(25)
        })
    }
    
    @objc func allButtonAction(button:UIButton) -> Void 
    {
        delegate?.tappedAllButton(allButton: button, cell: self)
    }
    
    @objc func mentionButtonAction(button:UIButton) -> Void 
    {
        delegate?.tappedMentionButton(mentionButton: button, cell: self)
    }
    
    override func awakeFromNib() 
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) 
    {
        super.setSelected(selected, animated: animated)
    }

}
