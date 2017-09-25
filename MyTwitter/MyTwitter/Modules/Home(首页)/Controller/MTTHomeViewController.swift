//
//  MTTHomeViewController.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/9/16.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTHomeViewController: MTTViewController ,UITableViewDataSource,UITableViewDelegate
{
    let reusedHomeCellId = "reusedHomeCellId"
    
    var homeTableView:UITableView?
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        
        self.setupSubview()
        
        self.layoutSubview()
        
    }
    
    private func setupSubview() -> Void 
    {
        homeTableView = UITableView()
        homeTableView?.delegate = self
        homeTableView?.dataSource = self
        homeTableView?.register(MTTHomeCell.self, forCellReuseIdentifier: reusedHomeCellId)
        homeTableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        self.view.addSubview(homeTableView!)
    }
    
    private func layoutSubview() -> Void 
    {
        homeTableView?.snp.makeConstraints({ (make) in
            make.left.right.top.bottom.equalTo(self.view)
        })
    }
    
    // MARK: - tableView dataSource 数据源回调
    func numberOfSections(in tableView: UITableView) -> Int 
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        var homeCell = tableView.dequeueReusableCell(withIdentifier: reusedHomeCellId, for: indexPath) as? MTTHomeCell
        if homeCell == nil 
        {
            homeCell = MTTHomeCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedHomeCellId)
        }
        return homeCell!
        
    }
    
    // MARK: - tableView delegate 代理回调
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat 
    {
        return 255
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) 
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    

    override func didReceiveMemoryWarning() 
    {
        super.didReceiveMemoryWarning()
    }
    

    

}
