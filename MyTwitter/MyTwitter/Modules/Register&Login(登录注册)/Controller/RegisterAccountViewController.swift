//
//  RegisterAccountViewController.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/5.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class RegisterAccountViewController: MTTViewController 
{
    let kRegisterAccountMargin:CGFloat = 20
    
    var cancelButton:UIButton?
    var logoImageView:UIImageView?
    var accountLabel:UILabel?
    var accountTextField:UITextField?
    var verifyImageView:UIImageView?
    var errorHintLabel:UILabel?
    var firstLine:UIView?
    var nextButton:UIButton?
    var secondLine:UIView?

    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        self.setupSubview()
        self.layoutSubview()
        self.setupEvent()
        
    }
    
    // MARK: - 初始化控件
    func setupSubview() -> Void 
    {
        //cancelButton
        cancelButton = UIButton()
        cancelButton?.setTitle("取消", for: UIControlState.normal)
        cancelButton?.setTitleColor(kMainBlueColor(), for: UIControlState.normal)
        cancelButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        self.view.addSubview(cancelButton!)
        
        //logo
        logoImageView = UIImageView()
        logoImageView?.image = UIImage.init(named: "twitter_logo")
        logoImageView?.isUserInteractionEnabled = true
        self.view.addSubview(logoImageView!)
        
        //accountLabel
        accountLabel = UILabel()
        accountLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        accountLabel?.text = "你好,请问你的姓名是什么?"
        accountLabel?.textColor = UIColor.black
        self.view.addSubview(accountLabel!)
        
        //accountTextField
        accountTextField = UITextField()
        accountTextField?.placeholder = "全名"
        accountTextField?.textColor = kMainBlueColor()
        accountTextField?.font = UIFont.systemFont(ofSize: 18)
        self.view.addSubview(accountTextField!)
        
        //verifyImageView
        verifyImageView = UIImageView()
        verifyImageView?.image = UIImage.init(named: "account_invalid")
        verifyImageView?.isUserInteractionEnabled = true
        verifyImageView?.layer.borderColor = UIColor.green.cgColor
        verifyImageView?.layer.borderWidth = 2
        verifyImageView?.layer.cornerRadius = 12.5
        verifyImageView?.clipsToBounds = true
        self.view.addSubview(verifyImageView!)
        
        //firstLine
        firstLine = UIView()
        firstLine?.backgroundColor = kMainGrayColor()
        self.view.addSubview(firstLine!)
        
        //secondLine
        secondLine = UIView()
        secondLine?.backgroundColor = kMainGrayColor()
        self.view.addSubview(secondLine!)
        
        //nextButton
        nextButton = UIButton()
        nextButton?.setTitle("下一步", for: UIControlState.normal)
        nextButton?.setTitleColor(kMainGrayColor(), for: UIControlState.normal)
        nextButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        nextButton?.backgroundColor = kMainBlueColor()
        nextButton?.layer.cornerRadius = 17.5
        nextButton?.clipsToBounds = true
        self.view.addSubview(nextButton!)
        
        
    }
    
    // MARK: - 布局控件
    func layoutSubview() -> Void 
    {
        //cancel
        cancelButton?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.view).offset(kRegisterAccountMargin)
            make.top.equalTo(self.view).offset(30)
            make.height.equalTo(25)
            make.width.equalTo(35)
        })
        
        //logo
        logoImageView?.snp.makeConstraints({ (make) in
            make.height.width.equalTo(30)
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.cancelButton!)
        })
        
        //accountLabel
        accountLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.view).offset(kRegisterAccountMargin)
            make.right.equalTo(self.view).offset(-kRegisterAccountMargin)
            make.top.equalTo(self.view).offset(80)
            make.height.equalTo(40)
        })
        
        //accountTextField
        accountTextField?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.accountLabel?.snp.bottom)!).offset(20)
            make.left.equalTo(self.view).offset(kRegisterAccountMargin)
            make.right.equalTo(self.view).offset(-50)
            make.height.equalTo(30)
        })
        
        //verifyImageView
        verifyImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.accountTextField?.snp.right)!).offset(5)
            make.right.equalTo(self.view).offset(-20)
            make.height.width.equalTo(25)
            make.centerY.equalTo(self.accountTextField!)
        })
        
        //firstLine
        firstLine?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(0)
            make.height.equalTo(0.3)
            make.top.equalTo((self.accountTextField?.snp.bottom)!).offset(10)
        })
        
        //secondLine
        secondLine?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self.view).offset(0)
            make.bottom.equalTo(self.view).offset(-50)
            make.height.equalTo(0.3)
        })
        
        //nextButton
        nextButton?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.view).offset(-20)
            make.height.equalTo(35)
            make.top.equalTo((self.secondLine?.snp.bottom)!).offset(7.5)
            make.width.equalTo(70)
        })
    }
    
    // MARK: - 绑定事件
    func setupEvent() -> Void 
    {
        //cancel
        cancelButton?.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.dismiss(animated: true, completion: { 
                    
                })
            })
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
