//
//  MTTUserDetailContentView.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/11/21.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTUserDetailContentView: MTTView
{
    var userDetailContentScrollView:UIScrollView!
    var delegate:MTTUserDetailContentViewDelegate?
    
    
    let twitterTextVC:MTTTwitterTextViewController                 = MTTTwitterTextViewController()
    let twitterTextAndReplyVC:MTTTwitterTextAndReplyViewController = MTTTwitterTextAndReplyViewController()
    let mediaVC:MTTMediaViewController                             = MTTMediaViewController()
    let likeVC:MTTLikeViewController                               = MTTLikeViewController()
    
    
    
    
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        setupNotification()
    }
    
    override func setupSubview()
    {
        userDetailContentScrollView                 = UIScrollView(frame: self.bounds)
        userDetailContentScrollView.isScrollEnabled = true
        userDetailContentScrollView.isPagingEnabled = true
        userDetailContentScrollView.delegate        = self
        userDetailContentScrollView.contentSize     = CGSize(width: 4 * kScreenWidth, height: 0)
        self.addSubview(userDetailContentScrollView)
        
        for index in 0...3 {
            
            var frame = userDetailContentScrollView.frame
            frame.origin.x = frame.size.width * CGFloat(index)
            
            if index == 0
            {
                twitterTextVC.view.frame = frame
                userDetailContentScrollView.addSubview(twitterTextVC.view)
            }
            
            if index == 1
            {
                twitterTextAndReplyVC.view.frame = frame
                userDetailContentScrollView.addSubview(twitterTextAndReplyVC.view)
            }
            
            if index == 2
            {
                mediaVC.view.frame = frame
                userDetailContentScrollView.addSubview(mediaVC.view)
            }
            
            if index == 3
            {
                likeVC.view.frame = frame
                userDetailContentScrollView.addSubview(likeVC.view)
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNotification() -> Void
    {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(kUserDetailTopButtonTappedIndex(notify:)), 
                                               name: NSNotification.Name(rawValue: kUserDetailTopButtonTappedIndexNotification),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, 
                                               selector: #selector(userDetailTableViewContentOffset(notify:)),
                                               name: NSNotification.Name(rawValue: kUserDetailTableViewContentOffsetYNotification),
                                               object: nil)
    }
    
    @objc func kUserDetailTopButtonTappedIndex(notify:Notification) -> Void
    {
        let userInfo = notify.object as! NSDictionary

        let index    = userInfo.object(forKey: "index") as! Int

        let subview  = userDetailContentScrollView.subviews[index];
        userDetailContentScrollView.contentOffset = CGPoint(x: subview.frame.origin.x, y: subview.frame.origin.y);
    }
    
    @objc func userDetailTableViewContentOffset(notify:Notification) -> Void
    {
        let userInfo = notify.object as! NSDictionary
        
        let offsetY = userInfo.object(forKey: "contentOffsetY") as! CGFloat
        
        print(offsetY)
        
//        userDetailContentScrollView.frame.origin.y = 450 - offsetY;
//        userDetailContentView.frame.origin.y = 500 - offsetY;
        
        userDetailContentScrollView.frame.size.height = kScreenHeight - 300 + offsetY;
        twitterTextVC.view.frame.size.height          = userDetailContentScrollView.frame.size.height
        twitterTextAndReplyVC.view.frame.size.height  = userDetailContentScrollView.frame.size.height
        mediaVC.view.frame.size.height                = userDetailContentScrollView.frame.size.height
        likeVC.view.frame.size.height                 = userDetailContentScrollView.frame.size.height
        userDetailContentScrollView.contentSize       = CGSize(width: 4 * kScreenWidth, height: 0)
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
}

extension MTTUserDetailContentView:UIScrollViewDelegate
{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        let page = Int(scrollView.contentOffset.x / kScreenWidth)
        self.delegate?.userDetailContentScrollToPage(page: page)
    }
}

