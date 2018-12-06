//
//  MTTNavigationController.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/5.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTNavigationController: UINavigationController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // 设置导航栏样式
        navigationBar.barTintColor = UIColor.white
        
        // 设置标题样式
        let bar = UINavigationBar.appearance()
        bar.titleTextAttributes = [
            NSFontAttributeName:UIFont.systemFont(ofSize: 20)
        ]
        
        // 设置返回按钮样式
        navigationBar.tintColor = kMainBlueColor()
        
        let barItem = UIBarButtonItem.appearance()
        barItem.setTitleTextAttributes([NSForegroundColorAttributeName:kMainBlueColor()], for: UIControlState.normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
