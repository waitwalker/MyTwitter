//
//  MTTHomeCell.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/22.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTHomeCell: MTTTableViewCell {
    
    var topLineView:UIView?
    
    var retwitterContainerView:UIView?  //转推或者喜欢容器
    var retwitterImageView:UIImageView?  //转推或者喜欢imageView
    var retwitterAccountLabel:UILabel?  //谁喜欢或者转推了
    
    var originalContainerView:UIView?
    var avatarImageView:UIImageView?  //头像
    
    var accountContainerView:UIView?  //账号容器  
    var accountLabel:UILabel?  //账号
    var nickName:UILabel?  //昵称
    var dotImageView:UIImageView?  //昵称后面的原点
    var timeLabel:UILabel?  //时间
    var downImageView:UIImageView?  //向下箭头 添加回调
    
    
    
    var contentContainerView:UIView?  //内容容器
    var contentLabel:UILabel?  //文本内容
    var contentImageView:UIImageView?  //图片内容:这种情况只有一张图片的情况
    var contentVideoView:UIView?  //视频内容 封装视频容器 继承自这个播放器
    
    var toolBarContainerView:UIView?  //下面tool bar 容器
    var commentButton:UIButton?  //评论按钮
    var retwitterButton:UIButton?  //转推按钮
    var likeButton:UIButton?  //喜欢按钮
    var privateMessageButton:UIButton?  //私信按钮
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) 
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSubview()
        self.layoutSubview()
    }
    
    
    private func setupSubview() -> Void 
    {
        //分割线
        topLineView = UIView()
        topLineView?.backgroundColor = kMainGrayColor()
        self.contentView.addSubview(topLineView!)
        
        //转推容器
        retwitterContainerView = UIView()
        retwitterContainerView?.backgroundColor = kMainBlueColor()
        self.contentView.addSubview(retwitterContainerView!)
        
        //原创容器
        originalContainerView = UIView()
        originalContainerView?.backgroundColor = kMainLightGrayColor()
        self.contentView.addSubview(originalContainerView!)
        
        //头像
        avatarImageView = UIImageView()
        avatarImageView?.isUserInteractionEnabled = true
        avatarImageView?.layer.cornerRadius = 30
        avatarImageView?.backgroundColor = kMainRedColor()
        avatarImageView?.clipsToBounds = true
        originalContainerView?.addSubview(avatarImageView!)
        
        //账号相关容器
        accountContainerView = UIView()
        accountContainerView?.backgroundColor = UIColor.orange
        originalContainerView?.addSubview(accountContainerView!)
        
        
        //内容容器
        contentContainerView = UIView()
        contentContainerView?.backgroundColor = kMainGrayColor()
        originalContainerView?.addSubview(contentContainerView!)
        
        //tool bar 容器
        toolBarContainerView = UIView()
        toolBarContainerView?.backgroundColor = kMainGreenColor()
        originalContainerView?.addSubview(toolBarContainerView!)
    }
    
    private func layoutSubview() -> Void
    {
        topLineView?.snp.makeConstraints({ (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(0.3)
        })
        
        retwitterContainerView?.snp.makeConstraints({ (make) in
            make.left.equalTo(60)
            make.right.equalTo(0)
            make.top.equalTo((self.topLineView?.snp.bottom)!).offset(0)
            make.height.equalTo(30)
        })
        
        originalContainerView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(210)
            make.top.equalTo((self.retwitterContainerView?.snp.bottom)!).offset(5)
        })
        
        avatarImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(10)
            make.height.width.equalTo(60)
            make.top.equalTo(10)
        })
        
        accountContainerView?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.avatarImageView?.snp.right)!).offset(10)
            make.top.equalTo((self.retwitterContainerView?.snp.bottom)!).offset(5)
            make.right.equalTo(-10)
            make.height.equalTo(20)
            
        })
        
        contentContainerView?.snp.makeConstraints({ (make) in
            make.left.equalTo(80)
            make.right.equalTo(-10)
            make.top.equalTo((self.accountContainerView?.snp.bottom)!).offset(5)
            make.height.equalTo(140)
        })
        
        toolBarContainerView?.snp.makeConstraints({ (make) in
            make.left.equalTo(80)
            make.right.equalTo(-10)
            make.top.equalTo((self.contentContainerView?.snp.bottom)!).offset(5)
            make.height.equalTo(40)
        })
    }
    
    
    required init?(coder aDecoder: NSCoder) 
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    override func awakeFromNib() 
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
