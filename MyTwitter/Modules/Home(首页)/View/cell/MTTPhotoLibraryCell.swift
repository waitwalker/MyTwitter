//
//  MTTPhotoLibraryCell.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/10/11.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTPhotoLibraryCell: MTTCollectionViewCell 
{
    var photoBackgroundView:UIView?
    var photoBackgroundImageView:UIImageView?
    
    var photoSelectedCoverView:UIView?
    var photoSelectedIconImageView:UIImageView?
    var photoSelectedEditImageView:UIImageView?
    
    
    override init(frame: CGRect) 
    {
        super.init(frame: frame)
        setupSubview()
        layoutSubview()
    }
    
    
    private func setupSubview() -> Void 
    {
        //photoBackgroundView
        photoBackgroundView                                  = UIView()
        photoBackgroundView?.backgroundColor                 = kMainWhiteColor()
        self.contentView.addSubview(photoBackgroundView!)

        //photoBackgroundImageView
        photoBackgroundImageView                             = UIImageView()
        photoBackgroundImageView?.isUserInteractionEnabled   = true
        photoBackgroundImageView?.backgroundColor            = kMainWhiteColor()
        photoBackgroundView?.addSubview(photoBackgroundImageView!)

        //photoSelectedCoverView
        photoSelectedCoverView                               = UIView()
        let color                                            = UIColor.black
        photoSelectedCoverView?.backgroundColor              = color.withAlphaComponent(0.3)
        photoBackgroundImageView?.addSubview(photoSelectedCoverView!)

        //photoSelectedIconImageView
        photoSelectedIconImageView                           = UIImageView()
        photoSelectedIconImageView?.image                    = UIImage(named: "twitter_check_large")
        photoSelectedIconImageView?.isUserInteractionEnabled = true
        photoSelectedCoverView?.addSubview(photoSelectedIconImageView!)

        //photoSelectedEditImageView
        photoSelectedEditImageView                           = UIImageView()
        photoSelectedEditImageView?.image                    = UIImage(named: "twitter_edit_large")
        photoSelectedEditImageView?.isUserInteractionEnabled = true
        photoSelectedCoverView?.addSubview(photoSelectedEditImageView!)
        
        
    }
    
    private func layoutSubview() -> Void 
    {
        //photoBackgroundView
        photoBackgroundView?.snp.makeConstraints({ (make) in
            make.top.left.bottom.right.equalTo(self.contentView)
        })
        
        //photoBackgroundImageView
        photoBackgroundImageView?.snp.makeConstraints({ (make) in
            make.left.top.equalTo(1)
            make.bottom.right.equalTo(-1)
        })
        
        //photoSelectedCoverView
        photoSelectedCoverView?.snp.makeConstraints({ (make) in
            make.left.right.top.bottom.equalTo(self.photoBackgroundImageView!)
        })
        
        //photoSelectedIconImageView
        photoSelectedIconImageView?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(30)
            make.center.equalTo(self.photoBackgroundImageView!)
        })
        
        //photoSelectedEditImageView
        photoSelectedEditImageView?.snp.makeConstraints({ (make) in
            make.right.equalTo((self.photoBackgroundImageView?.snp.right)!).offset(-10)
            make.bottom.equalTo((self.photoBackgroundImageView?.snp.bottom)!).offset(-10)
            make.height.width.equalTo(16)
        })
    }
    
    
    required init?(coder aDecoder: NSCoder) 
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class MTTPhotosCell: MTTCollectionViewCell
{
    var photoBackgroundImageView:UIImageView!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setupSubview()
        layoutSubview()
    }
    
    
    private func setupSubview() -> Void
    {
        //photoBackgroundImageView
        photoBackgroundImageView = UIImageView()
        photoBackgroundImageView.isUserInteractionEnabled = true
        photoBackgroundImageView.backgroundColor = kMainWhiteColor()
        self.contentView.addSubview(photoBackgroundImageView!)
    }
    
    private func layoutSubview() -> Void
    {
        //photoBackgroundImageView
        photoBackgroundImageView?.snp.makeConstraints({ (make) in
            make.left.top.equalTo(0)
            make.bottom.right.equalTo(0)
        })
    }
    
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
