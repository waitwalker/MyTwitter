//
//  MTTMessageButtonCell.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/10/21.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTMessageButtonCell: MTTTableViewCell {

    var buttonContainerView:UIView?
    var mailBoxButton:UIButton?
    var requestButtion:UIButton?
    var delegate:MTTMessagetButtonDelegate?
    
    
    
    
    
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

        mailBoxButton                           = UIButton()
        mailBoxButton?.setTitle("信箱", for: UIControlState.normal)
        mailBoxButton?.setTitleColor(kMainWhiteColor(), for: UIControlState.normal)
        mailBoxButton?.backgroundColor          = kMainBlueColor()
        mailBoxButton?.titleLabel?.font         = UIFont.systemFont(ofSize: 15)
        mailBoxButton?.addTarget(self, action: #selector(mailBoxButtonAction(button:)), for: UIControlEvents.touchUpInside)
        buttonContainerView?.addSubview(mailBoxButton!)

        requestButtion                          = UIButton()
        requestButtion?.setTitle("请求", for: UIControlState.normal)
        requestButtion?.setTitleColor(kMainBlueColor(), for: UIControlState.normal)
        requestButtion?.titleLabel?.font        = UIFont.systemFont(ofSize: 15)
        requestButtion?.backgroundColor         = kMainWhiteColor()
        requestButtion?.addTarget(self, action: #selector(requestButtonAction(button:)), for: UIControlEvents.touchUpInside)
        buttonContainerView?.addSubview(requestButtion!)
    }
    
    private func layoutSubview() -> Void
    {
        buttonContainerView?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(5)
            make.height.equalTo(25)
        })
        
        mailBoxButton?.snp.makeConstraints({ (make) in
            make.left.top.equalTo(0)
            make.height.equalTo(25)
            make.width.equalTo((kScreenWidth - 60) / 2)
        })
        
        requestButtion?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.mailBoxButton?.snp.right)!).offset(0)
            make.right.top.equalTo(0)
            make.height.equalTo(25)
        })
    }
    
    @objc func mailBoxButtonAction(button:UIButton) -> Void
    {
        delegate?.tappedMailBoxButton(mailBoxButton: button, cell: self)
    }
    
    @objc func requestButtonAction(button:UIButton) -> Void
    {
        delegate?.tappedRequestButton(requestButton: button, cell: self)
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
