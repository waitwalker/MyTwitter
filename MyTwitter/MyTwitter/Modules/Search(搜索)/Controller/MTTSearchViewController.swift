//
//  MTTSearchViewController.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/9/16.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTSearchViewController: MTTViewController ,UITableViewDelegate,UITableViewDataSource{

    var searchTableView:UITableView?
    
    var rightButton:UIButton?
    var leftButton:UIButton?
    var titleButton:UIButton?
    
    
    
    
    let reusedSearchLabelId = "reusedSearchLabelId"
    let reusedSearchShowMoreId = "reusedSearchShowMoreId"
    let reusedSearchTwitterId = "reusedSearchTwitterId"
    let reusedSearchPopularId = "reusedSearchPopularId"
    
    
    var searchTitles:[String] = ["你的趋势","Pelicans","流行文章","搜索全部"]
    
    var searchDataArray:[[MTTSearchModel]] = []
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupSubview()
        layoutSubview()
        setupEvent()
        loadData()
    }

    private func setupSubview() -> Void
    {
        searchTableView = UITableView()
        searchTableView?.backgroundColor = kMainLightGrayColor()
        searchTableView?.delegate = self
        searchTableView?.dataSource = self
        searchTableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        searchTableView?.register(MTTSearchLabelCell.self, forCellReuseIdentifier: reusedSearchLabelId)
        searchTableView?.register(MTTSearchShowMoreCell.self, forCellReuseIdentifier: reusedSearchShowMoreId)
        searchTableView?.register(MTTSearchTwitterCell.self, forCellReuseIdentifier: reusedSearchTwitterId)
        searchTableView?.register(MTTSearchPopularCell.self, forCellReuseIdentifier: reusedSearchPopularId)
        self.view.addSubview(searchTableView!)
        
        setupNavBar()
    }
    
    private func layoutSubview() -> Void
    {
        searchTableView?.snp.makeConstraints({ (make) in
            make.top.left.bottom.right.equalTo(0)
        })
    }
    
    private func setupEvent() -> Void
    {
        
    }
    
    func setupNavBar() -> Void
    {
        rightButton = UIButton()
        rightButton?.setImage(UIImage.init(named: "add-user"), for: UIControlState.normal)
        rightButton?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        rightButton?.imageEdgeInsets = UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightButton!)
        
        leftButton = UIButton()
        leftButton?.setImage(UIImage.init(named: "my_head.jpg"), for: UIControlState.normal)
        leftButton?.layer.cornerRadius = 20
        leftButton?.clipsToBounds = true
        leftButton?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftButton!)
        
        titleButton = UIButton()
        titleButton?.setImage(UIImage(named: "tabbar_search_normal"), for: UIControlState.normal)
        titleButton?.setTitle("搜索 Twitter", for: UIControlState.normal)
        titleButton?.setTitleColor(kMainGrayColor(), for: UIControlState.normal)
        titleButton?.backgroundColor = kMainLightGrayColor()
        titleButton?.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4)
        titleButton?.setImageWithPosition(postion: MTTButtonImagePostion.Left, spacing: 5)
        titleButton?.frame = CGRect(x: 0, y: 0, width: kScreenWidth - 120, height: 30)
        titleButton?.layer.cornerRadius = 15
        titleButton?.clipsToBounds = true
        self.navigationItem.titleView = titleButton
        
    }
    
    func loadData() -> Void
    {
        MTTSearchViewModel.getSearchData { (dataArray) in
            self.searchDataArray = dataArray
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int 
    {
        return searchDataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        return searchDataArray[section].count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        switch indexPath.section 
        {
        case 0:
            
                if indexPath.item < searchDataArray[indexPath.section].count
                {
                    var labelCell = tableView.dequeueReusableCell(withIdentifier: self.reusedSearchLabelId) as? MTTSearchLabelCell
                    if labelCell == nil
                    {
                        labelCell = MTTSearchLabelCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedSearchLabelId)
                    }
                    
                    labelCell?.searchModel = searchDataArray[indexPath.section][indexPath.item]
                    return labelCell!
                } else
                {
                    var showMoreCell = tableView.dequeueReusableCell(withIdentifier: reusedSearchShowMoreId) as? MTTSearchShowMoreCell
                    if showMoreCell == nil
                    {
                        showMoreCell = MTTSearchShowMoreCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedSearchShowMoreId)
                    }
                    return showMoreCell!
                }
        case 1:
            
            if indexPath.item < searchDataArray[indexPath.section].count
            {
                var twitterCell = tableView.dequeueReusableCell(withIdentifier: self.reusedSearchTwitterId) as? MTTSearchTwitterCell
                if twitterCell == nil
                {
                    twitterCell = MTTSearchTwitterCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedSearchTwitterId)
                }
                
                twitterCell?.searchModel = searchDataArray[indexPath.section][indexPath.item]
                return twitterCell!
            } else
            {
                var showMoreCell = tableView.dequeueReusableCell(withIdentifier: reusedSearchShowMoreId) as? MTTSearchShowMoreCell
                if showMoreCell == nil
                {
                    showMoreCell = MTTSearchShowMoreCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedSearchShowMoreId)
                }
                return showMoreCell!
            }
        case 2:
            
            if indexPath.item < searchDataArray[indexPath.section].count
            {
                var popularCell = tableView.dequeueReusableCell(withIdentifier: self.reusedSearchPopularId) as? MTTSearchPopularCell
                if popularCell == nil
                {
                    popularCell = MTTSearchPopularCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedSearchPopularId)
                }
                
                popularCell?.searchModel = searchDataArray[indexPath.section][indexPath.item]
                return popularCell!
            } else
            {
                var showMoreCell = tableView.dequeueReusableCell(withIdentifier: reusedSearchShowMoreId) as? MTTSearchShowMoreCell
                if showMoreCell == nil
                {
                    showMoreCell = MTTSearchShowMoreCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedSearchShowMoreId)
                }
                return showMoreCell!
            }
        case 3:
            
            if indexPath.item < searchDataArray[indexPath.section].count
            {
                var searchAllCell = tableView.dequeueReusableCell(withIdentifier: self.reusedSearchLabelId) as? MTTSearchLabelCell
                if searchAllCell == nil
                {
                    searchAllCell = MTTSearchLabelCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedSearchLabelId)
                }
                
                searchAllCell?.searchModel = searchDataArray[indexPath.section][indexPath.item]
                return searchAllCell!
            } else
            {
                var showMoreCell = tableView.dequeueReusableCell(withIdentifier: reusedSearchShowMoreId) as? MTTSearchShowMoreCell
                if showMoreCell == nil
                {
                    showMoreCell = MTTSearchShowMoreCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedSearchShowMoreId)
                }
                return showMoreCell!
            }
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? 
    {
        let searchHeaderView = MTTSearchHeaderView()
        searchHeaderView.titleLabel?.text = searchTitles[section]
        return searchHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat 
    {
        switch indexPath.section 
        {
        case 0,1,2,3:
            if indexPath.item < searchDataArray[indexPath.section].count
            {
                let searchModel = searchDataArray[indexPath.section][indexPath.item]
                return searchModel.cellHeight!
            } else
            {
                return 40
            }
            
        default:
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat 
    {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat 
    {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) 
    {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section
        {
        case 0:
            
            if indexPath.item != 5
            {
                let searchSelectedVC = MTTSearchLabelViewController.initWithSearchSelectedType(type: MTTSearchCellType.lableCellType)
                self.navigationController?.pushViewController(searchSelectedVC, animated: true)
            }
            
        default:
            break
            
        }
    }
}
