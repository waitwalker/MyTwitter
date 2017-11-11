//
//  MTTImageExtension.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/11/11.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

extension UIImage
{
    class func imageNamed(name:String) -> UIImage 
    {
        let image = UIImage(named: name)
        return image!
    }
}

