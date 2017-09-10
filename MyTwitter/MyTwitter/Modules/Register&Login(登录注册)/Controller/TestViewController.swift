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
        firstView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.view).offset(0)
            make.right.equalTo(self.view).offset(0)
            make.top.equalTo(100)
            make.height.equalTo(100)
        })
        
        secondView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.view).offset(0)
            make.width.equalTo(self.view)
            make.height.equalTo(100)
            make.top.equalTo((self.firstView?.snp.bottom)!).offset(5)
        })
        
        thirdView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.view).offset(0)
            make.width.equalTo(self.view)
            make.height.equalTo(150)
            make.top.equalTo((self.firstView?.snp.bottom)!).offset(5)
        })
        
        fourthView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.view).offset(0)
            make.width.equalTo(self.view)
            make.height.equalTo(180)
            make.top.equalTo((self.secondView?.snp.bottom)!).offset(5)
        })
        
        changeButton?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.view).offset(0)
            make.width.equalTo(self.view)
            make.height.equalTo(100)
            make.top.equalTo(self.fourthView!).offset(20)
        })
    }
    
    func setupEvent() -> Void
    {
        (changeButton?.rx.tap)?.subscribe(onNext:{[unowned self] in
            
            self.changeButton?.isSelected = !(self.changeButton?.isSelected)!
            if (self.changeButton?.isSelected)!
            {
                self.secondView?.isHidden = false
                self.thirdView?.isHidden = true
                self.fourthView?.snp.makeConstraints({ (make) in
                    make.left.equalTo(self.view).offset(0)
                    make.width.equalTo(self.view)
                    make.height.equalTo(180)
                    make.top.equalTo((self.secondView?.snp.bottom)!).offset(5)
                })
                
            } else
            {
                self.secondView?.isHidden = true
                self.thirdView?.isHidden = false
                self.fourthView?.snp.makeConstraints({ (make) in
                    make.left.equalTo(self.view).offset(0)
                    make.width.equalTo(self.view)
                    make.height.equalTo(180)
                    make.top.equalTo((self.thirdView?.snp.bottom)!).offset(5)
                })
            }
            
        }).addDisposableTo(disposeBag)
    }
    
    
    
    
}
