//
//  MTTButtonExtension.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/30.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

extension UIButton
{
    func setImageWithPosition(postion:MTTButtonImagePostion,spacing:CGFloat) -> Void 
    {
        self.setTitle(self.currentTitle, for: UIControlState.normal)
        self.setImage(self.currentImage, for: UIControlState.normal)
        
        let imageWidth = self.imageView?.image?.size.width
        let imageHeight = self.imageView?.image?.size.height
        
        let titleLabelTitle:NSString = (self.titleLabel?.text! as NSString?)!
        
        let labelWidth = titleLabelTitle.size(attributes: [NSFontAttributeName : self.titleLabel?.font as Any]).width
        let labelHeight = titleLabelTitle.size(attributes: [NSFontAttributeName : self.titleLabel?.font as Any]).height
        
        let imageOffsetX = (imageWidth! + labelWidth) / 2 - imageWidth! / 2 //image中心移动的x距离
        let imageOffsetY = imageHeight! / 2 + spacing / 2 //image中心移动的y距离
        let labelOffsetX = (imageWidth! + labelWidth / 2) - (imageWidth! + labelWidth) / 2 //label中心移动的x距离
        let labelOffsetY = labelHeight / 2 + spacing / 2 //label中心移动的y距离
        
        let tempWidth = max(labelWidth, labelWidth)
        let changedWidth = labelWidth + imageWidth! - tempWidth;
        let tempHeight = max(labelHeight, imageHeight!) 
        let changedHeight = labelHeight + imageHeight! + spacing - tempHeight 
        
        switch postion 
        {
        case MTTButtonImagePostion.Left:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break
        case MTTButtonImagePostion.Right:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing/2, 0, -(labelWidth + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth! + spacing/2), 0, imageWidth! + spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break
        case MTTButtonImagePostion.Top:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -changedWidth/2, changedHeight-imageOffsetY, -changedWidth/2);
            break
        case MTTButtonImagePostion.Bottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(changedHeight-imageOffsetY, -changedWidth/2, imageOffsetY, -changedWidth/2);
            break
            
        }
    }
}

