//
//  MTTViewController.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/5.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTViewController: UIViewController {

    var userInfo:[String:String]?
    
    let sharedInstance = MTTSingletonManager.sharedInstance
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        self.view.backgroundColor = kMainWhiteColor()
        
        addNotification()
    }
    
    func addNotification() -> Void 
    {
        NotificationCenter.default.addObserver(self, selector: #selector(dayNotificationAction(notify:)), name: NSNotification.Name(rawValue: kDayNotificationString), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(nightNotificationAction(notify:)), name: NSNotification.Name(rawValue: kNightNotificationString), object: nil)
    }
    
    @objc func dayNotificationAction(notify:Notification) -> Void 
    {
        self.view.backgroundColor = kMainWhiteColor()
    }
    
    @objc func nightNotificationAction(notify:Notification) -> Void 
    {
        self.view.backgroundColor = kMainGreenColor()
    }
    
    private func removeNotification() -> Void 
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    deinit 
    {
        removeNotification()
    }

    override func didReceiveMemoryWarning() 
    {
        super.didReceiveMemoryWarning()
    }
    
    
    func addKeyValue() -> Void 
    {
        
    }
    

}
