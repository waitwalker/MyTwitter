//
//  MTTLocationViewController.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/10/9.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTLocationViewController: MTTViewController
{

    var locationTableView:UITableView?
    var places:[String]?
    var latitude:Double?
    var longitude:Double?
    
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupSubview()
        layoutSubview()

    }
    
    private func setupSubview() -> Void
    {
        locationTableView = UITableView()
//        locationTableView?.delegate = self
//        locationTableView?.dataSource = self
    }
    
    private func layoutSubview() -> Void
    {
        
    }
    
    

}
