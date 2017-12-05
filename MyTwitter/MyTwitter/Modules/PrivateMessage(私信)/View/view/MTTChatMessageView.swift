//
//  MTTChatMessageView.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/12/5.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTChatMessageView: MTTView {

    var reusedChatMessageCellId:String = "reusedChatMessageCellId"
    
    
    var chatMessageTableView:UITableView!
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    override func setupSubview()
    {
        chatMessageTableView = UITableView()
        chatMessageTableView.backgroundColor = kMainBlueColor()
        chatMessageTableView.delegate = self
        chatMessageTableView.dataSource = self
        chatMessageTableView.register(UITableViewCell.self, forCellReuseIdentifier: reusedChatMessageCellId)
        self.addSubview(chatMessageTableView)
    }
    
    override func layoutSubview()
    {
        super.layoutSubview()
        
        chatMessageTableView.frame = self.bounds
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
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: reusedChatMessageCellId)
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: reusedChatMessageCellId)
        }
        cell?.textLabel?.text = "\(indexPath.item)"
        return cell!
    }
    
}
