//
//  MTTRegisterStartViewController.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/6.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import SnapKit

class MTTRegisterStartViewController: MTTViewController {

    var logoImageView:UIImageView?
    var checkLabel:UILabel?
    var startButton:UIButton?
    var haveAccountLabel:UILabel?
    var loginButton:UIButton?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupSubview()
        self.layoutSubview()
        self.setupEvent()
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - 初始化控件
    func setupSubview() -> Void
    {
        //logo
        logoImageView = UIImageView.init(image: UIImage.init(named: "twitter_logo"))
        self.view.addSubview(logoImageView!)
        
        //check
        checkLabel = UILabel()
        checkLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        checkLabel?.textAlignment = NSTextAlignment.left
        checkLabel?.text = "查看世界当前正在发生的事情."
        checkLabel?.numberOfLines = 2
        checkLabel?.sizeToFit()
        self.view.addSubview(checkLabel!)
        
        //start
        startButton = UIButton()
        startButton?.setTitle("现在开始", for: UIControlState.normal)
        startButton?.layer.cornerRadius = 20
        startButton?.clipsToBounds = true
        startButton?.setTitleColor(UIColor.white, for: UIControlState.normal)
        startButton?.setTitleColor(kMainGrayColor(), for: UIControlState.highlighted)
        startButton?.setTitleColor(kRGBColor(r: 102, g: 102, b: 153), for: UIControlState.highlighted)
        startButton?.backgroundColor = kMainBlueColor()
        self.view.addSubview(startButton!)
        
        //haveAccount
        haveAccountLabel = UILabel()
        haveAccountLabel?.text = "已有账号?"
        haveAccountLabel?.textAlignment = NSTextAlignment.right
        haveAccountLabel?.textColor = kRGBColor(r: 102, g: 102, b: 153)
        haveAccountLabel?.font = UIFont.systemFont(ofSize: 15)
        self.view.addSubview(haveAccountLabel!)
        
        //loginButton
        loginButton = UIButton()
        loginButton?.setTitle("登录", for: UIControlState.normal)
        loginButton?.setTitleColor(kMainBlueColor(), for: UIControlState.normal)
        loginButton?.setTitleColor(kMainGrayColor(), for: UIControlState.highlighted)
        loginButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.view.addSubview(loginButton!)
        
        
    }
    
    // MARK: - 布局控件
    func layoutSubview() -> Void
    {
        //logo
        logoImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.view).offset(40)
            make.top.equalTo(self.view).offset(80)
            make.width.height.equalTo(30)
        })
        
        //check
        checkLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
            make.center.equalTo(self.view)
        })
        
        //start
        startButton?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
            make.height.equalTo(40)
            make.top.equalTo((self.checkLabel?.snp.bottom)!).offset(20)
        })
        
        //haveAccount
        haveAccountLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.view).offset(40)
            make.bottom.equalTo(self.view).offset(-50)
            make.width.equalTo(70)
            make.height.equalTo(25)
        })
        
        //loginButton
        loginButton?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.haveAccountLabel?.snp.right)!).offset(2)
            make.height.equalTo(25)
            make.width.equalTo(35)
            make.bottom.equalTo(self.view).offset(-50)
        })
    }
    
    // MARK: - 绑定事件
    func setupEvent() -> Void 
    {
        startButton?.rx.tap
            .subscribe(onNext: { [unowned self] in
                
                let registNameVC = MTTRegisterNameViewController()
                
                let nav = MTTNavigationController(rootViewController: registNameVC)
                self.present(nav, animated: true, completion: { 
                    
                })
            })
            .disposed(by: disposeBag)
        
        //loginButton
        loginButton?.rx.tap.subscribe(onNext:{ [unowned self] in
            
            let loginVC = MTTLoginViewController()
            self.present(loginVC, animated: true, completion: {
                
            })
            
        }).disposed(by: disposeBag)
    } 
}
