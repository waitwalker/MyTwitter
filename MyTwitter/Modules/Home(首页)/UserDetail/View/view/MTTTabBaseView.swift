//
//  MTTTabBaseView.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2018/2/24.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

import UIKit

class MTTTabBaseView: MTTView {

    var tableView:UITableView!
    
    let reusedCellId:String = "reusedCellId"
    
    
    override init(frame: CGRect) 
    {
        super.init(frame: frame)
        setupNotification()
    }
    
    override func setupSubview() 
    {
        super.setupSubview()
        tableView = UITableView()
        tableView.backgroundColor = kMainRedColor()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reusedCellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 120, 0)
        self.addSubview(tableView)
    }
    
    override func layoutSubview() 
    {
        tableView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalTo(self)
        }
    }
    
    func setupNotification() -> Void 
    {
        NotificationCenter.default.addObserver(self, 
                                               selector: #selector(handleInnerTableViewCanScrollNotification), 
                                               name: NSNotification.Name(rawValue: kUserDetailInnerTableViewCanScrollNotification), 
                                               object: nil)
    }
    
    @objc func handleInnerTableViewCanScrollNotification() -> Void 
    {
        tableView.isScrollEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension MTTTabBaseView:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int 
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: reusedCellId)
        if cell == nil 
        {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: reusedCellId)
        }
        cell?.textLabel?.text = "\(indexPath.item)"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) 
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MTTTabBaseView:UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView) 
    {
        print("MTTTabBaseView:\(scrollView.contentOffset.y)")
        if scrollView.contentOffset.y <= 0.0 
        {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kUserDetailOuterTableViewCanScrollNotification), object: nil)
            self.tableView.contentOffset = CGPoint(x: 0, y: 0)
            self.tableView.isScrollEnabled = false
        }
    }
}

extension MTTTabBaseView:MTTTabBaseInterface
{
    static func setupTabView(tabType: MTTTabBaseType) -> MTTTabBaseView 
    {
        let frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        switch tabType {
        case MTTTabBaseType.MTTTabTweetType:
            let tweetView = MTTTabTweetView(frame: frame)
            return tweetView
        case MTTTabBaseType.MTTTabTweetAndReplyType:
            let tweetAndReplyView = MTTTabTweetAndReplyView(frame: frame)
            return tweetAndReplyView
        case MTTTabBaseType.MTTTabMediaType:
            let mediaView = MTTTabMediaView(frame: frame)
            return mediaView
        case MTTTabBaseType.MTTTabLikeType:
            let likeView = MTTTabLikeView(frame: frame)
            return likeView
        }
        
    }
    
    // MARK: - 加载数据 
    func loadData() 
    {
        
    }
}
