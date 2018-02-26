//
//  MTTUserDetailBottomContainerView.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2018/2/24.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

import UIKit

class MTTUserDetailBottomContainerView: MTTView 
{
    var buttonsArray:[UIButton] = []
    var topContainerView:UIView!
    
    var buttonBottomLineView:UIView!
    var topScrollView:UIScrollView!
    
    var bottomScrollView:UIScrollView!
    
    
    let titlesArray:[String] = ["推文","推文和回复","媒体","喜欢"]
    
    var tabConfig:Array<Any>?
    {
        didSet{
            print("重写属性:\(tabConfig?.count)")
            setupViews()
        }
    }
    
    override init(frame: CGRect) 
    {
        super.init(frame: frame)
        
    }
    
    func setupViews() -> Void 
    {
        setupTopScrollView()
        setupBottomScrollView()
    }
    
    func setupTopScrollView() -> Void 
    {
        topContainerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 50))
        self.addSubview(topContainerView)
        
        topScrollView                        = UIScrollView()
        topScrollView.frame                  = CGRect(x: 0, y: 0, width: kScreenWidth, height: 50)
        topScrollView.contentSize            = CGSize(width: kScreenWidth, height: 0)
        topScrollView.backgroundColor        = UIColor.orange
        topScrollView.isPagingEnabled        = true
        topScrollView.isScrollEnabled        = true
        topContainerView.addSubview(topScrollView)
        
        buttonBottomLineView                 = UIView(frame: CGRect(x: 0, y: 50 - 2, width: kScreenWidth / 4, height: 2))
        buttonBottomLineView.backgroundColor = kMainBlueColor()
        topContainerView.addSubview(buttonBottomLineView)
        
        
        for (index,value) in titlesArray.enumerated() {
            print(index,value)
            
            let button = UIButton()
            button.setTitle(titlesArray[index], for: UIControlState.normal)
            button.setTitleColor(kMainBlueColor(), for: UIControlState.selected)
            button.setTitleColor(kMainGrayColor(), for: UIControlState.normal)
            button.tag = index
            button.addTarget(self, action: #selector(titleButtonAction(button:)), for: UIControlEvents.touchUpInside)
            
            switch index{
            case 0:
                button.frame = CGRect(x: 0, y: 10, width: kScreenWidth / 4, height: 30)
                break
            case 1:
                button.frame = CGRect(x: kScreenWidth / 4, y: 10, width: kScreenWidth / 3, height: 30)
                break
            case 2:
                button.frame = CGRect(x: kScreenWidth / 4 + kScreenWidth / 3, y: 10, width: kScreenWidth / 6, height: 30)
                break
            case 3:
                button.frame = CGRect(x: kScreenWidth / 4 + kScreenWidth / 3 + kScreenWidth / 6, y: 10, width: kScreenWidth / 4, height: 30)
                break
            default:
                break
            }
            
            buttonsArray.append(button)
            
            topScrollView.addSubview(button)
        }
    }
    
    @objc func titleButtonAction(button:UIButton) -> Void
    {
        button.isSelected          = true;
        var rect                   = buttonBottomLineView.frame
        rect.origin.x              = button.frame.origin.x
        rect.size.width            = button.frame.size.width
        buttonBottomLineView.frame = rect
        
        let view = bottomScrollView.subviews[button.tag]
        bottomScrollView.contentOffset = CGPoint(x: view.x, y: view.y)
        
        
        for (_,btn) in buttonsArray.enumerated() {
            if btn.tag != button.tag
            {
                btn.isSelected = false
            }
        }
        
    }
    
    func setupBottomScrollView() -> Void 
    {
        bottomScrollView = UIScrollView(frame: CGRect(x: 0, y: topScrollView.frame.maxY, width: kScreenWidth, height: kScreenHeight - topScrollView.frame.maxY))
        bottomScrollView.isPagingEnabled = true
        bottomScrollView.isScrollEnabled = true
        bottomScrollView.delegate = self
        bottomScrollView.contentSize = CGSize(width: kScreenWidth * CGFloat((tabConfig?.count)!), height: 0)
        self.addSubview(bottomScrollView)
        
        for (index,value) in (tabConfig?.enumerated())! {
            print(index,value)
            
            let tabTypes = [MTTTabBaseType.MTTTabTweetType,MTTTabBaseType.MTTTabTweetAndReplyType,MTTTabBaseType.MTTTabMediaType,MTTTabBaseType.MTTTabLikeType]
            
            let tabView = MTTTabBaseView.setupTabView(tabType: tabTypes[index])
            
            tabView.frame = CGRect(x: bottomScrollView.width * CGFloat(index), y: 0, width: bottomScrollView.width, height: bottomScrollView.height)
            bottomScrollView.addSubview(tabView)
            //let className = NSClassFromString("MyTwitter.MTTTabBaseView") as! MTTTabBaseView.Type
            
           // print(className)
            
            //let tabView:MTTTabBaseView = className.init()
            //tabView.frame = CGRect(x: bottomScrollView.width * CGFloat(index), y: 0, width: bottomScrollView.width, height: bottomScrollView.height)
            //bottomScrollView.addSubview(tabView)
            print(tabView)
            
        }
        
    }
    
    func scrollToPage(page:Int) -> Void
    {
        for index in 0...((buttonsArray.count) - 1) {
            
            if index == page
            {
                let button:UIButton = buttonsArray[index];
                button.isSelected = true;
                button.setTitleColor(kMainBlueColor(), for: UIControlState.selected)
                
                UIView.animate(
                    withDuration:           0.5,
                    delay:                  0.0,
                    usingSpringWithDamping: 0.8,
                    initialSpringVelocity:  5.0,
                    options:                UIViewAnimationOptions.curveEaseOut,
                    animations: {
                        
                        var lineViewFrame               = self.buttonBottomLineView.frame
                        lineViewFrame.origin.x          = button.frame.origin.x
                        lineViewFrame.size.width        = button.frame.size.width
                        self.buttonBottomLineView.frame = lineViewFrame
                        
                        let toRight:CGFloat             = button.frame.origin.x + button.frame.size.width;
                        let toLeft:CGFloat              = button.frame.origin.x
                        let minX:CGFloat                = (self.topScrollView?.contentOffset.x)!
                        let maxX:CGFloat                = (self.topScrollView?.contentOffset.x)! + (self.topScrollView?.frame.size.width)!
                        if toRight > maxX
                        {
                            self.topScrollView?.setContentOffset(CGPoint(x: self.topScrollView!.contentOffset.x + (toRight - maxX), y: self.topScrollView!.contentOffset.y), animated: true)
                        }
                        
                        if toLeft < minX
                        {
                            self.topScrollView?.setContentOffset(CGPoint(x: (self.topScrollView?.contentOffset.x)! + (toLeft - minX), y: (self.topScrollView?.contentOffset.y)!), animated: true)
                        }
                        
                }, completion: { (finished) in
                    
                })
                
            } else
            {
                let button:UIButton = buttonsArray[index]
                button.isSelected   = false
                button.setTitleColor(kMainGrayColor(), for: UIControlState.normal)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension MTTUserDetailBottomContainerView:UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView) 
    {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.width + 0.5)
        scrollToPage(page: pageIndex)
    }
}

