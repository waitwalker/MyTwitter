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
    var photoIconImageView:UIImageView?
    var photoTitleLabel:UILabel?
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
        photoBackgroundView = UIView()
        photoBackgroundView?.backgroundColor = kMainWhiteColor()
        self.contentView.addSubview(photoBackgroundView!)
        
        //photoBackgroundImageView
        photoBackgroundImageView = UIImageView()
        photoBackgroundImageView?.isUserInteractionEnabled = true
        photoBackgroundImageView?.backgroundColor = kMainRandomColor()
        photoBackgroundView?.addSubview(photoBackgroundImageView!)
    }
    
    private func layoutSubview() -> Void 
    {
        //photoBackgroundView
        photoBackgroundView?.snp.makeConstraints({ (make) in
            make.top.left.bottom.right.equalTo(self.contentView)
        })
        
        //photoBackgroundImageView
        photoBackgroundImageView?.snp.makeConstraints({ (make) in
            make.left.top.equalTo(2)
            make.bottom.right.equalTo(-2)
        })
    }
    
    
    required init?(coder aDecoder: NSCoder) 
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
