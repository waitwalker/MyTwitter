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
    
    var backButton:UIButton!
    
    
    let reusedUserDetailId:String = "reusedUserDetailId"
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupSubview()
        
        layoutSubview()
        
        setupEvent()

    }
    
//    override func viewWillAppear(_ animated: Bool)
//    {
//        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.isHidden = true
//    }
//
//    override func viewWillDisappear(_ animated: Bool)
//    {
//        super.viewWillDisappear(animated)
//        self.navigationController?.navigationBar.isHidden = false
//    }
//
    func setupSubview() -> Void
    {
        
        userDetailTableView = UITableView()
        userDetailTableView.delegate = self
        userDetailTableView.dataSource = self
        userDetailTableView.contentInset = UIEdgeInsetsMake(150 + 64, 0, 0, 0)
        userDetailTableView.register(UITableViewCell.self, forCellReuseIdentifier: reusedUserDetailId)
        userDetailTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        userDetailTableView.backgroundColor = UIColor.orange
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(userDetailTableView)
        
        
        headerBackgroundImageView = UIImageView()
        headerBackgroundImageView.backgroundColor = kMainBlueColor()
        headerBackgroundImageView.isUserInteractionEnabled = true
        self.view.addSubview(headerBackgroundImageView)
        
        backButton = UIButton()
        backButton.setTitle("返回", for: UIControlState.normal)
        backButton.backgroundColor = UIColor.white
        backButton.setTitleColor(kMainBlueColor(), for: UIControlState.normal)
        headerBackgroundImageView.addSubview(backButton)
        
    }
    
    func layoutSubview() -> Void
    {
        
        userDetailTableView.snp.makeConstraints { (make) in
            make.left.bottom.width.top.equalTo(self.view).offset(0)
        }
        
        
        headerBackgroundImageView.snp.makeConstraints { (make) in
            make.top.left.width.equalTo(self.view)
            make.height.equalTo(150)
        }

        backButton.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(50)
            make.height.width.equalTo(60)

        }
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
    
    // MARK: - scrollViewDelegate
//    func scrollViewDidScroll(_ scrollView: UIScrollView)
//    {
//        let offSetY = scrollView.contentOffset.y
//
//        print("偏移量:\(offSetY)")
//
//
//        self.headerBackgroundImageView.height = 150 - offSetY
//    }
    
}
