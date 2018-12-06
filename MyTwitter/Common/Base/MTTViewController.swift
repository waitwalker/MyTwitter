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
        NotificationCenter.default.addObserver(self, 
                                               selector: #selector(dayNotificationAction(notify:)), 
                                               name: NSNotification.Name(rawValue: kDayNotificationString),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, 
                                               selector: #selector(nightNotificationAction(notify:)), 
                                               name: NSNotification.Name(rawValue: kNightNotificationString), 
                                               object: nil)
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

extension UIViewController
{
//    open override static func initialize()
//    {
//        struct Static {
//            static var token = NSUUID().uuidString
//        }
//        
//        if self != UIViewController.self
//        {
//            return
//        }
//        
//        DispatchQueue.once(Static.token) {
//            
//            let originalSelector = #selector(viewDidLoad)
//            
//            let swizzledSelector = #selector(swizzled_viewDidLoad)
//            
//            MTTUserStatisticsManager.swizzledSelector(theClass: self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
//            
//        }
//    }
//    
//    func swizzled_viewDidLoad() -> Void
//    {
//        // 埋点插入
//        userStatistics()
//        swizzled_viewDidLoad()
//    }
//    
//    func userStatistics() -> Void
//    {
//        let className = NSStringFromClass(UIViewController.self)
//        print(self.navigationItem.title as Any)
//        print(className)
//    }
}
