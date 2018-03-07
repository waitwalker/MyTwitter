//
//  MTTUserDetailTopIntroductionView.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2018/3/7.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

/*********
 个人详情顶部简介视图 
 *********/

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import SafariServices



class MTTUserDetailTopIntroductionView: MTTView 
{
 
    let disposeBag = DisposeBag()
    
    
    var titleLabel:UILabel!
    var subtitleLabel:UILabel!
    var introductionLabel:UILabel!
    var localLabel:UILabel!
    var hyperlinkButton:UIButton!
    var followingLabel:UILabel! //关注label
    var followerLabel:UILabel!  //关注者label 
    
    
    
    
    
    
    

    override init(frame: CGRect) 
    {
        super.init(frame: frame)
        
        setupEvent()
    }
    
    override func setupSubview() 
    {
        super.setupSubview()
        
        titleLabel               = UILabel()
        titleLabel.text = "爱学"
        titleLabel.backgroundColor = kMainRandomColor()
        titleLabel.textColor     = UIColor.black
        titleLabel.textAlignment = NSTextAlignment.left
        titleLabel.font          = UIFont.boldSystemFont(ofSize: 18)
        self.addSubview(titleLabel)
        
        subtitleLabel = UILabel()
        subtitleLabel.text = "@etiantian"
        subtitleLabel.backgroundColor = kMainRandomColor()
        subtitleLabel.textColor = kMainGrayColor()
        subtitleLabel.font = UIFont.systemFont(ofSize: 15)
        subtitleLabel.textAlignment = NSTextAlignment.left
        self.addSubview(subtitleLabel)
        
        introductionLabel               = UILabel()
        introductionLabel.numberOfLines = 0
        introductionLabel.text = "爱学客户端集教学辅助、校园社交、即时通讯及家校通于一身，正式开启一站式校园服务系统时代。师生在线教学功能与校园教学实时同步，随时随地进行教学。学习版的“微信”，拉近师生间距离，共同学习与成长。丰富的网校项目，掌中的移动网校，让课余学习更丰富多彩。家校通连接教师、家长与孩子，见证孩子成长每一步。"
        introductionLabel.backgroundColor = kMainRandomColor()
        introductionLabel.textColor     = UIColor.black
        introductionLabel.textAlignment = NSTextAlignment.left
        introductionLabel.font          = UIFont.systemFont(ofSize: 14)
        self.addSubview(introductionLabel)
        
        localLabel = UILabel()
        localLabel.backgroundColor = kMainRandomColor()
        localLabel.textColor = kMainGrayColor()
        localLabel.font = UIFont.systemFont(ofSize: 15)
        localLabel.textAlignment = NSTextAlignment.left
        localLabel.attributedText = self.setupRichText(imageName: "twitter_location_normal", behindString: "  北京", behindStringColor: kMainGrayColor())
        self.addSubview(localLabel)
        
        hyperlinkButton = UIButton()
        hyperlinkButton.backgroundColor = kMainRandomColor()
        hyperlinkButton.setAttributedTitle(self.setupRichText(imageName: "user_detail_link", behindString: "  https://waitwalker.cn", behindStringColor: kMainBlueColor()), for: UIControlState.normal)
        hyperlinkButton.setAttributedTitle(self.setupRichText(imageName: "user_detail_link", behindString: "  https://waitwalker.cn", behindStringColor: kMainGrayColor()), for: UIControlState.normal)
        self.addSubview(hyperlinkButton)
        
        followingLabel = UILabel()
        followingLabel.backgroundColor = kMainRandomColor()
        followingLabel.textColor = kMainGrayColor()
        followingLabel.font = UIFont.systemFont(ofSize: 15)
        followingLabel.textAlignment = NSTextAlignment.left
        followingLabel.attributedText = self.setupStringRichText(forwordString: "402 ", forwordColor: UIColor.black, behindString: "正在关注", behindColor: kMainGrayColor())
        self.addSubview(followingLabel)
        
        followerLabel = UILabel()
        followerLabel.backgroundColor = kMainRandomColor()
        followerLabel.textColor = kMainGrayColor()
        followerLabel.font = UIFont.systemFont(ofSize: 15)
        followerLabel.textAlignment = NSTextAlignment.left
        followerLabel.attributedText = self.setupStringRichText(forwordString: "28011 ", forwordColor: UIColor.black, behindString: "关注者", behindColor: kMainGrayColor())
        self.addSubview(followerLabel)
    }
    
