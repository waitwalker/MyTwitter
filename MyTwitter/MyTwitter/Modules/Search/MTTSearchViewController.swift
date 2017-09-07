//
//  MTTSearchViewController.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/7.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTPhoneAreaCode: NSObject 
{
    var areaName:String?
    var areaAlphaName:String?
    var areaCodeName:String?
    var areaFirstChar:String?
    
}

class MTTSearchViewController: MTTViewController 
{
    
    var originalTabelView:UITableView?
    var sectionTitlesArray:NSMutableArray?
    
    lazy var codesArray:NSMutableArray = 
    {
       let tempArray = NSMutableArray()
       
       let codePathURL = Bundle.main.resourceURL?.appendingPathComponent("evt_phone_area_code_zh.txt")
       let error:NSError
       
       //var codeSource:
       
       //let codeSource = String.init(contentsOf: codePathURL!, encoding: String.Encoding.utf8)
       
//       path(forResource: "evt_phone_area_code_zh", ofType: "txt")
       
       
       return tempArray
         
    }()
    
    
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        
    }
    
    func setupSubview() -> Void 
    {
        
    }

    

}
