//
//  MTTRegisterPasswordViewController.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/13.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTRegisterPasswordViewController: MTTViewController ,MTTRegitserViewModelDelegate
{
    var logoImageView:UIImageView?
    var passwordLabel:UILabel?
    var passwordHintLabel:UILabel?
    var showPasswordButton:UIButton?
    
    var passwordContentView:UIView?
    var passwordTextField:UITextField?
    var passwordLineView:UIView?
    var passwordVerifyImageView:UIImageView?
    
    
    
    var contentView:UIView?
    var nextButton:UIButton?
    var secondLine:UIView?
    
    var passwordUserInfo:[String:String]?
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        self.setupSubview()
        self.layoutSubview()
        self.setupEvent()
    }
    
    // MARK: - 初始化子控件
    func setupSubview() -> Void 
    {
        //back
        let leftBackButton = UIButton()
        leftBackButton.frame = CGRect(x: -20, y: 0, width: 0, height: 0)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBackButton)
        
        //logo
        logoImageView = UIImageView()
        logoImageView?.image = UIImage.init(named: "twitter_logo")
        logoImageView?.isUserInteractionEnabled = true
        self.view.addSubview(logoImageView!)
        
        //passwordLabel
        passwordLabel = UILabel()
        passwordLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        passwordLabel?.textAlignment = NSTextAlignment.left
        passwordLabel?.text = "你需要设置一个密码?"
        passwordLabel?.numberOfLines = 1
        passwordLabel?.sizeToFit()
        self.view.addSubview(passwordLabel!)
        
        //passwordHintLabel
        passwordHintLabel = UILabel()
        passwordHintLabel?.font = UIFont.systemFont(ofSize: 15)
        passwordHintLabel?.textAlignment = NSTextAlignment.left
        passwordHintLabel?.text = "请确保密码至少有6个字符"
        passwordHintLabel?.numberOfLines = 1
        passwordHintLabel?.sizeToFit()
        self.view.addSubview(passwordHintLabel!)
        
        //passwordContentView
        passwordContentView = UIView()
        self.view.addSubview(passwordContentView!)
        
        //passwordTextField
        passwordTextField = UITextField()
        passwordTextField?.placeholder = "密码"
        passwordTextField?.isSecureTextEntry = true
        passwordTextField?.font = UIFont.systemFont(ofSize: 15)
        passwordTextField?.textColor = kMainBlueColor()
        passwordContentView?.addSubview(passwordTextField!)
        
        //passwordVerifyImageView
        passwordVerifyImageView = UIImageView()
        passwordVerifyImageView?.isUserInteractionEnabled = true
        passwordVerifyImageView?.layer.borderWidth = 2
        passwordVerifyImageView?.layer.cornerRadius = 12.5
        passwordVerifyImageView?.clipsToBounds = true
        passwordVerifyImageView?.isHidden = true
        passwordContentView?.addSubview(passwordVerifyImageView!)
        
        //passwordLineView
        passwordLineView = UIView()
        passwordLineView?.backgroundColor = kMainGrayColor()
        passwordContentView?.addSubview(passwordLineView!)
        
        //showPasswordButton
        showPasswordButton = UIButton()
        showPasswordButton?.setTitleColor(kMainBlueColor(), for: UIControlState.normal)
        showPasswordButton?.setTitle("显示密码", for: UIControlState.normal)
        showPasswordButton?.titleEdgeInsets = UIEdgeInsetsMake(5, 0, 5, 10)
        showPasswordButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        showPasswordButton?.isHidden = true
        self.view.addSubview(showPasswordButton!)
        
        
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
        nextButton?.setTitleColor(kMainRedColor(), for: UIControlState.highlighted)
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
        
        //passwordContentView
        passwordContentView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self.view).offset(0)
            make.top.equalTo((self.passwordHintLabel?.snp.bottom)!).offset(5)
            make.height.equalTo(41)
        })
        
        //passwordTextField
        passwordTextField?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.passwordContentView!).offset(20)
            make.right.equalTo(self.passwordContentView!).offset(-50)
            make.top.equalTo(self.passwordContentView!).offset(0)
            make.height.equalTo(40)
        })
        
        //passwordVerifyImageView
        passwordVerifyImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.passwordTextField?.snp.right)!).offset(5)
            make.right.equalTo(self.view).offset(-20)
            make.height.width.equalTo(25)
            make.centerY.equalTo(self.passwordTextField!)
        })
        
        //passwordLineView
        passwordLineView?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.right.equalTo(0)
            make.bottom.equalTo(self.passwordTextField!).offset(-0.3)
            make.height.equalTo(0.3)
        })
        
        //showPasswordButton
        showPasswordButton?.snp.makeConstraints({ (make) in
            make.left.equalTo(15)
            make.width.equalTo(80)
            make.top.equalTo((self.passwordContentView?.snp.bottom)!).offset(5)
            make.height.equalTo(30)
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
        passwordTextField?.rx.text.map({($0?.characters.count)! >= 6})
            .subscribe(onNext:{ isTrue in
                
                if isTrue
                {
                    self.passwordVerifyImageView?.layer.borderColor = kMainGreenColor().cgColor
                    self.passwordVerifyImageView?.isHidden = false
                    self.passwordVerifyImageView?.image = UIImage(named: "name_valid")
                    self.showPasswordButton?.isHidden = false
                    self.nextButton?.isEnabled = true
                    self.nextButton?.setTitleColor(kMainWhiteColor(), for: UIControlState.normal)
                } else
                {
                    self.passwordVerifyImageView?.isHidden = true
                    self.showPasswordButton?.isHidden = true
                    self.nextButton?.isEnabled = false
                    self.nextButton?.setTitleColor(kMainGrayColor(), for: UIControlState.normal)
                }
                
        }).addDisposableTo(disposeBag)
        
        showPasswordButton?.rx.tap.subscribe(onNext:{[unowned self] in
            
            self.showPasswordButton?.isSelected = !(self.showPasswordButton?.isSelected)!;
            
            if (self.showPasswordButton?.isSelected)!
            {
                self.passwordTextField?.isSecureTextEntry = false
                self.showPasswordButton?.setTitle("隐藏密码", for: UIControlState.normal)
            } else
            {
                self.passwordTextField?.isSecureTextEntry = true
                self.showPasswordButton?.setTitle("显示密码", for: UIControlState.normal)
            }
            
        }).addDisposableTo(disposeBag)
        
        nextButton?.rx.tap.subscribe(onNext:{[unowned self] in
            
            let registerView = UIView()
            registerView.tag = 918
            registerView.frame = CGRect(x: 100, y: 200, width: 200, height: 200)
            registerView.backgroundColor = kMainBlueColor()
            let appDelegate = UIApplication.shared.delegate! as UIApplicationDelegate
            appDelegate.window??.addSubview(registerView)
            
            self.sharedInstance.password = (self.passwordTextField?.text)!
        
            let para = ["user_name":self.sharedInstance.user_name,
                 "email":self.sharedInstance.email,
                 "password":self.sharedInstance.password
                ]
            
            print("参数:",para)
            let viewModel = MTTRegitserViewModel()
            
            viewModel.delegate = self
            
            viewModel.requestRegister(parameters: para as NSDictionary)
            
        }).addDisposableTo(disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - 注册成功的回调
    func successCallBack(data: NSDictionary)
    {
        print(data)
        
        let tabBarVC = MTTTabBarController()
        let appDelegate = UIApplication.shared.delegate! as UIApplicationDelegate
        appDelegate.window??.rootViewController = tabBarVC
        appDelegate.window??.makeKeyAndVisible()
        
    }
    
    // MARK: - 注册失败的回调
    func failureCallBack(error: NSError)
    {
        print(error)
        
        let tabBarVC = MTTTabBarController()
        let appDelegate = UIApplication.shared.delegate! as UIApplicationDelegate
        appDelegate.window??.rootViewController = tabBarVC
        appDelegate.window??.makeKeyAndVisible()
        
        //移除的时候添加动画
        let registerView = appDelegate.window??.viewWithTag(918)
        
        UIView.animate(withDuration: 0.5, animations: { 
            registerView?.alpha = 0
        }) { (completed) in
            
            registerView?.removeFromSuperview()
        }
        
    }
    
}
