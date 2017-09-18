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
    }

    override func didReceiveMemoryWarning() 
    {
        super.didReceiveMemoryWarning()
    }
    
    
    func addKeyValue() -> Void 
    {
        
    }
    

}
