//
//  MTTLanuchAnimation.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/10/22.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTLanuchAnimation: NSObject
{
    class func launchAppWithSuperView(superView:UIView) -> Void
    {
        let logoLayer = CALayer()
        logoLayer.bounds = CGRect(x: 0, y: 0, width: 136, height: 111)
        logoLayer.position = superView.center
        logoLayer.contents = UIImage(named: "LaunchStoryboardBackgroundImage")?.cgImage
        superView.layer.mask = logoLayer
        
        let shelterView = UIView(frame: superView.frame)
        shelterView.backgroundColor = UIColor.white
        superView.addSubview(shelterView)
        
        let logonAnimation = CAKeyframeAnimation(keyPath: "bounds")
        logonAnimation.beginTime = CACurrentMediaTime() + 1
        logonAnimation.duration = 1
        logonAnimation.keyTimes = [0,0.4,1]
        logonAnimation.values = [NSValue(cgRect: CGRect(x: 0, y: 0, width: 136, height: 111)),NSValue(cgRect: CGRect(x: 0, y: 0, width: 109, height: 89)),NSValue(cgRect: CGRect(x: 0, y: 0, width: 4500, height: 4500))]
        logonAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)]
        logonAnimation.isRemovedOnCompletion = false
        logonAnimation.fillMode = kCAFillModeForwards
        logoLayer.add(logonAnimation, forKey: "zoomAnimation")
        
        let mainViewAnimation = CAKeyframeAnimation(keyPath: "transform")
        mainViewAnimation.beginTime = CACurrentMediaTime() + 1.1
        mainViewAnimation.duration = 0.5
        mainViewAnimation.keyTimes = [0,0.5,1]
        mainViewAnimation.values = [NSValue(caTransform3D: CATransform3DIdentity),NSValue(caTransform3D: CATransform3DScale(CATransform3DIdentity, 1.1, 1.1, 1)),NSValue(caTransform3D: CATransform3DIdentity)]
        superView.layer.add(mainViewAnimation, forKey: "transformAnimation")
        superView.layer.transform = CATransform3DIdentity
        
        UIView.animate(withDuration: 0.5, delay: 1.0, options: UIViewAnimationOptions.curveLinear, animations: {
            shelterView.alpha = 0
        }) { (completed) in
            shelterView.removeFromSuperview()
            superView.layer.mask = nil
        }
    }
}
