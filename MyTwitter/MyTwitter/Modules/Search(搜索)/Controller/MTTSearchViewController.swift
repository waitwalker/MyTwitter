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
    
    let reusedSearchLabelId = "reusedSearchLabelId"
    let reusedSearchShowMoreId = "reusedSearchShowMoreId"
    
    var searchTitles:[String] = ["你的趋势","Pelicans","流行文章","搜索全部"]
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupSubview()
        layoutSubview()
        setupEvent()
    }

    private func setupSubview() -> Void
    {
        searchTableView = UITableView()
        searchTableView?.delegate = self
        searchTableView?.dataSource = self
        searchTableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        searchTableView?.register(MTTSearchLabelCell.self, forCellReuseIdentifier: reusedSearchLabelId)
        searchTableView?.register(MTTSearchShowMoreCell.self, forCellReuseIdentifier: reusedSearchShowMoreId)
        self.view.addSubview(searchTableView!)
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
    
    func numberOfSections(in tableView: UITableView) -> Int 
    {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        switch section 
        {
        case 0:
            return 6
        default:
            return 5
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        switch indexPath.section 
        {
        case 0:
                if indexPath.item != 5
                {
                    var labelCell = tableView.dequeueReusableCell(withIdentifier: self.reusedSearchLabelId) as? MTTSearchLabelCell
                    if labelCell == nil
                    {
                        labelCell = MTTSearchLabelCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedSearchLabelId)
                    }
                    
                    labelCell?.STitleLabel?.text = String(format: "第%d个", indexPath.item)
                    labelCell?.SSubTitleLabel?.text = String(format: "第%d个", indexPath.item)
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
        case 0:
            if indexPath.item != 5
            {
                return 80
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
