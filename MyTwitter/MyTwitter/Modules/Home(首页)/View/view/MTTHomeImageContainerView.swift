//
//  MTTHomeImageContainerView.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/9/25.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTHomeImageContainerView: MTTView
{
    
    var homeImagesArray: [String]?
    {
        didSet
        {
            print(homeImagesArray?.first as Any)
            
            self.setupSubview()
            
            for string in homeImagesArray!
            {
                print(string)
            }
            
        }
    }
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupSubview()
    {
        let margin:CGFloat = 5.0
        let imageViewWidth = (kScreenWidth - 80 - 10 - 5) / 2
        let imageViewHeight:CGFloat = (150.0 - 5.0) / 2
        
        
        switch homeImagesArray?.count {
        case 1?:
            
            let imageView = UIImageView()
            imageView.isUserInteractionEnabled = true
            imageView.backgroundColor = kMainRandomColor()
            imageView.image = UIImage.init(named: (self.homeImagesArray?.first)!)
            self.addSubview(imageView)
            imageView.frame = CGRect(x: 0, y: 0, width: imageViewWidth, height: 150)
            break
        case 2?:
            
            for i in 0...1
            {
                let imageView = UIImageView()
                imageView.isUserInteractionEnabled = true
                imageView.backgroundColor = kMainRandomColor()
                imageView.image = UIImage.init(named: self.homeImagesArray![i])
                self.addSubview(imageView)
                
                imageView.frame = CGRect(x: (margin + imageViewWidth) * CGFloat(i), y: 0, width: imageViewWidth, height: 150)
            }
            
            break
        case 3?:
            for i in 0...2
            {
                let imageView = UIImageView()
                imageView.isUserInteractionEnabled = true
                imageView.backgroundColor = kMainRandomColor()
                imageView.image = UIImage.init(named: self.homeImagesArray![i])
                self.addSubview(imageView)
                
                if i == 0
                {
                    imageView.frame = CGRect(x: (margin + imageViewWidth) * CGFloat(i), y: 0, width: imageViewWidth, height: 150)
                } else if i == 1
                {
                    imageView.frame = CGRect(x: (margin + imageViewWidth) * CGFloat(i), y: (margin + imageViewHeight) * CGFloat(i - 1), width: imageViewWidth, height: imageViewHeight)
                } else 
                {
                    imageView.frame = CGRect(x: (margin + imageViewWidth) * CGFloat(i - 1), y: (margin + imageViewHeight) * CGFloat(i - 1), width: imageViewWidth, height: imageViewHeight)
                }
                
            }
            break
        case 4?:
            for i in 0...3
            {
                let imageView = UIImageView()
                imageView.isUserInteractionEnabled = true
                imageView.backgroundColor = kMainRandomColor()
                imageView.image = UIImage.init(named: self.homeImagesArray![i])
                self.addSubview(imageView)
                
                if i < 2
                {
                    imageView.frame = CGRect(x: (margin + imageViewWidth) * CGFloat(i), y: 0, width: imageViewWidth, height: imageViewHeight)
                } else
                {
                    imageView.frame = CGRect(x: (margin + imageViewWidth) * CGFloat(i - 2), y: (margin + imageViewHeight), width: imageViewWidth, height: imageViewHeight)
                }
            }
            
            break
        default:
            break
        }
    }
    
    override func layoutSubview()
    {
        
    }
    
    

}
