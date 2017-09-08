//
//  MTTRegisterAccountViewController.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/6.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTRegisterAccountViewController: MTTViewController 
{
    var leftBackButton:UIButton?
    var logoImageView:UIImageView?
    var phoneOrEmailLabel:UILabel?
    var phoneOrEmailHintLabel:UILabel?
    var phoneAreaCodeButton:UIButton?
    var phoneTextField:UITextField?
    var phoneBottomLineView:UIView?
    var phoneDownImageView:UIImageView?
    
    
    
    
    
    
    
    
    
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
        
        //phoneAreaCodeButton
        phoneAreaCodeButton = UIButton()
        phoneAreaCodeButton?.setTitle("中国 +86", for: UIControlState.normal)
        phoneAreaCodeButton?.setTitleColor(kMainBlueColor(), for: UIControlState.normal)
        phoneAreaCodeButton?.setBackgroundImage(self.imageWithColor(color: kRGBColor(r: 236, g: 238, b: 240)), for: UIControlState.highlighted)
        phoneAreaCodeButton?.titleEdgeInsets = UIEdgeInsetsMake(10, 20, 10, kScreenWidth - 100)
        self.view.addSubview(phoneAreaCodeButton!)
        
        //phoneBottomLineView
        phoneBottomLineView = UIView()
        phoneBottomLineView?.backgroundColor = kMainGrayColor()
        phoneAreaCodeButton?.addSubview(phoneBottomLineView!)
        
        //phoneDownImageView
        phoneDownImageView = UIImageView()
        phoneDownImageView?.isUserInteractionEnabled = true
        phoneDownImageView?.image = UIImage(named: "twitter_down_arrow")
        phoneAreaCodeButton?.addSubview(phoneDownImageView!)
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
        
        //phoneAreaCodeButton
        phoneAreaCodeButton?.snp.makeConstraints({ (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(40)
            make.top.equalTo((self.phoneOrEmailHintLabel?.snp.bottom)!).offset(10)
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
    }
    
    func setupEvent() -> Void 
    {   
        //back
        leftBackButton?.rx.tap.subscribe(onNext:{[unowned self] in
            
            let _ = self.navigationController?.popViewController(animated: true)
            
        }).addDisposableTo(disposeBag)
        
        //phoneAreaCodeButton
        phoneAreaCodeButton?.rx.tap.subscribe(onNext:{[unowned self] in
            
            let searchVC = MTTSearchViewController()
            searchVC.searchCompletion = {(areaName:String,areaCodeName:String) in
                self.phoneAreaCodeButton?.titleEdgeInsets = UIEdgeInsetsMake(10, 20, 10, kScreenWidth - 80)
                self.phoneAreaCodeButton?.setTitle(String.init(format: "+%@", areaCodeName), for: UIControlState.normal)
            }               
            
            self.present(searchVC, animated: true, completion: { 
                
            })
            
        }).addDisposableTo(disposeBag)
    }

    
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
}
