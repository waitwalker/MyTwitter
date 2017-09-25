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
    
    var homeImagesArray: [String] = []
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        print(homeImagesArray.first as Any)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupSubview()
    {
        print(homeImagesArray.count)
    }
    
    override func layoutSubview()
    {
        
    }
    
    

}
