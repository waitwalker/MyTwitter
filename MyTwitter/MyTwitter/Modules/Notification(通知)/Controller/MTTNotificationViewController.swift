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
    let reusedNotificationFollowId = "reusedNotificationFollowId"
    let reusedNotificationReplyId = "reusedNotificationReplyId"
    let reusedNotificationMentionId = "reusedNotificationMentionId"
    let reusedNotificationMultiId = "reusedNotificationMultiId"
    
    
    var allDataArray:[MTTNotificationModel] = []
    var mentionDataArray:[[MTTNotificationModel]] = []
    
    
    
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        setupSubview()
        layoutSubview()
        setupEvent()
        
        loadAllData()
    }

    private func loadAllData() -> Void 
    {
        dataSourceType = MTTNotificationDataSourceType.all
        
        if self.allDataArray.count == Int(0) 
        {
            let queue = DispatchQueue(label: "queuesssss", qos: DispatchQoS.default, attributes: DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.never, target: nil)
            queue.async {
                
                MTTNotificationViewModel.getNotificationAllData { (dataArray) in
                    self.allDataArray = dataArray
                    
                    DispatchQueue.main.async {
                        self.notificationTableView?.reloadData()
                    }
                }
            }
            
        }
        
        
    }
    
    private func loadMetionData() -> Void 
    {
        dataSourceType = MTTNotificationDataSourceType.mention
        if self.mentionDataArray.count == Int(0) 
        {
            //开启一个后台线程处理提及数据
            let notificationQueue = DispatchQueue(label: "notificationQueue", qos: DispatchQoS.default, attributes: DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.never, target: nil)
            notificationQueue.async {
                MTTNotificationViewModel.getNotificationMentionData(callBack: { (dataArray) in
                    self.mentionDataArray = dataArray
                    
                    DispatchQueue.main.async {
                        self.notificationTableView?.reloadData()
                    }
                })
            }
        }
    }
    
    private func setupSubview() -> Void 
    {
        notificationTableView = UITableView()
        notificationTableView?.delegate = self
        notificationTableView?.dataSource = self
        notificationTableView?.register(MTTNotificationButtonCell.self, forCellReuseIdentifier: reusedNotificationButtonId)
        notificationTableView?.register(MTTNotificationFollowCell.self, forCellReuseIdentifier: reusedNotificationFollowId)
        notificationTableView?.register(MTTNotificationMentionCell.self, forCellReuseIdentifier: reusedNotificationMentionId)
        notificationTableView?.register(MTTNotificationReplyCell.self, forCellReuseIdentifier: reusedNotificationReplyId)
        notificationTableView?.register(MTTNotificationMultiTypeCell.self, forCellReuseIdentifier: reusedNotificationMultiId)
        
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
        switch dataSourceType
        {
        case MTTNotificationDataSourceType.all:
            return 1
        case MTTNotificationDataSourceType.mention:
            return self.mentionDataArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        switch dataSourceType
        {
        case MTTNotificationDataSourceType.all:
            return self.allDataArray.count + 1
        case MTTNotificationDataSourceType.mention:
            return self.mentionDataArray[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        
        switch dataSourceType
        {
            case MTTNotificationDataSourceType.all:
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
                    let notificationModel = self.allDataArray[indexPath.item - 1]
                    switch notificationModel.cellType
                    {
                    case MTTNotificationCellType.followType:
                    
                        var cell = tableView.dequeueReusableCell(withIdentifier: reusedNotificationFollowId) as? MTTNotificationFollowCell
                        
                        if cell == nil
                        {
                            cell = MTTNotificationFollowCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedNotificationFollowId)
                        }
                        
                        cell?.notificationModel = self.allDataArray[indexPath.item - 1]
                        
                        print(cell?.notificationModel?.avatarImages as Any)
                        return cell!
                    
                    case MTTNotificationCellType.mentionType:
                        var cell = tableView.dequeueReusableCell(withIdentifier: reusedNotificationMentionId) as? MTTNotificationMentionCell
                        if cell == nil
                        {
                            cell = MTTNotificationMentionCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedNotificationMentionId)
                        }
                        cell?.notificationModel = self.allDataArray[indexPath.item - 1]
                        return cell!
                    
                    case MTTNotificationCellType.replyType:
                        var cell = tableView.dequeueReusableCell(withIdentifier: reusedNotificationReplyId) as? MTTNotificationReplyCell
                        if cell == nil
                        {
                            cell = MTTNotificationReplyCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedNotificationReplyId)
                        }
                        cell?.notificationModel = self.allDataArray[indexPath.item - 1]
                        return cell!
                    
                    case MTTNotificationCellType.multiType:
                        var cell = tableView.dequeueReusableCell(withIdentifier: reusedNotificationMultiId) as? MTTNotificationMultiTypeCell
                        if cell == nil
                        {
                            cell = MTTNotificationMultiTypeCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedNotificationMultiId)
                        }
                        cell?.notificationModel = self.allDataArray[indexPath.item - 1]
                        return cell!
                    }
                }
            
            case MTTNotificationDataSourceType.mention:
                switch self.mentionDataArray.count
                {
                case 0:
                
                    var cell = tableView.dequeueReusableCell(withIdentifier: reusedNotificationReplyId) as? MTTNotificationReplyCell
                    if cell == nil
                    {
                        cell = MTTNotificationReplyCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedNotificationReplyId)
                    }
                    cell?.notificationModel = self.mentionDataArray[indexPath.section][indexPath.item]
                    return cell!
                
                case 1:
                    var cell = tableView.dequeueReusableCell(withIdentifier: reusedNotificationReplyId) as? MTTNotificationReplyCell
                    if cell == nil
                    {
                        cell = MTTNotificationReplyCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedNotificationReplyId)
                    }
                    cell?.notificationModel = self.mentionDataArray[indexPath.section][indexPath.item]
                    return cell!
                default: break
                }
            }
        return UITableViewCell()
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
        switch dataSourceType
        {
        case MTTNotificationDataSourceType.all:
            if indexPath.item == 0
            {
                return 40
            } else
            {
                let notificationModel = self.allDataArray[indexPath.item - 1]
                return notificationModel.cellHeight!
            }
        case MTTNotificationDataSourceType.mention:
            let notificationModel = self.mentionDataArray[indexPath.section][indexPath.item]
            return notificationModel.cellHeight!
        }
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
    

    

}
