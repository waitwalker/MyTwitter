//
//  MTTAvatarImagesView.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/10/19.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTAvatarImagesView: MTTView 
{
    
    let imageViewWidthHeight:CGFloat = 40
    let margin:CGFloat = 5
    
    
    var avatarImageViews:[String]?
    {
        didSet 
        {
            if avatarImageViews != nil
            {
                self.setupSubview()
            }
        }
    }
    
    
    override init(frame: CGRect) 
    {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) 
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupSubview() 
    {
        print(avatarImageViews?.count as Any)
        
        if avatarImageViews != nil
        {
            
            for index in Int(0)...(avatarImageViews?.count)! - 1
            {
                let imageView = UIImageView()
                imageView.isUserInteractionEnabled = true
                imageView.image = UIImage(named: String(format: "%@", avatarImageViews![index]))
                imageView.layer.cornerRadius = 20
                imageView.clipsToBounds = true
                imageView.frame = CGRect(x: CGFloat(index) * (imageViewWidthHeight + margin), y: 0, width: imageViewWidthHeight, height: imageViewWidthHeight)
                self.addSubview(imageView)
                
            }
        }
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
