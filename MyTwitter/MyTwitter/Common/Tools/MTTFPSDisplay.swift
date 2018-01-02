//
//  MTTFPSDisplay.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/25.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTFPSDisplay: NSObject 
{
    var FPSLable:UILabel?
    var displayLink:CADisplayLink?
    var lastTimeInterval:TimeInterval = 0
    var count:NSInteger = 0
    
    
    static let shareInstance = MTTFPSDisplay()
    
    private override init() 
    {
        super.init()
        self.setupSubView()
        self.layoutSubview()
        self.setupCADisplayLink()
    }
    
    private func setupSubView() -> Void 
    {
        FPSLable                     = UILabel()
        FPSLable?.textAlignment      = NSTextAlignment.center
        FPSLable?.layer.cornerRadius = 5.0
        FPSLable?.clipsToBounds      = true
        FPSLable?.backgroundColor    = UIColor.black

        let appDelegate              = UIApplication.shared.delegate
        appDelegate?.window??.addSubview(FPSLable!)
        
    }
    
    func layoutSubview() -> Void 
    {
        FPSLable?.snp.makeConstraints({ (make) in
            make.left.equalTo(40)
            make.width.equalTo(80)
            make.top.equalTo(20)
            make.height.equalTo(30)
        })
    }
    
    private func setupCADisplayLink() -> Void 
    {
        displayLink = CADisplayLink.init(target: self, selector: #selector(displayLinkAction(link:)))
        displayLink?.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
    }
    
    @objc func displayLinkAction(link:CADisplayLink) -> Void 
    {
        if lastTimeInterval == 0 
        {
            lastTimeInterval = link.timestamp
            return;
        }
        
        count = count + 1
        
        let delta = link.timestamp - lastTimeInterval
        
        if delta > 1 
        {
            lastTimeInterval    = link.timestamp

            let deltaInt        = NSInteger(delta)

            let fps             = CGFloat(count / deltaInt)

            count               = 0

            FPSLable?.textColor = UIColor.init(hue: 0.27 * (fps / 60.0), saturation: 1, brightness: 0.9, alpha: 1.0)
            FPSLable?.text = String.init(format: "%.0f FPS", fps)
            
        }
    }
    
    deinit 
    {
        displayLink?.invalidate()
    }
}
