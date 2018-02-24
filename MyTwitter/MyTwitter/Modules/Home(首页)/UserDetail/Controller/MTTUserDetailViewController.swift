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
    
    let kHeaderBackgroundImageViewHeight:CGFloat = 130
    let kHeaderContainerViewHeight:CGFloat = 220
    let kNavigationBarHeight:CGFloat = 64
    
    
    var headerBackgroundImageView:UIImageView!
    
    var userDetailTableView:UITableView!
    
    var isFirstTime:Bool!
    
    var backButton:UIButton!
    
    var rightButton:UIButton!
    
    var headerContainerView:UIView!
    var avatarContainerView:UIView!
    var avatarImageView:UIImageView!
    
    var bottomContainerView:MTTUserDetailBottomContainerView!
    
    let reusedUserDetailCellID:String = "reusedUserDetailCellID"
    
    
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
        
        setupNotification()
    }
    
    func setupSubview() -> Void
    {
        setupNavigationBar()

        isFirstTime                                        = true

        userDetailTableView                                = UITableView()
        userDetailTableView.delegate                       = self
        userDetailTableView.dataSource                     = self
        userDetailTableView.frame                          = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        userDetailTableView.register(MTTUserDetailContainerCell.self, forCellReuseIdentifier: reusedUserDetailCellID)
        userDetailTableView.separatorStyle                 = UITableViewCellSeparatorStyle.none
        userDetailTableView.backgroundColor                = kMainBlueColor()
        userDetailTableView.contentInset                   = UIEdgeInsetsMake(kHeaderBackgroundImageViewHeight + kHeaderContainerViewHeight, 0, 0, 0)
        self.automaticallyAdjustsScrollViewInsets          = false
        self.view.addSubview(userDetailTableView)

        headerBackgroundImageView                          = UIImageView()
        headerBackgroundImageView.frame                    = CGRect(x: 0, y: 0, width: kScreenWidth, height: kHeaderBackgroundImageViewHeight)
        headerBackgroundImageView.image                    = UIImage.imageNamed(name: "user_detail_header_background")
        headerBackgroundImageView.isUserInteractionEnabled = true
        self.view.addSubview(headerBackgroundImageView)

        headerContainerView                                = UIView()
        headerContainerView.backgroundColor                = kMainRandomColor()
        headerContainerView.frame                          = CGRect(x: 0, y: kHeaderBackgroundImageViewHeight, width: kScreenWidth, height: kHeaderContainerViewHeight)
        self.view.addSubview(headerContainerView)

        avatarContainerView                                = UIView()
        avatarContainerView.backgroundColor                = UIColor.white
        avatarContainerView.layer.cornerRadius             = 40
        avatarContainerView.frame                          = CGRect(x: 30, y: -30, width: 80, height: 80)
        headerContainerView.addSubview(avatarContainerView)

        avatarImageView                                    = UIImageView()
        avatarImageView.isUserInteractionEnabled           = true
        avatarImageView.backgroundColor                    = kMainRandomColor()
        avatarImageView.frame                              = CGRect(x: 0, y: 0, width: 70, height: 70)
        avatarImageView.center                             = avatarContainerView.center
        avatarImageView.layer.cornerRadius                 = 35
        avatarImageView.clipsToBounds                      = true
        headerContainerView.addSubview(avatarImageView)
        
        
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
                self.navigationController?.popViewController(animated: true)})
            .disposed(by: disposeBag)
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: reusedUserDetailCellID) as? MTTUserDetailContainerCell
        if cell == nil 
        {
            cell = MTTUserDetailContainerCell(style: UITableViewCellStyle.default, reuseIdentifier: reusedUserDetailCellID)
        }
        
        cell?.textLabel?.text = "第\(indexPath.item)行"
        cell?.contentView.backgroundColor = kMainBlueColor()
        bottomContainerView = MTTUserDetailBottomContainerView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        bottomContainerView.backgroundColor = UIColor.purple
        bottomContainerView.tabConfig = [1,2,3,4]
        cell?.contentView.addSubview(bottomContainerView)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat 
    {
        return kScreenHeight
    }
    
    
    // MARK: - scrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        
        if isFirstTime 
        {
            isFirstTime = false
        } else
        {
            let offSetY = scrollView.contentOffset.y + kHeaderContainerViewHeight
            
            print("偏移量:\(offSetY)")
            
            print("真实偏移量:\(scrollView.contentOffset.y)")
            
            if scrollView.contentOffset.y >= -64.0
            {
                self.userDetailTableView.isScrollEnabled = false
                self.userDetailTableView.contentOffset = CGPoint(x: 0, y: -64)
            }
            
            // 设置背景头像下面的头容器 
            self.headerBackgroundImageView.y = -offSetY - kHeaderBackgroundImageViewHeight
            
            if -offSetY >= kHeaderBackgroundImageViewHeight
            {
                self.headerBackgroundImageView.height = -offSetY
                self.headerBackgroundImageView.y = 0
            }
            self.headerContainerView.y = -offSetY
            
            let alpha = (offSetY + kHeaderBackgroundImageViewHeight) / (kHeaderBackgroundImageViewHeight - kNavigationBarHeight)
            
            print("透明度:\(alpha)")
            
            let scale = (150 - kNavigationBarHeight) / (offSetY + 300 - kNavigationBarHeight)
            print("比例:\(scale)")
            
            let finalScale = 1 - scale
            
            let x = 30 * (1 + finalScale)
            let y = -30 * (1 - alpha)
            let widthHeight = 80 * (1 - finalScale)
            let avatarImageViewWidthHeight = 70 * (1 - finalScale)
            
            if abs(scale) >= 1.0
            {
                avatarContainerView.layer.cornerRadius = 40        
                avatarContainerView.frame = CGRect(x: 30, y: -30, width: 80, height: 80)
                
                avatarImageView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)        
                avatarImageView.center = avatarContainerView.center
                avatarImageView.layer.cornerRadius = 35        
                avatarImageView.clipsToBounds = true
            } else if scale < 1.0 && scale > 0.5
            {
                self.avatarContainerView.cornerRadius = widthHeight * 0.5
                self.avatarContainerView.clipsToBounds = true
                self.avatarContainerView.frame = CGRect(x: x, y: y, width: widthHeight, height: widthHeight)
                
                self.avatarImageView.cornerRadius = avatarImageViewWidthHeight * 0.5
                self.avatarImageView.clipsToBounds = true
                self.avatarImageView.frame = CGRect(x: 0, y: 0, width: avatarImageViewWidthHeight, height: avatarImageViewWidthHeight)
                self.avatarImageView.center = self.avatarContainerView.center
                
            } else
            {
                avatarContainerView.layer.cornerRadius = 20        
                avatarContainerView.frame = CGRect(x: 45, y: 0, width: 40, height: 40)
                
                avatarImageView.frame = CGRect(x: 0, y: 0, width: 35, height: 35)        
                avatarImageView.center = avatarContainerView.center
                avatarImageView.layer.cornerRadius = 17.5        
                avatarImageView.clipsToBounds = true
            }
            
            if -offSetY <= kNavigationBarHeight
            {
                self.navigationController?.navigationBar.setBackgroundImage(UIImage.imageNamed(name: "user_detail_header_background"), for: UIBarMetrics.default)
            } else
            {
                self.navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(color: UIColor(white: 1, alpha: alpha)), for: UIBarMetrics.default)
            }
            
        }
        
    }
    
    func setupNotification() -> Void
    {
        
    }
    
    
    
}


