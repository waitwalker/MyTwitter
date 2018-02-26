//
//  MTTTabMdeiaView.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2018/2/24.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

/***********
 媒体
 ***********/

import UIKit

class MTTTabMediaView: MTTTabBaseView {

    override init(frame: CGRect) 
    {
        super.init(frame: frame)
        self.backgroundColor = kMainRandomColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