    override func layoutSubview() 
    {
        super.layoutSubview()
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(self)
            make.height.equalTo(22)
            make.right.equalTo(self).offset(-15)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(0)
            make.left.right.equalTo(titleLabel)
            make.height.equalTo(18)
        }
        
        introductionLabel.snp.makeConstraints { make in
            make.left.left.right.equalTo(titleLabel)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(0)
            make.bottom.equalTo(self).offset(-50)
        }
        
        localLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.height.equalTo(20)
            make.width.equalTo(60)
            make.top.equalTo(introductionLabel.snp.bottom).offset(0)
        }
        
        hyperlinkButton.snp.makeConstraints { make in
            make.left.equalTo(localLabel.snp.right).offset(5)
            make.height.top.equalTo(localLabel)
            make.width.equalTo(200)
        }
        
        followingLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.height.equalTo(15)
            make.top.equalTo(localLabel.snp.bottom).offset(5)
            make.width.equalTo(100)
        }
        
        followerLabel.snp.makeConstraints { make in
            make.left.equalTo(followingLabel.snp.right).offset(10)
            make.height.equalTo(15)
            make.top.equalTo(localLabel.snp.bottom).offset(5)
            make.width.equalTo(100)
        }
    }
    
    func setupEvent() -> Void 
    {
        hyperlinkButton.rx.tap
            .subscribe(onNext:{ _ in 
                self.setupSafariController()
            }).disposed(by: disposeBag)
    }
    
    func setupSafariController() -> Void 
    {
        let url = URL(string: "https://waitwalker.cn")
        
        let safariController = SFSafariViewController(url: url!)
        
        shardInstance.getRootViewController().present(safariController, animated: true) { 
            
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 设置富文本 
    func setupRichText(imageName:String,behindString:String,behindStringColor:UIColor) -> NSMutableAttributedString 
    {
        let image = UIImage.imageNamed(name: imageName)
        
        // 设置图片附件
        let textAttachmet = NSTextAttachment()
        textAttachmet.image = image
        textAttachmet.bounds = CGRect(x: 0, y: -3, width: 20, height: 20)
        
        let attchmentAttStr = NSAttributedString(attachment: textAttachmet)
        let mutableAttStr = NSMutableAttributedString(attributedString: attchmentAttStr)
        
        let behindMutableAttStr = NSMutableAttributedString(string: behindString)
        behindMutableAttStr.setAttributes([NSForegroundColorAttributeName:behindStringColor], range: NSMakeRange(0, behindMutableAttStr.length))
        
        mutableAttStr.append(behindMutableAttStr)
        return mutableAttStr
    }
    
    func setupStringRichText(forwordString:String,forwordColor:UIColor,behindString:String,behindColor:UIColor) -> NSMutableAttributedString 
    {
        let mutableAttStr = NSMutableAttributedString(string: forwordString)
        mutableAttStr.setAttributes([NSForegroundColorAttributeName:UIColor.black], range: NSMakeRange(0, mutableAttStr.length))
        
        let behindMutableAttStr = NSMutableAttributedString(string: behindString)
        behindMutableAttStr.setAttributes([NSForegroundColorAttributeName:kMainGrayColor()], range: NSMakeRange(0, behindMutableAttStr.length))
        
        mutableAttStr.append(behindMutableAttStr)
        return mutableAttStr
    }
    

}
