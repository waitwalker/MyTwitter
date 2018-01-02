//
//  MTTAlertController.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/11/6.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxGesture

class MTTAlertController: NSObject
{
    class func showAlertController(button:UIButton, controller:UIViewController) -> Void
    {
        let alertContoller = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let retwitterAction = UIAlertAction(title: "转推", style: UIAlertActionStyle.default) { (action) in
            
        }
        
        let quoteTwitter = UIAlertAction(title: "引用推文", style: UIAlertActionStyle.default) { (action) in
            
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (action) in
            
        }
        
        alertContoller.addAction(retwitterAction)
        alertContoller.addAction(quoteTwitter)
        alertContoller.addAction(cancelAction)
        
        
        controller.present(alertContoller, animated: true) {
            
        }
        
    }
}

class MTTAlertView: MTTView
{
    var firstContainerView:UIView!
    var secondContainerView:UIView!
    
    
    var retwitterButton:UIButton!
    var lineView:UIView!
    
    var quoteTwitterButton:UIButton!
    var cancelButton:UIButton!
    var delegate:MTTAlertViewDelegate?
    
    let disposeBag = DisposeBag()
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setupEvent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
    }
    
    override func setupSubview()
    {
        self.backgroundColor                   = UIColor.black.withAlphaComponent(0.45)

        secondContainerView                    = UIView()
        secondContainerView.backgroundColor    = UIColor.white
        secondContainerView.layer.cornerRadius = 15
        secondContainerView.clipsToBounds      = true
        self.addSubview(secondContainerView)

        cancelButton                           = UIButton()
        cancelButton.setTitle("取消", for: UIControlState.normal)
        cancelButton.setTitleColor(kMainBlueColor(), for: UIControlState.normal)
        cancelButton.setTitleColor(kMainGrayColor(), for: UIControlState.highlighted)
        cancelButton.titleLabel?.font          = UIFont.systemFont(ofSize: 18)
        secondContainerView.addSubview(cancelButton)

        firstContainerView                     = UIView()
        firstContainerView.backgroundColor     = UIColor.white
        firstContainerView.layer.cornerRadius  = 15
        firstContainerView.clipsToBounds       = true
        self.addSubview(firstContainerView)

        retwitterButton                        = UIButton()
        retwitterButton.setTitle("转推", for: UIControlState.normal)
        retwitterButton.backgroundColor        = UIColor.white
        retwitterButton.setTitleColor(kMainBlueColor(), for: UIControlState.normal)
        retwitterButton.setTitleColor(kMainGrayColor(), for: UIControlState.highlighted)
        retwitterButton.titleLabel?.font       = UIFont.systemFont(ofSize: 18)
        firstContainerView.addSubview(retwitterButton)

        lineView                               = UIView()
        lineView.backgroundColor               = kMainGrayColor()
        firstContainerView.addSubview(lineView)

        quoteTwitterButton                     = UIButton()
        quoteTwitterButton.setTitle("引用推文", for: UIControlState.normal)
        quoteTwitterButton.setTitleColor(kMainBlueColor(), for: UIControlState.normal)
        quoteTwitterButton.setTitleColor(kMainGrayColor(), for: UIControlState.highlighted)
        quoteTwitterButton.titleLabel?.font    = UIFont.systemFont(ofSize: 18)
        firstContainerView.addSubview(quoteTwitterButton)
        
        
    }
    
    override func layoutSubview()
    {
        secondContainerView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom).offset(-60)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(50)
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(self.secondContainerView)
        }
        
        firstContainerView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(100)
            make.bottom.equalTo(self.secondContainerView.snp.top).offset(-10)
        }
        
        retwitterButton.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.firstContainerView)
            make.height.equalTo(49.5)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.firstContainerView)
            make.top.equalTo(self.retwitterButton.snp.bottom).offset(0)
            make.height.equalTo(0.5)
        }
        
        quoteTwitterButton.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.firstContainerView)
            make.top.equalTo(self.lineView.snp.bottom).offset(0)
        }
    }
    
    private func setupEvent() -> Void
    {
        retwitterButton.rx.tap
            .subscribe(onNext:{ [unowned self] in
                self.delegate?.tappedRetwitter(alertView: self, retwitterButton: self.retwitterButton)})
            .disposed(by: disposeBag)
        
        quoteTwitterButton.rx.tap
            .subscribe(onNext:{[unowned self] in
                self.delegate?.tappedQuoteTwitter(alertView: self, quoteTwitterButton: self.quoteTwitterButton)})
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .subscribe(onNext:{[unowned self] in
                self.delegate?.tappedCancel(alertView: self, cancelButton: self.cancelButton)})
            .disposed(by: disposeBag)
        
        self.rx
            .tapGesture()
            .when(UIGestureRecognizerState.recognized)
            .subscribe(onNext:{ _ in
                self.isHidden = true})
            .disposed(by: disposeBag)
        
    }
}
