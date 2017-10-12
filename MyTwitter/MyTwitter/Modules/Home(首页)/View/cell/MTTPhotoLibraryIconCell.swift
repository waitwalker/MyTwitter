//
//  MTTPhotoLibraryIconCell.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/10/12.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTPhotoLibraryIconCell: MTTCollectionViewCell 
{
    var photoBackgroundView:UIView?
    var photoBackgroundImageView:UIImageView?
    var photoIconContainerView:UIView?
    
    var photoIconImageView:UIImageView?
    var photoTitleLabel:UILabel?
    
    
    override init(frame: CGRect) 
    {
        super.init(frame: frame)
        setupSubview()
        layoutSubview()
    }
    
    
    private func setupSubview() -> Void 
    {
        //photoBackgroundView
        photoBackgroundView = UIView()
        photoBackgroundView?.backgroundColor = kMainLightGrayColor()
        self.contentView.addSubview(photoBackgroundView!)
        
        //photoBackgroundImageView
        photoBackgroundImageView = UIImageView()
        photoBackgroundImageView?.isUserInteractionEnabled = true
        photoBackgroundImageView?.backgroundColor = kMainWhiteColor()
        photoBackgroundView?.addSubview(photoBackgroundImageView!)
        
        //photoIconContainerView
        photoIconContainerView = UIView()
        photoBackgroundView?.addSubview(photoIconContainerView!)
        
        //photoIconImageView
        photoIconImageView = UIImageView()
        photoIconImageView?.isUserInteractionEnabled = true
        photoIconContainerView?.addSubview(photoIconImageView!)
        
        //photoTitleLabel
        photoTitleLabel = UILabel()
        photoTitleLabel?.textColor = kMainBlueColor()
        photoTitleLabel?.text = "照片"
        photoTitleLabel?.textAlignment = NSTextAlignment.center
        photoTitleLabel?.font = UIFont.systemFont(ofSize: 14)
        photoIconContainerView?.addSubview(photoTitleLabel!)
        
        
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
        
        //photoIconContainerView
        photoIconContainerView?.snp.makeConstraints({ (make) in
            make.height.equalTo(50)
            make.width.equalTo(30)
            make.center.equalTo(self.photoBackgroundView!)
        })
        
        //photoIconImageView
        photoIconImageView?.snp.makeConstraints({ (make) in
            make.top.left.equalTo(0)
            make.height.equalTo(25)
            make.width.equalTo(30)
        })
        
        //photoTitleLabel
        photoTitleLabel?.snp.makeConstraints({ (make) in
            make.left.bottom.equalTo(0)
            make.top.equalTo((self.photoIconImageView?.snp.bottom)!).offset(0)
            make.width.equalTo(30)
        })
    }
    
    
    required init?(coder aDecoder: NSCoder) 
    {
        fatalError("init(coder:) has not been implemented")
    }
}
