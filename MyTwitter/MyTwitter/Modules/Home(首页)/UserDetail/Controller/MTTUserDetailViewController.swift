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
    
    var headerContainerView:UIView!
    
    
    
    let reusedUserHeaderId:String = "reusedUserHeaderId"
    
    let reusedUserDetailId:String = "reusedUserDetailId"
    
    
    override func viewWillAppear(_ animated: Bool) 
    {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) 
    {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = nil
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
        userDetailTableView.register(MTTUserDetailHeaderCell.self, forCellReuseIdentifier: reusedUserHeaderId)
        userDetailTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        userDetailTableView.backgroundColor = kMainBlueColor()
        userDetailTableView.contentInset = UIEdgeInsetsMake(150 + 300, 0, 0, 0)
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(userDetailTableView)
        
        headerBackgroundImageView = UIImageView()
        headerBackgroundImageView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 150)
        headerBackgroundImageView.image = UIImage.imageNamed(name: "user_detail_header_background")
        headerBackgroundImageView.isUserInteractionEnabled = true
        self.view.addSubview(headerBackgroundImageView)
        
        headerContainerView = UIView()
        headerContainerView.backgroundColor = kMainRandomColor()
        headerContainerView.frame = CGRect(x: 0, y: 150, width: kScreenWidth, height: 300)
        self.view.addSubview(headerContainerView)
        
    }
    
    private func setupNavigationBar() -> Void 
    {
        backButton                             = UIButton()
        backButton.setImage(UIImage.imageNamed(name: "back_placeholder"), for: UIControlState.normal)
        backButton.imageEdgeInsets             = UIEdgeInsetsMake(3, 3, 3, 3)
        backButton.frame                       = CGRect(x: 0, y: 0, width: 32, height: 32)
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: backButton)

        rightButton                            = UIButton()
        rightButton.setImage(UIImage.imageNamed(name: "twitter_push"), for: UIControlState.normal)
        rightButton.imageEdgeInsets            = UIEdgeInsetsMake(3, 3, 3, 3)
        rightButton.frame                      = CGRect(x: 0, y: 0, width: 32, height: 32)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
    }
    
    
    func layoutSubview() -> Void
    {
        
    }
    
    func setupEvent() -> Void
    {
        backButton.rx.tap
            .subscribe(onNext:{[unowned self] in
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat 
    {
        return 44
    }
    
    
    // MARK: - scrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        
        if isFirstTime 
        {
            isFirstTime = false
        } else
        {
            let offSetY = scrollView.contentOffset.y + 300
            
            print("偏移量:\(offSetY)")
            
            // 设置背景头像下面的头容器 
            self.headerBackgroundImageView.y = -offSetY - 150
            
            
            if -offSetY >= 150
            {
                self.headerBackgroundImageView.height = -offSetY
                self.headerBackgroundImageView.y = 0
            }
            self.headerContainerView.y = -offSetY
            
            let alpha = (offSetY + 150) / (150 - 64)
            
            print("透明度:\(alpha)")
            
            
            if -offSetY <= 64
            {
                self.navigationController?.navigationBar.setBackgroundImage(UIImage.imageNamed(name: "user_detail_header_background"), for: UIBarMetrics.default)
            } else
            {
                self.navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(color: UIColor(white: 1, alpha: alpha)), for: UIBarMetrics.default)
            }
            
            
        }
        
    }
    
}
