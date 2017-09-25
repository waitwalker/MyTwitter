//
//  MTTHomeCell.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/22.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTHomeCell: MTTTableViewCell {
    
    let toolBarButtonWidth = (kScreenWidth - 80 - 10) / 4.0
    
    
    var topLineView:UIView?  //分割线
    
    var retwitterContainerView:UIView?  //转推或者喜欢容器
    var retwitterImageView:UIImageView?  //转推或者喜欢imageView
    var retwitterAccountLabel:UILabel?  //谁喜欢或者转推了
    
    var originalContainerView:UIView?
    var avatarImageView:UIImageView?  //头像
    
    var accountContainerView:UIView?  //账号容器  
    var accountLabel:UILabel?  //账号
    var nickNameLabel:UILabel?  //昵称
    var dotImageView:UIImageView?  //昵称后面的原点
    var timeLabel:UILabel?  //时间
    var downImageView:UIImageView?  //向下箭头 添加回调
    
    
    var contentContainerView:UIView?  //内容容器
    var contentLabel:UILabel?  //文本内容
    var contentImageContainerView:MTTHomeImageContainerView?  //图片内容:这种情况只有一张图片的情况
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
        
        //转推,喜欢图标
        retwitterImageView = UIImageView()
        retwitterImageView?.isUserInteractionEnabled = true
        retwitterImageView?.image = UIImage.init(named: "twitter_retwitter")
        retwitterContainerView?.addSubview(retwitterImageView!)
        
        //转推账号
        retwitterAccountLabel = UILabel()
        retwitterAccountLabel?.text = "Kssttw Matsre 转推了"
        retwitterAccountLabel?.textColor = kMainGrayColor()
        retwitterAccountLabel?.textAlignment = NSTextAlignment.left
        retwitterAccountLabel?.font = UIFont.systemFont(ofSize: 12)
        retwitterAccountLabel?.backgroundColor = UIColor.green
        retwitterContainerView?.addSubview(retwitterAccountLabel!)
        
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
        
        //账号
        accountLabel = UILabel()
        accountLabel?.text = "Oliver Halligon"
        accountLabel?.textColor = UIColor.black
        accountLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        accountLabel?.textAlignment = NSTextAlignment.left
        accountLabel?.sizeToFit()
        accountContainerView?.addSubview(accountLabel!)
        
        //昵称
        nickNameLabel = UILabel()
        nickNameLabel?.text = "@oliverhalligon"
        nickNameLabel?.textColor = kMainGrayColor()
        nickNameLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        nickNameLabel?.textAlignment = NSTextAlignment.left
        nickNameLabel?.sizeToFit()
        accountContainerView?.addSubview(nickNameLabel!)
        
        //原点
        dotImageView = UIImageView()
        dotImageView?.isUserInteractionEnabled = true
        dotImageView?.backgroundColor = kMainGrayColor()
        dotImageView?.layer.cornerRadius = 1.5
        dotImageView?.clipsToBounds = true
        accountContainerView?.addSubview(dotImageView!)
        
        //时间
        timeLabel = UILabel()
        timeLabel?.text = "12分"
        timeLabel?.textColor = kMainGrayColor()
        timeLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        timeLabel?.textAlignment = NSTextAlignment.left
        timeLabel?.sizeToFit()
        accountContainerView?.addSubview(timeLabel!)
        
        //向下箭头
        downImageView = UIImageView()
        downImageView?.isUserInteractionEnabled = true
        downImageView?.image = UIImage(named: "twitter_down_arrow")
        accountContainerView?.addSubview(downImageView!)
        
        //内容容器
        contentContainerView = UIView()
        contentContainerView?.backgroundColor = kMainGrayColor()
        originalContainerView?.addSubview(contentContainerView!)
        
        //图片容器
        contentImageContainerView = MTTHomeImageContainerView()
        contentImageContainerView?.backgroundColor = kMainRandomColor()
        contentImageContainerView?.homeImagesArray = ["image1","image1"]
        contentContainerView?.addSubview(contentImageContainerView!)
        
        //tool bar 容器
        toolBarContainerView = UIView()
        toolBarContainerView?.backgroundColor = kMainGreenColor()
        originalContainerView?.addSubview(toolBarContainerView!)
        
        //评论
        commentButton = UIButton()
        commentButton?.setImage(UIImage.init(named: "twitter_comment"), for: UIControlState.normal)
        commentButton?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        commentButton?.setTitle("5899", for: UIControlState.normal)
        commentButton?.setTitleColor(kMainGrayColor(), for: UIControlState.normal)
        commentButton?.setImageWithPosition(postion: MTTButtonImagePostion.Left, spacing: 5)
        toolBarContainerView?.addSubview(commentButton!)
        
        //转推
        retwitterButton = UIButton()
        retwitterButton?.setImage(UIImage.init(named: "twitter_retwitter"), for: UIControlState.normal)
        retwitterButton?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        retwitterButton?.setTitle(" ", for: UIControlState.normal)
        retwitterButton?.setTitleColor(kMainGrayColor(), for: UIControlState.normal)
        retwitterButton?.setImageWithPosition(postion: MTTButtonImagePostion.Left, spacing: 5)
        toolBarContainerView?.addSubview(retwitterButton!)
        
        //喜欢
        likeButton = UIButton()
        likeButton?.setImage(UIImage.init(named: "twitter_like"), for: UIControlState.normal)
        likeButton?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        likeButton?.setTitle(" ", for: UIControlState.normal)
        likeButton?.setTitleColor(kMainGrayColor(), for: UIControlState.normal)
        likeButton?.setImageWithPosition(postion: MTTButtonImagePostion.Left, spacing: 5)
        toolBarContainerView?.addSubview(likeButton!)
        
        //私信
        privateMessageButton = UIButton()
        privateMessageButton?.setImage(UIImage.init(named: "twitter_private_message"), for: UIControlState.normal)
        privateMessageButton?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        privateMessageButton?.setTitle(" ", for: UIControlState.normal)
        privateMessageButton?.setTitleColor(kMainGrayColor(), for: UIControlState.normal)
        privateMessageButton?.setImageWithPosition(postion: MTTButtonImagePostion.Left, spacing: 5)
        toolBarContainerView?.addSubview(privateMessageButton!)
    }
    
    private func layoutSubview() -> Void
    {
        topLineView?.snp.makeConstraints({ (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(0.3)
        })
        
        retwitterContainerView?.snp.makeConstraints({ (make) in
            make.left.equalTo(55)
            make.right.equalTo(0)
            make.top.equalTo((self.topLineView?.snp.bottom)!).offset(0)
            make.height.equalTo(20)
        })
        
        retwitterImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(5)
            make.width.height.equalTo(15)
            make.top.equalTo(0)
        })
        
        retwitterAccountLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.retwitterImageView?.snp.right)!).offset(5)
            make.right.equalTo(self.retwitterContainerView!).offset(0)
            make.height.equalTo(20)
            make.centerY.equalTo(self.retwitterImageView!)
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
        
        accountLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(0)
            make.height.equalTo(20)
            make.top.equalTo(0)
        })
        
        nickNameLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.accountLabel?.snp.right)!).offset(5)
            make.centerY.height.equalTo(self.accountLabel!)
        })
        
        dotImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.nickNameLabel?.snp.right)!).offset(5)
            make.width.height.equalTo(3)
            make.centerY.equalTo(self.nickNameLabel!)
        })
        
        timeLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.dotImageView?.snp.right)!).offset(5)
            make.height.top.equalTo(self.nickNameLabel!)
        })
        
        downImageView?.snp.makeConstraints({ (make) in
            make.right.equalTo(0)
            make.width.height.equalTo(12)
            make.centerY.equalTo(self.nickNameLabel!)
        })
        
        contentContainerView?.snp.makeConstraints({ (make) in
            make.left.equalTo(80)
            make.right.equalTo(-10)
            make.top.equalTo((self.accountContainerView?.snp.bottom)!).offset(5)
            make.height.equalTo(140)
        })
        
        contentImageContainerView?.snp.makeConstraints({ (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(150)
            make.top.equalTo(0)
        })
        
        toolBarContainerView?.snp.makeConstraints({ (make) in
            make.left.equalTo(80)
            make.right.equalTo(-10)
            make.top.equalTo((self.contentContainerView?.snp.bottom)!).offset(5)
            make.height.equalTo(40)
        })
        
        commentButton?.snp.makeConstraints({ (make) in
            make.left.equalTo(0)
            make.height.equalTo(self.toolBarContainerView!)
            make.width.equalTo(toolBarButtonWidth)
            make.top.equalTo(self.toolBarContainerView!)
        })
        
        retwitterButton?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.commentButton?.snp.right)!).offset(0)
            make.height.equalTo(self.toolBarContainerView!)
            make.width.equalTo(toolBarButtonWidth)
            make.top.equalTo(self.toolBarContainerView!)
        })
        
        likeButton?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.retwitterButton?.snp.right)!).offset(0)
            make.height.equalTo(self.toolBarContainerView!)
            make.width.equalTo(toolBarButtonWidth)
            make.top.equalTo(self.toolBarContainerView!)
        })
        
        privateMessageButton?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.likeButton?.snp.right)!).offset(0)
            make.height.equalTo(self.toolBarContainerView!)
            make.width.equalTo(toolBarButtonWidth)
            make.top.equalTo(self.toolBarContainerView!)
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
