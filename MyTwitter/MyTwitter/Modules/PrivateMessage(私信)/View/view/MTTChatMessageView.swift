//
//  MTTChatMessageView.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/12/5.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTChatMessageView: MTTView {

    var reusedChatMessageNoneCellId:String = "reusedChatMessageNoneCellId"
    var reusedChatMessageCellId:String = "reusedChatMessageCellId"
    
    var chatMessageTableView:UITableView!
    
    var dataSource:[MTTChatMessageModel] = []
    
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        loadChatMessageData()
    }
    
    override func setupSubview()
    {
        chatMessageTableView = UITableView()
        chatMessageTableView.backgroundColor = kMainBlueColor()
        chatMessageTableView.delegate = self
        chatMessageTableView.dataSource = self
        chatMessageTableView.register(UITableViewCell.self, forCellReuseIdentifier: reusedChatMessageNoneCellId)
        chatMessageTableView.register(MTTChatMessageCell.self, forCellReuseIdentifier: reusedChatMessageCellId)
        self.addSubview(chatMessageTableView)
    }
    
    override func layoutSubview()
    {
        super.layoutSubview()
        chatMessageTableView.frame = self.bounds
    }
    
    func loadChatMessageData() -> Void
    {
        let chatMessageArr = [
            ["cellHeight":150,"messageFrom":MTTChatMessageFromType.Others,"messageContent":"今天过来吗?"],
            ["cellHeight":150,"messageFrom":MTTChatMessageFromType.My,"messageContent":"今天有事吗?"],
            ["cellHeight":150,"messageFrom":MTTChatMessageFromType.Others,"messageContent":"刚才你说的什么,没有收到,明天可能有时间,明天在过去吧"],
            ["cellHeight":150,"messageFrom":MTTChatMessageFromType.My,"messageContent":"今天过来吗?"],
            ["cellHeight":150,"messageFrom":MTTChatMessageFromType.Others,"messageContent":"今天过来吗?"],
            ["cellHeight":150,"messageFrom":MTTChatMessageFromType.My,"messageContent":"今天过来吗?"],
            ["cellHeight":150,"messageFrom":MTTChatMessageFromType.Others,"messageContent":"今天过来吗?"],
            ["cellHeight":150,"messageFrom":MTTChatMessageFromType.Others,"messageContent":"今天过来吗?"],
            ["cellHeight":150,"messageFrom":MTTChatMessageFromType.Others,"messageContent":"今天过来吗?"],
            ["cellHeight":150,"messageFrom":MTTChatMessageFromType.Others,"messageContent":"今天过来吗?"],
            ["cellHeight":150,"messageFrom":MTTChatMessageFromType.My,"messageContent":"今天过来吗?"],
            ["cellHeight":150,"messageFrom":MTTChatMessageFromType.My,"messageContent":"今天过来吗?"],
            ["cellHeight":150,"messageFrom":MTTChatMessageFromType.My,"messageContent":"今天过来吗?"],
            ["cellHeight":150,"messageFrom":MTTChatMessageFromType.Others,"messageContent":"今天过来吗?"],
            
            ]
        
        for dict in chatMessageArr {
            let model = MTTChatMessageModel()
            model.cellHeight = CGFloat(dict["cellHeight"] as! Int)
            model.messageFrom = dict["messageFrom"] as! MTTChatMessageFromType
            model.messageContent = dict["messageContent"] as! String
            dataSource.append(model)
        }
        
        self.chatMessageTableView.reloadData()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension MTTChatMessageView:
UITableViewDelegate,
UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if dataSource.count > 0
        {
            var cell = tableView.dequeueReusableCell(withIdentifier: reusedChatMessageCellId) as? MTTChatMessageCell
            if cell == nil
            {
                cell = MTTChatMessageCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedChatMessageCellId)
            }
            cell?.chatMessageModel = dataSource[indexPath.item]
            return cell!
        } else
        {
            var cell = tableView.dequeueReusableCell(withIdentifier: reusedChatMessageNoneCellId)
            if cell == nil
            {
                cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: reusedChatMessageNoneCellId)
            }
            cell?.textLabel?.text = "\(indexPath.item)"
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if dataSource.count > 0
        {
            let model = dataSource[indexPath.item]
            return model.cellHeight
        } else
        {
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("选中行数:\(indexPath.item)")
    }
    
}
