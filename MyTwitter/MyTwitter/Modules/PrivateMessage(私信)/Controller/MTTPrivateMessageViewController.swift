//
//  MTTPrivateMessageViewController.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/9/16.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTPrivateMessageViewController: MTTViewController,UITableViewDelegate,UITableViewDataSource,MTTMessagetButtonDelegate
{
    
    var messageTableView:UITableView?
    
    var rightButton:UIButton?
    
    var leftButton:UIButton?
    
    var dataSourceType:MTTMessageDataSourceType = MTTMessageDataSourceType.mailBoxType
    var mailBoxArray:[MTTMessageModel] = []
    var requestArray:[MTTMessageModel] = []
    
    let reusedMessageButtonId = "reusedMessageButtonId"
    let reusedMessageMailBoxId = "reusedMessageMailBoxId"
    let reusedMessageRequestId = "reusedMessageRequestId"
    let reusedMessageHintId = "reusedMessageHintId"

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupSubview()
        layoutSubview()
        setupEvent()
        loadMailBoxData()
        loadRequestData()
    }
    
    private func loadMailBoxData() -> Void
    {
        if self.mailBoxArray.count == 0
        {
            dataSourceType = MTTMessageDataSourceType.mailBoxType
            let mailBoxQueue = DispatchQueue(label: "mailBoxQueue", qos: DispatchQoS.default, attributes: DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.never, target: nil)
            mailBoxQueue.async {
                MTTMessageViewModel.getMailBoxData(callBack: { (dataArray) in
                    self.mailBoxArray = dataArray
                    DispatchQueue.main.async {
                        self.messageTableView?.reloadData()
                    }
                })
            }
        }
    }
    
    private func loadRequestData() -> Void
    {
        if self.requestArray.count == 0
        {
            let requestQueue = DispatchQueue(label: "requestQueue", qos: DispatchQoS.default, attributes: DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.never, target: nil)
            requestQueue.async {
                MTTMessageViewModel.getRequestData(callBack: { (dataArray) in
                    self.requestArray = dataArray
                })
            }
        }
    }
    
    private func setupSubview() -> Void
    {
        messageTableView = UITableView()
        messageTableView?.delegate = self
        messageTableView?.dataSource = self
        messageTableView?.register(MTTMessageButtonCell.self, forCellReuseIdentifier: reusedMessageButtonId)
        messageTableView?.register(MTTMessageCell.self, forCellReuseIdentifier: reusedMessageMailBoxId)
        messageTableView?.register(MTTMessageCell.self, forCellReuseIdentifier: reusedMessageRequestId)
        messageTableView?.register(MTTMessageHintCell.self, forCellReuseIdentifier: reusedMessageHintId)
        messageTableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        self.view.addSubview(messageTableView!)
        
        setupNavBar()
    }
    
    private func layoutSubview() -> Void
    {
        messageTableView?.snp.makeConstraints({ (make) in
            make.top.left.bottom.right.equalTo(0)
        })
    }
    
    private func setupEvent() -> Void
    {
        
    }
    
    func setupNavBar() -> Void
    {
        self.navigationItem.title = "私信"
        rightButton = UIButton()
        rightButton?.setImage(UIImage.init(named: "send-mail"), for: UIControlState.normal)
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
        switch dataSourceType
        {
        case MTTMessageDataSourceType.mailBoxType:
            return self.mailBoxArray.count + 1
        case MTTMessageDataSourceType.requestType:
            return self.requestArray.count + 2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.item == 0
        {
            return 40
        } else
        {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.item == 0
        {
            var cell = tableView.dequeueReusableCell(withIdentifier: reusedMessageButtonId) as? MTTMessageButtonCell
            if cell == nil
            {
                cell = MTTMessageButtonCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedMessageButtonId)
            }
            cell?.delegate = self
            return cell!
        } else
        {
            switch dataSourceType
            {
            case MTTMessageDataSourceType.mailBoxType:
                
                var cell = tableView.dequeueReusableCell(withIdentifier: reusedMessageMailBoxId) as? MTTMessageCell
                if cell == nil
                {
                    cell = MTTMessageCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedMessageMailBoxId)
                }
                cell?.messageModel = self.mailBoxArray[indexPath.item - 1]
                return cell!
            case MTTMessageDataSourceType.requestType:
                
                if indexPath.item == 1
                {
                    var cell = tableView.dequeueReusableCell(withIdentifier: reusedMessageHintId) as? MTTMessageHintCell
                    if cell == nil
                    {
                        cell = MTTMessageHintCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedMessageHintId)
                    }
                    return cell!
                    
                } else
                {
                    var cell = tableView.dequeueReusableCell(withIdentifier: reusedMessageRequestId) as? MTTMessageCell
                    if cell == nil
                    {
                        cell = MTTMessageCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedMessageRequestId)
                    }
                    cell?.messageModel = self.requestArray[indexPath.item - 2]
                    return cell!
                }
            }
        }
    }
    
    
    func tappedMailBoxButton(mailBoxButton: UIButton, cell: MTTMessageButtonCell)
    {
        mailBoxButton.setTitleColor(kMainWhiteColor(), for: UIControlState.normal)
        mailBoxButton.backgroundColor = kMainBlueColor()
        cell.requestButtion?.setTitleColor(kMainBlueColor(), for: UIControlState.normal)
        cell.requestButtion?.backgroundColor = kMainWhiteColor()
        dataSourceType = MTTMessageDataSourceType.mailBoxType
        
        if self.mailBoxArray.count == Int(0)
        {
            loadMailBoxData()
        }
        
        DispatchQueue.main.async {
            self.messageTableView?.reloadData()
        }
    }
    
    func tappedRequestButton(requestButton: UIButton, cell: MTTMessageButtonCell)
    {
        requestButton.setTitleColor(kMainWhiteColor(), for: UIControlState.normal)
        requestButton.backgroundColor = kMainBlueColor()
        cell.mailBoxButton?.setTitleColor(kMainBlueColor(), for: UIControlState.normal)
        cell.mailBoxButton?.backgroundColor = kMainWhiteColor()
        dataSourceType = MTTMessageDataSourceType.requestType
        
        if self.requestArray.count == Int(0)
        {
            loadRequestData()
        }
        
        DispatchQueue.main.async {
            self.messageTableView?.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func didReceiveMemoryWarning() {
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
