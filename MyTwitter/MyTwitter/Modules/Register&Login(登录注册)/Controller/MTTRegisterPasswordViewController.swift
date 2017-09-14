//
//  MTTRegisterPasswordViewController.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/13.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTRegisterPasswordViewController: MTTViewController 
{
    var logoImageView:UIImageView?
    var passwordLabel:UILabel?
    var passwordHintLabel:UILabel?
    var passwordTextField:UITextField?
    var passwordBottomLineView:UIView?
    var passwordVerifyImageView:UIImageView?
    var showPasswordButton:UIButton?
    
    
    var contentView:UIView?
    var nextButton:UIButton?
    var secondLine:UIView?
    
    override func viewDidLoad() 
    {
        self.setupSubview()
        self.layoutSubview()
        self.setupEvent()
    }
    
    // MARK: - 初始化子控件
    func setupSubview() -> Void 
    {
        //logo
        logoImageView = UIImageView()
        logoImageView?.image = UIImage.init(named: "twitter_logo")
        logoImageView?.isUserInteractionEnabled = true
        self.view.addSubview(logoImageView!)
        
        
        //passwordLabel
        passwordLabel = UILabel()
        passwordLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        passwordLabel?.textAlignment = NSTextAlignment.left
        passwordLabel?.text = "你的电话号码是什么?"
        passwordLabel?.numberOfLines = 1
        passwordLabel?.sizeToFit()
        self.view.addSubview(passwordLabel!)
        
        //passwordHintLabel
        passwordHintLabel = UILabel()
        passwordHintLabel?.font = UIFont.systemFont(ofSize: 15)
        passwordHintLabel?.textAlignment = NSTextAlignment.left
        passwordHintLabel?.text = "不用担心,我们不会公开显示."
        passwordHintLabel?.numberOfLines = 1
        passwordHintLabel?.sizeToFit()
        self.view.addSubview(passwordHintLabel!)
        
        //contentView
        contentView = UIView()
        self.view.addSubview(contentView!)
        
        //secondLine
        secondLine = UIView()
        secondLine?.backgroundColor = kMainGrayColor()
        contentView?.addSubview(secondLine!)
        
        //nextButton
        nextButton = UIButton()
        nextButton?.setTitle("下一步", for: UIControlState.normal)
        nextButton?.setTitleColor(kMainGrayColor(), for: UIControlState.normal)
        nextButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        nextButton?.backgroundColor = kMainBlueColor()
        nextButton?.layer.cornerRadius = 17.5
        nextButton?.clipsToBounds = true
        contentView?.addSubview(nextButton!)
    }
    
    // MARK: - 布局子控件
    func layoutSubview() -> Void 
    {
        //logo
        logoImageView?.snp.makeConstraints({ (make) in
            make.height.width.equalTo(30)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(27)
        })
        
        //passwordLabel
        passwordLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.view).offset(20)
            make.width.equalTo(kScreenWidth - 100)
            make.height.equalTo(40)
            make.top.equalTo(self.view).offset(100)
        })
        
        //passwordHintLabel
        passwordHintLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.passwordLabel!)
            make.width.equalTo(self.passwordLabel!)
            make.height.equalTo(25)
            make.top.equalTo((self.passwordLabel?.snp.bottom)!).offset(5)
        })
        
        //contentView
        contentView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self.view).offset(0)
            make.height.equalTo(50)
            make.bottom.equalTo(self.view).offset(0)
        })
        
        //secondLine
        secondLine?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self.contentView!).offset(0)
            make.top.equalTo(self.contentView!).offset(0)
            make.height.equalTo(0.3)
        })
        
        //nextButton
        nextButton?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.contentView!).offset(-20)
            make.height.equalTo(35)
            make.top.equalTo((self.secondLine?.snp.bottom)!).offset(7.5)
            make.width.equalTo(70)
        })
        
        

    }
    
    // MARK: - 初始化事件
    func setupEvent() -> Void 
    {
        
    }
    
}
