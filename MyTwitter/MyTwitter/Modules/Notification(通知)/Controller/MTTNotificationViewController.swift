//
//  MTTNotificationViewController.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/9/16.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTNotificationViewController: MTTViewController ,UITableViewDelegate,UITableViewDataSource,MTTNotificationButtonDelegate{

    var notificationTableView:UITableView?
    
    var rightButton:UIButton?
    
    var leftButton:UIButton?
    
    var dataSourceType:MTTNotificationDataSourceType = MTTNotificationDataSourceType.all
    
    let reusedNotificationButtonId = "reusedNotificationButtonId"
    
    
    
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        setupSubview()
        layoutSubview()
        setupEvent()
    }

    
    private func setupSubview() -> Void 
    {
        notificationTableView = UITableView()
        notificationTableView?.delegate = self
        notificationTableView?.dataSource = self
        notificationTableView?.register(MTTNotificationButtonCell.self, forCellReuseIdentifier: reusedNotificationButtonId)
        notificationTableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        self.view.addSubview(notificationTableView!)
        
        setupNavBar()
    }
    
    private func layoutSubview() -> Void 
    {
        notificationTableView?.snp.makeConstraints({ (make) in
            make.top.left.bottom.right.equalTo(0)
        })
    }
    
    private func setupEvent() -> Void 
    {
        
    }
    
    func setupNavBar() -> Void
    {
        self.navigationItem.title = "通知"
        rightButton = UIButton()
        rightButton?.setImage(UIImage.init(named: "twitter_setting"), for: UIControlState.normal)
        rightButton?.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        rightButton?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightButton!)
        
        leftButton = UIButton()
        leftButton?.setImage(UIImage.init(named: "my_head.jpg"), for: UIControlState.normal)
        leftButton?.layer.cornerRadius = 20
        leftButton?.clipsToBounds = true
        leftButton?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftButton!)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int 
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        if indexPath.item == Int(0)
        {
            var cell = tableView.dequeueReusableCell(withIdentifier: reusedNotificationButtonId) as? MTTNotificationButtonCell
            if cell == nil 
            {
                cell = MTTNotificationButtonCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedNotificationButtonId)
            }
            cell?.delegate = self
            return cell!
        } else
        {
            switch dataSourceType
            {
            case MTTNotificationDataSourceType.all: 
                break
                
            case MTTNotificationDataSourceType.mention: 
                break
            }
            return UITableViewCell()
        }
        
    }
    
    // MARK: - 按钮点击回调
    func tappedAllButton(allButton: UIButton, cell: MTTNotificationButtonCell) 
    {
        allButton.setTitleColor(kMainWhiteColor(), for: UIControlState.normal)
        allButton.backgroundColor = kMainBlueColor()
        cell.mentionButtion?.setTitleColor(kMainBlueColor(), for: UIControlState.normal)
        cell.mentionButtion?.backgroundColor = kMainWhiteColor()
        
        dataSourceType = MTTNotificationDataSourceType.all
        
    }
    
    func tappedMentionButton(mentionButton: UIButton, cell: MTTNotificationButtonCell) 
    {
        mentionButton.setTitleColor(kMainWhiteColor(), for: UIControlState.normal)
        mentionButton.backgroundColor = kMainBlueColor()
        cell.allButton?.setTitleColor(kMainBlueColor(), for: UIControlState.normal)
        cell.allButton?.backgroundColor = kMainWhiteColor()
        
        dataSourceType = MTTNotificationDataSourceType.mention
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat 
    {
        return 35
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) 
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func didReceiveMemoryWarning() 
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
