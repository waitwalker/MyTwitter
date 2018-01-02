//
//  MTTLargeImagePreviewManager.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/26.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTLargeImagePreviewManager: NSObject 
{
    var imageBackgroundView:UIView?
    var imageScrollView:UIScrollView?
    
    
    var imageArray:[String]?
    {
        didSet
        {
            self.setupSubView()
        }
    }
    
    private func setupSubView() -> Void 
    {
        let appDelegate                                = UIApplication.shared.delegate
        appDelegate?.window??.isUserInteractionEnabled = true
        imageBackgroundView                            = UIView()
        imageBackgroundView?.frame                     = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        appDelegate?.window??.addSubview(imageBackgroundView!)

        imageScrollView                                = UIScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        imageScrollView?.isUserInteractionEnabled      = true
        imageScrollView?.contentSize                   = CGSize(width: kScreenWidth * CGFloat((imageArray?.count)!), height: 0)
        imageScrollView?.isPagingEnabled               = true
        imageBackgroundView?.addSubview(imageScrollView!)
        
        for i in 0...(self.imageArray?.count)! 
        {
            print("次数:",i)
            
            let imageView                      = UIImageView()
            imageView.isUserInteractionEnabled = true
            imageView.frame                    = CGRect(x: CGFloat(i) * kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight)
            imageView.backgroundColor          = kMainRandomColor()
            imageScrollView?.addSubview(imageView)
            
        }
        
        for subview in (imageScrollView?.subviews)! 
        {
            subview.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapGesAction(tap:)))
            subview.addGestureRecognizer(tap)
        }
        
        let sharedInstance             = MTTSingletonManager.sharedInstance
        imageScrollView?.contentOffset = CGPoint(x: kScreenWidth * CGFloat(sharedInstance.tappedImageIndex), y: (imageScrollView?.frame.origin.y)!)
        print(imageScrollView?.subviews as Any)
    }
    
    func layoutSubview() -> Void 
    {
        
    }
    
    @objc func tapGesAction(tap:UITapGestureRecognizer) -> Void 
    {
        print("点击了")
    }
    
    deinit {
        
    }
}
