//
//  MTTAboutSwitchCell.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/21.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTAboutSwitchCell: MTTTableViewCell {
    
    var lineView:UIView?
    var titleLable:UILabel?
    var sendErrorSwitch:UISwitch?
    var detailLabel:UILabel?
    var delegate:MTTAboutSendErrorDelegate?
    
    
    
    
    var aboutModel:MTTAboutModel?
    {
        didSet 
        {
            titleLable?.text = aboutModel?.title
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) 
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSubview()
        self.layoutSubview()
    }
    
    private func setupSubview() -> Void
    {
        //lineView
        lineView                   = UIView()
        lineView?.backgroundColor  = kMainGrayColor()
        self.contentView.addSubview(lineView!)

        //titleLable
        titleLable                 = UILabel()
        titleLable?.font           = UIFont.boldSystemFont(ofSize: 15)
        titleLable?.textColor      = UIColor.black
        titleLable?.textAlignment  = NSTextAlignment.left
        self.contentView.addSubview(titleLable!)

        //sendErrorSwitch
        sendErrorSwitch            = UISwitch.init()
        sendErrorSwitch?.addTarget(self, action: #selector(sendErrorSwitch(errorSwitch:)), for: UIControlEvents.valueChanged)
        self.contentView.addSubview(sendErrorSwitch!)

        //detailLabel
        detailLabel                = UILabel()
        detailLabel?.textColor     = kMainGrayColor()
        detailLabel?.textAlignment = NSTextAlignment.left
        detailLabel?.text          = "自动想 Twitter 的服务提供商发送崩溃报告以帮助改善此应用程序"
        detailLabel?.font          = UIFont.systemFont(ofSize: 14)
        detailLabel?.numberOfLines = 2
        self.contentView.addSubview(detailLabel!)
        
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
            make.height.equalTo(40)
            make.top.equalTo(self.contentView).offset(0)
            make.width.equalTo(200)
        })
        
        //sendErrorSwitch
        sendErrorSwitch?.snp.makeConstraints({ (make) in
            make.width.equalTo(40)
            make.top.equalTo(self.contentView).offset(5)
            make.height.equalTo(30)
            make.right.equalTo(self.contentView.snp.right).offset(-20)
        })
        
        //detailLabel
        detailLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.height.equalTo(40)
            make.top.equalTo((self.titleLable?.snp.bottom)!).offset(0)
            make.right.equalTo(self.contentView.snp.right).offset(-20)
        })
    }
    
    func sendErrorSwitch(errorSwitch:UISwitch) -> Void 
    {
        self.delegate?.sendErrorSwitchValueChange(errorSwitch: errorSwitch)
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
