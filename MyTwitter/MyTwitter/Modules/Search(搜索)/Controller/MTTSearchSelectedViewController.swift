//
//  MTTSearchSelectedViewController.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/10/13.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTSearchSelectedViewController: MTTViewController {

    // MARK: - 工厂模式  根据选中不同的cell 跳转到不同的控制器
    class func initWithSearchSelectedType(type:MTTSearchCellType) -> MTTSearchSelectedViewController
    {
        var searchSelectedVC:MTTSearchSelectedViewController?
        switch type {
        case MTTSearchCellType.lableCellType:
            searchSelectedVC = MTTSearchLabelViewController()
            return searchSelectedVC!
        default:
            return MTTSearchSelectedViewController()
        }
        
    }
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
