//
//  MTTRegisterAccountViewController.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/6.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit


class MTTRegisterAccountViewController: MTTViewController,UITextViewDelegate
{
    var leftBackButton:UIButton?
    var logoImageView:UIImageView?
    var phoneOrEmailLabel:UILabel?
    var phoneOrEmailHintLabel:UILabel?
    
    var phoneContentView:UIView?
    var phoneAreaCodeButton:UIButton?
    var phoneTextField:UITextField?
    var phoneBottomLineView:UIView?
    var phoneDownImageView:UIImageView?
    var verifyImageView:UIImageView?
    var phoneSecondLineView:UIView?
    
    var emailContentView:UIView?
    var emailTextField:UITextField?
    var emailLineView:UIView?
    var emailVerifyImageView:UIImageView?
    
    var errorHintLabel:UILabel?
    
    var serviceContentView:UIView?
    var serviceTextView:UITextView?
    var privateOptionButton:UIButton?
    var serviceDotView:UIView?
    var changeButton:UIButton?
    
    var contentView:UIView?
    var nextButton:UIButton?
    var secondLine:UIView?
    
    var accountUserInfo:[String:String]?
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        self.setupSubview()
        self.layoutSubview()
        self.setupEvent()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlerKeyBoardFrame(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    // MARK: - 键盘通知回调
    @objc func handlerKeyBoardFrame(notification:NSNotification) -> Void
    {
        let beginValue = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as! NSValue!
        let beginFrame = beginValue?.cgRectValue
        
        let endValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue!
        let endFrame = endValue?.cgRectValue
        
        let deltaY = (endFrame?.origin.y)! - (beginFrame?.origin.y)!
        
        UIView.animate(withDuration: 0.25) {
            self.contentView?.frame = CGRect(x: (self.contentView?.frame.origin.x)!, y: (self.contentView?.frame.origin.y)! + deltaY, width: (self.contentView?.frame.origin.x)!, height: (self.contentView?.frame.size.height)!)
        }
        
    }
    
    func setupSubview() -> Void 
    {
        
        //back
        leftBackButton = UIButton()
        leftBackButton?.frame = CGRect(x: -20, y: 0, width: 50, height: 44)
        leftBackButton?.setImage(UIImage.init(named: "twitter_back"), for: UIControlState.normal)
        leftBackButton?.imageEdgeInsets = UIEdgeInsetsMake(12, 0, 12, 28)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBackButton!)
        
        //logo
        logoImageView = UIImageView()
        logoImageView?.image = UIImage.init(named: "twitter_logo")
        logoImageView?.isUserInteractionEnabled = true
        self.view.addSubview(logoImageView!)
        
        //phoneOrEmailLabel
        phoneOrEmailLabel = UILabel()
        phoneOrEmailLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        phoneOrEmailLabel?.textAlignment = NSTextAlignment.left
        phoneOrEmailLabel?.text = "你的电话号码是什么?"
        phoneOrEmailLabel?.numberOfLines = 1
        phoneOrEmailLabel?.sizeToFit()
        self.view.addSubview(phoneOrEmailLabel!)
        
        //phoneOrEmailHintLabel
        phoneOrEmailHintLabel = UILabel()
        phoneOrEmailHintLabel?.font = UIFont.systemFont(ofSize: 15)
        phoneOrEmailHintLabel?.textAlignment = NSTextAlignment.left
        phoneOrEmailHintLabel?.text = "不用担心,我们不会公开显示."
        phoneOrEmailHintLabel?.numberOfLines = 1
        phoneOrEmailHintLabel?.sizeToFit()
        self.view.addSubview(phoneOrEmailHintLabel!)
        
        //phoneContentView
        phoneContentView = UIView()
        phoneContentView?.isHidden = false
        self.view.addSubview(phoneContentView!)
        
        //phoneAreaCodeButton
        phoneAreaCodeButton = UIButton()
        phoneAreaCodeButton?.setTitle("中国 +86", for: UIControlState.normal)
        phoneAreaCodeButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        phoneAreaCodeButton?.setTitleColor(kMainBlueColor(), for: UIControlState.normal)
        phoneAreaCodeButton?.setBackgroundImage(self.imageWithColor(color: kRGBColor(r: 236, g: 238, b: 240)), for: UIControlState.highlighted)
        phoneAreaCodeButton?.titleEdgeInsets = UIEdgeInsetsMake(10, 20, 10, kScreenWidth - 100)
        phoneContentView?.addSubview(phoneAreaCodeButton!)
        
        //phoneBottomLineView
        phoneBottomLineView = UIView()
        phoneBottomLineView?.backgroundColor = kMainGrayColor()
        phoneAreaCodeButton?.addSubview(phoneBottomLineView!)
        
        //phoneDownImageView
        phoneDownImageView = UIImageView()
        phoneDownImageView?.isUserInteractionEnabled = true
        phoneDownImageView?.image = UIImage(named: "twitter_down_arrow")
        phoneAreaCodeButton?.addSubview(phoneDownImageView!)
        
        //phoneTextField
        phoneTextField = UITextField()
        phoneTextField?.placeholder = "手机号码"
        phoneTextField?.keyboardType = UIKeyboardType.numberPad
        phoneTextField?.font = UIFont.systemFont(ofSize: 15)
        phoneTextField?.textColor = kMainBlueColor()
        phoneContentView?.addSubview(phoneTextField!)
        
        //verifyImageView
        verifyImageView = UIImageView()
        verifyImageView?.isUserInteractionEnabled = true
        verifyImageView?.layer.borderWidth = 2
        verifyImageView?.layer.cornerRadius = 12.5
        verifyImageView?.layer.borderColor = kMainRedColor().cgColor
        verifyImageView?.clipsToBounds = true
        verifyImageView?.isHidden = true
        phoneContentView?.addSubview(verifyImageView!)
        
        //phoneSecondLineView
        phoneSecondLineView = UIView()
        phoneSecondLineView?.backgroundColor = kMainGrayColor()
        phoneContentView?.addSubview(phoneSecondLineView!)
        
        //emailContentView
        emailContentView = UIView()
        emailContentView?.isHidden = true
        self.view.addSubview(emailContentView!)
        
        //emailTextField
        emailTextField = UITextField()
        emailTextField?.placeholder = "邮件地址"
        emailTextField?.keyboardType = UIKeyboardType.emailAddress
        emailTextField?.font = UIFont.systemFont(ofSize: 15)
        emailTextField?.textColor = kMainBlueColor()
        emailContentView?.addSubview(emailTextField!)
        
        //emailVerifyImageView
        emailVerifyImageView = UIImageView()
        emailVerifyImageView?.isUserInteractionEnabled = true
        emailVerifyImageView?.layer.borderWidth = 2
        emailVerifyImageView?.layer.cornerRadius = 12.5
        emailVerifyImageView?.clipsToBounds = true
        emailVerifyImageView?.isHidden = true
        emailContentView?.addSubview(emailVerifyImageView!)
        
        //emailLineView
        emailLineView = UIView()
        emailLineView?.backgroundColor = kMainGrayColor()
        emailContentView?.addSubview(emailLineView!)
        
        //errorHintLabel
        errorHintLabel = UILabel()
        errorHintLabel?.textColor = kMainWhiteColor()
        errorHintLabel?.text = "    请输入有效的手机号码."
        errorHintLabel?.backgroundColor = kMainRedColor()
        errorHintLabel?.textAlignment = NSTextAlignment.left
        errorHintLabel?.font = UIFont.systemFont(ofSize: 15)
        errorHintLabel?.isHidden = true
        self.view.addSubview(errorHintLabel!)
        
        //serviceContentView
        serviceContentView = UIView()
        self.view.addSubview(serviceContentView!)
        
        //serviceTextView
        serviceTextView = UITextView()
        let allString:NSString = "注册意味着你同意服务条款与隐私政策,包括Cookie使用政策.其他用户将可以通过你所提供的邮件地址或手机号码找到你."
        serviceTextView?.attributedText = UITextView.addLinkToString(allString: allString, changedStrings: ["服务条款","隐私政策","Cookie使用政策"], changedStringColor: kMainBlueColor(), stringStyle: NSUnderlineStyle.styleNone.rawValue)
        serviceTextView?.dataDetectorTypes = UIDataDetectorTypes.link
        serviceTextView?.delegate = self
        serviceTextView?.isSelectable = true
        serviceTextView?.isEditable = false
        serviceTextView?.font = UIFont.systemFont(ofSize: 15)
        serviceContentView?.addSubview(serviceTextView!)
        
        //privateOptionButton
        privateOptionButton = UIButton()
        privateOptionButton?.setTitle("隐私选项", for: UIControlState.normal)
        privateOptionButton?.setTitleColor(kMainBlueColor(), for: UIControlState.normal)
        privateOptionButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        privateOptionButton?.setTitleColor(kMainGrayColor(), for: UIControlState.highlighted)
        serviceContentView?.addSubview(privateOptionButton!)
        
        //serviceDotView
        serviceDotView = UIView()
        serviceDotView?.backgroundColor = kRGBColor(r: 145, g: 161, b: 173)
        serviceDotView?.layer.cornerRadius = 2.5
        serviceDotView?.clipsToBounds = true
        serviceContentView?.addSubview(serviceDotView!)
        
        //changeButton
        changeButton = UIButton()
        changeButton?.setTitle("改为使用邮件", for: UIControlState.normal)
        changeButton?.setTitleColor(kMainBlueColor(), for: UIControlState.normal)
        changeButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        changeButton?.setTitleColor(kMainGrayColor(), for: UIControlState.highlighted)
        changeButton?.isSelected = true
        serviceContentView?.addSubview(changeButton!)
        
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
    
    func layoutSubview() -> Void 
    {
        //logo
        logoImageView?.snp.makeConstraints({ (make) in
            make.height.width.equalTo(30)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(27)
        })
        
        //phoneOrEmailLabel
        phoneOrEmailLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.view).offset(20)
            make.width.equalTo(kScreenWidth - 100)
            make.height.equalTo(40)
            make.top.equalTo(self.view).offset(100)
        })
        
        //phoneOrEmailHintLabel
        phoneOrEmailHintLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.phoneOrEmailLabel!)
            make.width.equalTo(self.phoneOrEmailLabel!)
            make.height.equalTo(25)
            make.top.equalTo((self.phoneOrEmailLabel?.snp.bottom)!).offset(5)
        })
        
        //phoneContentView
        phoneContentView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.view!)
            make.width.equalTo(self.view!)
            make.height.equalTo(86)
            make.top.equalTo((self.phoneOrEmailHintLabel?.snp.bottom)!).offset(5)
        })
        
        //phoneAreaCodeButton
        phoneAreaCodeButton?.snp.makeConstraints({ (make) in
            make.width.equalTo(self.phoneContentView!)
            make.height.equalTo(40)
            make.top.equalTo(0)
        })
        
        //phoneBottomLineView
        phoneBottomLineView?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.right.equalTo(0)
            make.bottom.equalTo(self.phoneAreaCodeButton!).offset(-0.3)
            make.height.equalTo(0.3)
        })
        
        //phoneDownImageView
        phoneDownImageView?.snp.makeConstraints({ (make) in
            make.height.width.equalTo(15)
            make.right.equalTo(phoneAreaCodeButton!).offset(-20)
            make.centerY.equalTo(phoneAreaCodeButton!)
        })
        
        //phoneTextField
        phoneTextField?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.phoneContentView!).offset(20)
            make.right.equalTo(self.phoneContentView!).offset(-50)
            make.height.equalTo(40)
            make.top.equalTo((self.phoneAreaCodeButton?.snp.bottom)!).offset(5)
        })
        
        //verifyImageView
        verifyImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.phoneTextField?.snp.right)!).offset(5)
            make.right.equalTo(self.phoneContentView!).offset(-20)
            make.height.width.equalTo(25)
            make.centerY.equalTo(self.phoneTextField!)
        })
        
        //phoneSecondLineView
        phoneSecondLineView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.phoneContentView!).offset(20)
            make.height.equalTo(0.3)
            make.top.equalTo((self.phoneTextField?.snp.bottom)!).offset(1)
            make.right.equalTo(self.phoneContentView!).offset(0)
        })
        
        //emailContentView
        emailContentView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self.view).offset(0)
            make.top.equalTo((self.phoneOrEmailHintLabel?.snp.bottom)!).offset(5)
            make.height.equalTo(41)
        })
        
        //emailTextField
        emailTextField?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.emailContentView!).offset(20)
            make.right.equalTo(self.emailContentView!).offset(-50)
            make.top.equalTo(self.emailContentView!).offset(0)
            make.height.equalTo(40)
        })
        
        //emailVerifyImageView
        emailVerifyImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.emailTextField?.snp.right)!).offset(5)
            make.right.equalTo(self.view).offset(-20)
            make.height.width.equalTo(25)
            make.centerY.equalTo(self.emailTextField!)
        })
        
        //emailLineView
        emailLineView?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.right.equalTo(0)
            make.bottom.equalTo(self.emailTextField!).offset(-0.3)
            make.height.equalTo(0.3)
        })
        
        //errorHintLabel
        errorHintLabel?.frame = CGRect(x: 0, y: 266, width: kScreenWidth, height: 50)
        
        serviceContentView?.frame = CGRect(x: 0, y: 271, width: kScreenWidth, height: 100)
        
        //serviceTextView
        serviceTextView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.serviceContentView!).offset(20)
            make.right.equalTo(self.serviceContentView!).offset(-20)
            make.top.equalTo(self.serviceContentView!).offset(0)
            make.height.equalTo(70)
        })
        
        //privateOptionButton
        privateOptionButton?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.width.equalTo(70)
            make.height.equalTo(25)
            make.top.equalTo((self.serviceTextView?.snp.bottom)!).offset(5)
        })
        
        //serviceDotView
        serviceDotView?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.privateOptionButton?.snp.right)!).offset(5)
            make.height.width.equalTo(5)
            make.centerY.equalTo(self.privateOptionButton!)
        })
        
        //changeButton
        changeButton?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.serviceDotView?.snp.right)!).offset(5)
            make.width.equalTo(100)
            make.height.equalTo(25)
            make.centerY.equalTo(self.serviceDotView!)
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
    
    func setupEvent() -> Void 
    {   
        //back
        leftBackButton?.rx.tap.subscribe(onNext:{[unowned self] in
            
            self.view.endEditing(true)
            
            let _ = self.navigationController?.popViewController(animated: true)
            
        }).addDisposableTo(disposeBag)
        
        //phoneAreaCodeButton
        phoneAreaCodeButton?.rx.tap.subscribe(onNext:{[unowned self] in
            
            let phoneAreaCodeVC = MTTPhoneAreaCodeViewController()
            phoneAreaCodeVC.searchCompletion = {(areaName:String,areaCodeName:String) in
                self.phoneAreaCodeButton?.titleEdgeInsets = UIEdgeInsetsMake(10, 20, 10, kScreenWidth - 80)
                self.phoneAreaCodeButton?.setTitle(String.init(format: "+%@", areaCodeName), for: UIControlState.normal)
            }               
            
            self.present(phoneAreaCodeVC, animated: true, completion: {
                
            })
            
        }).addDisposableTo(disposeBag)
        
        //phoneTextField
        phoneTextField?.rx.text
            .map{_ in (
                    MTTRegularMatchManager.validateMobile(phone: (self.phoneTextField?.text)!)
                )}
            .subscribe(onNext:
                { element in
                    self.verifyImageView?.isHidden = false
                    
                    if !(self.phoneContentView?.isHidden)!
                    {
                        if element
                        {
                            self.errorHintLabel?.isHidden = true
                            self.verifyImageView?.image = UIImage(named: "name_valid")
                            self.verifyImageView?.layer.borderColor = kMainGreenColor().cgColor
                            self.serviceContentView?.frame = CGRect(x: 0, y: 271, width: kScreenWidth, height: 100)
                            
                            self.nextButton?.setTitleColor(kMainWhiteColor(), for: UIControlState.normal)
                            self.nextButton?.isEnabled = true
                            self.view.endEditing(true)
                            
                        } else
                        {
                            self.errorHintLabel?.isHidden = false
                            self.errorHintLabel?.text = "    请输入有效的手机号码."
                            self.verifyImageView?.image = UIImage(named: "name_invalid")
                            self.verifyImageView?.layer.borderColor = kMainRedColor().cgColor
                            self.errorHintLabel?.frame = CGRect(x: 0, y: 266, width: kScreenWidth, height: 50)
                            self.serviceContentView?.frame = CGRect(x: 0, y: 321, width: kScreenWidth, height: 100)
                            
                            self.nextButton?.setTitleColor(kMainGrayColor(), for: UIControlState.normal)
                            self.nextButton?.isEnabled = false
                        }
                    } 
                })
            .addDisposableTo(disposeBag)
        
        //emailTextField            
        emailTextField?.rx.text.map{_ in (
            MTTRegularMatchManager.validateEmail(email: (self.emailTextField?.text)!))}
            .subscribe(onNext:{ element in
                self.emailVerifyImageView?.isHidden = false
                
                if !(self.emailContentView?.isHidden)!
                {
                    if element 
                    {
                        self.errorHintLabel?.isHidden = true
                        self.emailVerifyImageView?.image = UIImage(named: "name_valid")
                        self.emailVerifyImageView?.layer.borderColor = kMainGreenColor().cgColor
                        self.serviceContentView?.frame = CGRect(x: 0, y: 226, width: kScreenWidth, height: 100)
                        
                        self.nextButton?.setTitleColor(kMainWhiteColor(), for: UIControlState.normal)
                        self.nextButton?.isEnabled = true
                        self.view.endEditing(true)
                    } else
                    {
                        self.errorHintLabel?.isHidden = false
                        self.errorHintLabel?.text = "    邮件地址无效."
                        self.emailVerifyImageView?.image = UIImage(named: "name_invalid")
                        self.emailVerifyImageView?.layer.borderColor = kMainRedColor().cgColor
                        self.errorHintLabel?.frame = CGRect(x: 0, y: 221, width: kScreenWidth, height: 50)
                        self.serviceContentView?.frame = CGRect(x: 0, y: 276, width: kScreenWidth, height: 100)
                        
                        self.nextButton?.setTitleColor(kMainGrayColor(), for: UIControlState.normal)
                        self.nextButton?.isEnabled = false
                    }
                } 
                
            }).addDisposableTo(disposeBag)
            
        //changeButton
        changeButton?.rx.tap.subscribe(onNext:{ [unowned self] in
            
            self.changeButton?.isSelected = !(self.changeButton?.isSelected)!
            self.errorHintLabel?.isHidden = true
            self.verifyImageView?.isHidden = true
            
            if (self.changeButton?.isSelected)!
            {
                self.changeButton?.setTitle("改为使用邮件", for: UIControlState.normal)
                self.phoneOrEmailLabel?.text = "你的电话号码是什么?"
                self.phoneOrEmailHintLabel?.text = "不用担心,我们不会公开显示."
                
                self.phoneContentView?.isHidden = false
                self.emailContentView?.isHidden = true
                
                self.serviceContentView?.frame = CGRect(x: 0, y: 271, width: kScreenWidth, height: 100)
                
            } else
            {
                self.changeButton?.setTitle("改为使用手机", for: UIControlState.normal)
                self.phoneOrEmailLabel?.text = "你的邮箱地址是什么?"
                self.phoneOrEmailHintLabel?.text = "我们不会给你发送垃圾邮件."
                
                self.emailContentView?.isHidden = false
                self.phoneContentView?.isHidden = true
                self.serviceContentView?.frame = CGRect(x: 0, y: 226, width: kScreenWidth, height: 100)
            }
            
        }).addDisposableTo(disposeBag)
        
        //nextButton
        (nextButton?.rx.tap)?.subscribe(onNext:({[unowned self] in
            
            if (self.phoneContentView?.isHidden)!
            {
                print(self.emailTextField?.text as Any)
            } else
            {
                //显示alert
                self.showAlertController(message: (self.phoneTextField?.text)!)
            }
            
            self.sharedInstance.email = (self.emailTextField?.text)!
            
            let registerPasswordVC = MTTRegisterPasswordViewController()
            self.navigationController?.pushViewController(registerPasswordVC, animated: true)
            
        })).addDisposableTo(disposeBag)
            
    }
    
    // MARK: - 显示alertController
    func showAlertController(message:String) -> Void 
    {
        let alertController = UIAlertController(title: String.init(format: "我们会发送一个验证码到+86%@", message), message: "可能收取短信费", preferredStyle: UIAlertControllerStyle.alert)
        let actionEdit = UIAlertAction(title: "编辑", style: UIAlertActionStyle.default, handler: { (action) in
            
        })
        
        let actionOK = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            
        })
        
        alertController.addAction(actionEdit)
        alertController.addAction(actionOK)
        
        self.present(alertController, animated: true, completion: { 
            
        })

    }
    
    // MARK: - private
    func imageWithColor(color:UIColor) -> UIImage 
    {
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image!
    }
    
    override func addKeyValue() 
    {
        self.userInfo = ["email":(self.emailTextField?.text)!]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) 
    {
        self.view.endEditing(true)
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
}
