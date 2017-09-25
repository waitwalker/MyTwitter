//
//  MTTView.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/8.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTView: UIView
{
    
    override init(frame: CGRect) 
    {
        super.init(frame: frame)
        self.setupSubview()
        self.layoutSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() 
    {
        super.layoutSubviews()
        self.layoutSubview()
    }
    
    func setupSubview() -> Void 
    {
        
    }
    
    func layoutSubview() -> Void 
    {
        
    }
    
    

}
