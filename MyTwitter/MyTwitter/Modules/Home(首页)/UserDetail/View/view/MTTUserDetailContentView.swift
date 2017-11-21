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
    
    
    let twitterTextVC:MTTTwitterTextViewController = MTTTwitterTextViewController()
    let twitterTextAndReplyVC:MTTTwitterTextAndReplyViewController = MTTTwitterTextAndReplyViewController()
    let mediaVC:MTTMediaViewController = MTTMediaViewController()
    let likeVC:MTTLikeViewController = MTTLikeViewController()
    
    
    
    
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    override func setupSubview()
    {
        userDetailContentScrollView = UIScrollView(frame: self.bounds)
        userDetailContentScrollView.isScrollEnabled = true
        userDetailContentScrollView.isPagingEnabled = true
        userDetailContentScrollView.delegate = self
        userDetailContentScrollView.contentSize = CGSize(width: 4 * kScreenWidth, height: self.frame.size.height)
        userDetailContentScrollView.backgroundColor = kMainRandomColor()
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
}

extension MTTUserDetailContentView:UIScrollViewDelegate
{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        print(scrollView.contentOffset.x)
        let page = Int(scrollView.contentOffset.x / kScreenWidth)
        
        self.delegate?.userDetailContentScrollToPage(page: page)
        
    }
}

