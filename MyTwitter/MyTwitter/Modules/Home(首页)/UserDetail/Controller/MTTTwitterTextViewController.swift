//
//  MTTTwitterTextViewController.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/11/21.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTTwitterTextViewController: MTTViewController {

    var tableView:UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kMainRandomColor()
        
//        let label = UILabel()
//        label.frame = CGRect(x: 100, y: 20, width: 100, height: 100)
//        label.text = "第1页"
//        self.view.addSubview(label)
        
        tableView            = UITableView(frame: self.view.frame)
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
    }


}

extension MTTTwitterTextViewController:
    UITableViewDelegate,
    UITableViewDataSource,
    UIScrollViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil
        {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "第\(indexPath.item)行"
        return cell!
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kUserDetailTableViewContentOffsetYNotification), object: ["contentOffsetY":scrollView.contentOffset.y])
    }
}


