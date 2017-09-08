//
//  MTTSearchViewController.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/7.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTPhoneAreaCodeModel: NSObject
{
    var areaName:String?
    var areaAlphaName:String?
    var areaCodeName:String?
    var areaFirstChar:String?
    
}

class MTTSearchViewController: MTTViewController,UITableViewDelegate,UITableViewDataSource
{
    var originalTabelView:UITableView?
    var sectionTitlesSet:NSMutableSet?
    var sectionTitlesArray:[String] = []
    var allCodes:[MTTPhoneAreaCodeModel] = []
    var codesArray:[MTTPhoneAreaCodeModel] = []
    var tableView:UITableView?
    var codeModelsArray:[[MTTPhoneAreaCodeModel]] = []
    
    let reusedCellId:String = "reusedCellId"
    
    
    // MARK: - 初始化数据
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
            let code = MTTPhoneAreaCodeModel()
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
        
        for char in sectionTitlesArray
        {
            var tempArray:[MTTPhoneAreaCodeModel] = []
            
            for codeModel in codesArray
            {
                if codeModel.areaFirstChar == char
                {
                    tempArray.append(codeModel)
                }
            }
            codeModelsArray.append(tempArray)
        }
        
        print(codeModelsArray.count)
        print(sectionTitlesArray.count)
        
        self.tableView?.reloadData()
    }
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        self.setupSubview()
        self.layoutSubview()
        
        self.setupDataSource()
    }
    
    // MARK: - 初始化控件
    func setupSubview() -> Void 
    {
        tableView = UITableView.init()
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: reusedCellId)
        tableView?.backgroundColor = kRGBColor(r: 230, g: 236, b: 240)
        self.view.addSubview(tableView!)
    }
    
    // MARK: - 布局控件
    func layoutSubview() -> Void
    {
        tableView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self.view).offset(0)
            make.top.equalTo(self.view).offset(64)
            make.bottom.equalTo(self.view).offset(0)
        })
    }

    // MARK: - dataSource method 
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return sectionTitlesArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return codeModelsArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: reusedCellId)
        if cell == nil
        {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedCellId)
        }
        let codeModel:MTTPhoneAreaCodeModel = codeModelsArray[indexPath.section][indexPath.item]
        cell?.textLabel?.text = String.init(format: "%@ +%@", codeModel.areaName!,codeModel.areaCodeName!)
        cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return cell!
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? 
    {
        return sectionTitlesArray
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? 
    {
        return sectionTitlesArray[section]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? 
    {
        let searchSectionHeaderView = MTTSearchSectionHeaderView()
        searchSectionHeaderView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 50)
        searchSectionHeaderView.titleLabel?.text = sectionTitlesArray[section]
        return searchSectionHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat 
    {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) 
    {
        tableView.deselectRow(at: indexPath, animated: false)
    }

}
