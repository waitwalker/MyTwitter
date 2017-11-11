//
//  MTTUserDetailViewController.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/11/7.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxGesture

class MTTUserDetailViewController: MTTViewController
{
    var disposeBag = DisposeBag()
    
    let kHeaderBackgroundImageViewHeight:CGFloat = 150
    
    var headerBackgroundImageView:UIImageView!
    
    var userDetailTableView:UITableView!
    
    var isFirstTime:Bool!
    
    var backButton:UIButton!
    
    var rightButton:UIButton!
    
    
    
    
    let reusedUserDetailId:String = "reusedUserDetailId"
    
    
    override func viewWillAppear(_ animated: Bool) 
    {
        super.viewWillAppear(animated)
        
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupSubview()
        
        layoutSubview()
        
        setupEvent()

    }
    
    func setupSubview() -> Void
    {
        setupNavigationBar()
        
        isFirstTime = true
        
        userDetailTableView = UITableView()
        userDetailTableView.delegate = self
        userDetailTableView.dataSource = self
        userDetailTableView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        userDetailTableView.register(UITableViewCell.self, forCellReuseIdentifier: reusedUserDetailId)
        userDetailTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        userDetailTableView.backgroundColor = UIColor.orange
        userDetailTableView.contentInset = UIEdgeInsetsMake(150, 0, 0, 0)
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(userDetailTableView)
        
        headerBackgroundImageView = UIImageView()
        headerBackgroundImageView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 150)
        headerBackgroundImageView.backgroundColor = kMainBlueColor()
        headerBackgroundImageView.isUserInteractionEnabled = true
        self.view.addSubview(headerBackgroundImageView)
        
    }
    
    private func setupNavigationBar() -> Void 
    {
        backButton = UIButton()
        backButton.setImage(UIImage.imageNamed(name: "back_placeholder"), for: UIControlState.normal)
        backButton.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3)
        backButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        rightButton = UIButton()
        rightButton.setImage(UIImage.imageNamed(name: "twitter_push"), for: UIControlState.normal)
        rightButton.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3)
        rightButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        
    }
    
    
    func layoutSubview() -> Void
    {
        
    }
    
    func setupEvent() -> Void
    {
        
    }
    
    
}

extension MTTUserDetailViewController :UITableViewDelegate, UITableViewDataSource ,UIScrollViewDelegate
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
        var cell = tableView.dequeueReusableCell(withIdentifier: reusedUserDetailId)
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: reusedUserDetailId)
        }
        
        cell?.textLabel?.text = "第\(indexPath.item)行"
        
        return cell!
        
    }
    
    // MARK: - scrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        
        if isFirstTime 
        {
            isFirstTime = false
        } else
        {
            let offSetY = scrollView.contentOffset.y
            self.headerBackgroundImageView.height = abs(offSetY)
        }
        
    }
    
}
