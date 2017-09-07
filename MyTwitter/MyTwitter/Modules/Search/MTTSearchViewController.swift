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
    var sectionTitlesSet:NSMutableSet?
    var sectionTitlesArray:[String] = []
    var allCodes:[MTTPhoneAreaCode] = []
    var codesArray:[MTTPhoneAreaCode] = []
    
    func setupDataSource() -> Void 
    {
        sectionTitlesSet = NSMutableSet()
        
        let codePathURL = Bundle.main.resourceURL?.appendingPathComponent("evt_phone_area_code_zh.txt")
        
        var codeSource:String = String.init()
        
        do {
            let codeSources = try String.init(contentsOf: codePathURL!, encoding: String.Encoding.utf8)
            codeSource = codeSources
        } catch
        {
            codeSource = ""
        }
        
        let linesArray = codeSource.components(separatedBy: NSCharacterSet.newlines)
        
        for line in linesArray
        {
            let parts =  line.components(separatedBy: "=")
            let code = MTTPhoneAreaCode()
            if parts.count == 3
            {
                code.areaName = parts[0]
                code.areaAlphaName = parts[1]
                code.areaCodeName = parts[2]
            }
            
            let stringIndex = code.areaAlphaName?.index((code.areaAlphaName?.startIndex)!, offsetBy: 1)
            code.areaFirstChar = code.areaAlphaName?.substring(to: stringIndex!)
            sectionTitlesSet?.add(code.areaFirstChar as Any)
            allCodes.append(code)
        }
        
        codesArray = allCodes.sorted { (obj1, obj2) -> Bool in
            obj1.areaFirstChar! < obj2.areaFirstChar!
        }
        
        for code in codesArray
        {
            print(code.areaFirstChar as Any)
            sectionTitlesSet?.add(code.areaFirstChar as Any)
        }
        
        var strings:[String] = []
        
        for char in sectionTitlesSet!
        {
            strings.append(char as! String)
        }
        
        sectionTitlesArray = strings.sorted { (obj1, obj2) -> Bool in
            obj1 < obj2
        }
        print(sectionTitlesArray)
    }
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        self.setupDataSource()
    }
    
    func setupSubview() -> Void 
    {
        
    }

    

}
