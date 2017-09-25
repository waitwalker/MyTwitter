//
//  MTTTabBarController.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/5.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTTabBarController: UITabBarController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupSubviewController()
        
    }
    
    func addChildViewControllers(childViewController:MTTViewController,image:UIImage,selectedImage:UIImage,tabBarTitle:String) -> Void
    {
        
        childViewController.tabBarItem.title = tabBarTitle
        childViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 2, -6, -2)
        childViewController.tabBarItem.image = image
        childViewController.tabBarItem.selectedImage = selectedImage
        childViewController.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:kMainGrayColor()], for: UIControlState.normal)
        childViewController.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:kMainBlueColor()], for: UIControlState.selected)
        let navigationController = MTTNavigationController.init(rootViewController: childViewController)
        self.addChildViewController(navigationController)
        
    }
    
    func setupSubviewController() -> Void
    {
        let homeVC = MTTHomeViewController()
        self.addChildViewControllers(childViewController: homeVC, image: UIImage.init(named: "tabbar_home_normal")!, selectedImage: UIImage.init(named: "tabbar_home_selected")!,tabBarTitle: "")
        
        let searchVC = MTTSearchViewController()
        self.addChildViewControllers(childViewController: searchVC, image: UIImage.init(named: "tabbar_search_normal")!, selectedImage: UIImage.init(named: "tabbar_search_selected")!,tabBarTitle: "")
        
        let notificationVC = MTTNotificationViewController()
        self.addChildViewControllers(childViewController: notificationVC, image: UIImage.init(named: "tabbar_notification_normal")!, selectedImage: UIImage.init(named: "tabbar_notification_selected")!,tabBarTitle: "")
        
        let privateMesssageVC = MTTPrivateMessageViewController()
        self.addChildViewControllers(childViewController: privateMesssageVC, image: UIImage.init(named: "tabbar_message_normal")!, selectedImage: UIImage.init(named: "tabbar_message_selected")!,tabBarTitle: "")
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
