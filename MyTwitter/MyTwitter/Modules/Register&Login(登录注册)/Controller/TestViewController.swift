//
//  TestViewController.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/9/10.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
class TestViewController: MTTViewController
{
    var firstView:UIView?
    var secondView:UIView?
    var thirdView:UIView?
    var fourthView:UIView?
    
    var changeButton:UIButton?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupSubview()
        self.layoutSubview()
        self.setupEvent()
        
    }
    
    func setupSubview() -> Void
    {
        firstView = UIView()
        firstView?.backgroundColor = UIColor.orange
        firstView?.isHidden = false
        self.view.addSubview(firstView!)
        
        secondView = UIView()
        secondView?.backgroundColor = UIColor.brown
        secondView?.isHidden = false
        self.view.addSubview(secondView!)
        
        thirdView = UIView()
        thirdView?.backgroundColor = UIColor.purple
        thirdView?.isHidden = true
        self.view.addSubview(thirdView!)
        
        fourthView = UIView()
        fourthView?.backgroundColor = UIColor.green
        fourthView?.isHidden = false
        self.view.addSubview(fourthView!)
        
        changeButton = UIButton()
        changeButton?.setTitle("改变frame", for: UIControlState.normal)
        changeButton?.setTitleColor(kMainBlueColor(), for: UIControlState.normal)
        changeButton?.setTitleColor(kMainGrayColor(), for: UIControlState.highlighted)
        changeButton?.backgroundColor = UIColor.darkGray
        fourthView?.addSubview(changeButton!)
    }
    
    func layoutSubview() -> Void
    {
//        let _ = firstView?.mas_makeConstraints({ (make) in
//            make?.left.equalTo()(self.view)?.offset()(0)
//            make?.right.equalTo()(self.view)?.offset()(0)
//            make?.top.equalTo()(100)
//            make?.height.equalTo()(100)
//        })
//        
//        let _ = secondView?.mas_makeConstraints({ (make) in
//            make?.left.equalTo()(self.view)?.offset()(0)
//            make?.width.equalTo()(self.view)
//            make?.top.equalTo()(self.firstView?.mas_bottom)?.offset()(5)
//            make?.height.equalTo()(100)
//        })
//        
//        let _ = thirdView?.mas_makeConstraints({ (make) in
//            make?.left.equalTo()(self.view)?.offset()(0)
//            make?.width.equalTo()(self.view)
//            make?.top.equalTo()(self.firstView?.mas_bottom)?.offset()(5)
//            make?.height.equalTo()(150)
//        })
//        
//        let _ = fourthView?.mas_makeConstraints({ (make) in
//            make?.left.equalTo()(self.view)?.offset()(0)
//            make?.width.equalTo()(self.view)
//            make?.top.equalTo()(self.secondView?.mas_bottom)?.offset()(5)
//            make?.height.equalTo()(180)
//        })
//        
//        let _ = changeButton?.mas_makeConstraints({ (make) in
//            make?.left.equalTo()(self.view)?.offset()(0)
//            make?.width.equalTo()(self.view)
//            make?.top.equalTo()(self.fourthView)?.offset()(20)
//            make?.height.equalTo()(100)
//        })
        
//        firstView?.frame = CGRect(x: 0, y: 100, width: kScreenWidth, height: 100)
//        
//        secondView?.frame = CGRect(x: 0, y: 205, width: kScreenWidth, height: 100)
//        
//        thirdView?.frame = CGRect(x: 0, y: 205, width: kScreenWidth, height: 150)
//        
//        fourthView?.frame = CGRect(x: 0, y: 310, width: kScreenWidth, height: 180)
//        
//        changeButton?.frame = CGRect(x: 50, y: 50, width: 100, height: 50)
//        
        
    }
    
    func setupEvent() -> Void
    {
        (changeButton?.rx.tap)?.subscribe(onNext:{[unowned self] in
            
            self.changeButton?.isSelected = !(self.changeButton?.isSelected)!
            if (self.changeButton?.isSelected)!
            {
                self.secondView?.isHidden = false
                self.thirdView?.isHidden = true
                self.fourthView?.frame = CGRect(x: 0, y: 310, width: kScreenWidth, height: 180)
                
                
            } else
            {
                self.secondView?.isHidden = true
                self.thirdView?.isHidden = false
                self.fourthView?.frame = CGRect(x: 0, y: 360, width: kScreenWidth, height: 180)
            }
            
        }).addDisposableTo(disposeBag)
    }
    
    
    
    /**
     firstView?.frame = CGRect(x: 0, y: 100, width: kScreenWidth, height: 100)
     
     secondView?.frame = CGRect(x: 0, y: 205, width: kScreenWidth, height: 100)
     
     thirdView?.frame = CGRect(x: 0, y: 205, width: kScreenWidth, height: 150)
     
     fourthView?.frame = CGRect(x: 0, y: 310, width: kScreenWidth, height: 180)
     
     changeButton?.frame = CGRect(x: 50, y: 50, width: 100, height: 50)
     
     */
    
}
