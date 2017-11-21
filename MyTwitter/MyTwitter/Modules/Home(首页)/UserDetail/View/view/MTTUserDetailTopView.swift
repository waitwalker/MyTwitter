//
//  MTTUserDetailTopView.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/11/21.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTUserDetailTopView: MTTView
{
    
    var buttonsArray:[UIButton] = []
    var buttonBottomLineView:UIView!
    var topScrollView:UIScrollView!
    
    let titlesArray:[String] = ["推文","推文和回复","媒体","喜欢"]
    
    
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        setupNotification()
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
    }
    
    override func setupSubview()
    {
        super.setupSubview()
        
        topScrollView = UIScrollView()
        topScrollView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 80)
        topScrollView.contentSize = CGSize(width: kScreenWidth, height: 0)
        topScrollView.backgroundColor = UIColor.orange
        topScrollView.isPagingEnabled = true
        topScrollView.isScrollEnabled = true
        self.addSubview(topScrollView)
        
        buttonBottomLineView = UIView()
        buttonBottomLineView.backgroundColor = kMainBlueColor()
        self.addSubview(buttonBottomLineView)
        
        
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
                button.frame = CGRect(x: 0, y: 25, width: kScreenWidth / 4, height: 30)
                break
            case 1:
                button.frame = CGRect(x: kScreenWidth / 4, y: 25, width: kScreenWidth / 3, height: 30)
                break
            case 2:
                button.frame = CGRect(x: kScreenWidth / 4 + kScreenWidth / 3, y: 25, width: kScreenWidth / 6, height: 30)
                break
            case 3:
                button.frame = CGRect(x: kScreenWidth / 4 + kScreenWidth / 3 + kScreenWidth / 6, y: 25, width: kScreenWidth / 4, height: 30)
                break
            default:
                break
            }
            
            buttonsArray.append(button)
            
            topScrollView.addSubview(button)
        }
        
        
    }
    
    override func layoutSubview()
    {
        super.layoutSubview()
        
        buttonBottomLineView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.height.equalTo(2)
            make.bottom.equalTo(0)
            make.width.equalTo(80)
        }
    }
    
    
    @objc func titleButtonAction(button:UIButton) -> Void
    {
        button.isSelected = true;
        var rect = buttonBottomLineView.frame
        rect.origin.x = button.frame.origin.x
        rect.size.width = button.frame.size.width
        buttonBottomLineView.frame = rect
        
        for (index,button) in buttonsArray.enumerated() {
            let tmpButton = buttonsArray[index]
            if tmpButton.tag != button.tag
            {
                tmpButton.isSelected = false
            }
        }
    }
    
    func setupNotification() -> Void
    {
        NotificationCenter.default.addObserver(self, selector: #selector(userDetailContentScrollToPage(notify:)), name: NSNotification.Name(rawValue: kUserDetailContentScrollToPageNotification), object: nil)
    }
    
    @objc func userDetailContentScrollToPage(notify:Notification) -> Void
    {
        let userInfo = notify.object as! NSDictionary
        
        print(userInfo.object(forKey: "page"))
        
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    

}
