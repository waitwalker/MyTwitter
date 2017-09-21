//
//  MTTAboutTwitterViewController.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/9/20.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTAboutTwitterViewController: MTTViewController,UITableViewDelegate,UITableViewDataSource {
    
    let reusedAbortNormalCellId = "reusedAbortNormalCellId"
    let reusedAbortSwitchCellId = "reusedAbortSwitchCellId"
    
    var aboutTableView:UITableView?
    var rightButton:UIButton?
    var titleLabel:UILabel?
    var dataSource:[[MTTAboutModel]] = [[]]
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupSubview()
        self.layoutSubview()
        self.setupEvent()
        self.loadData()
        
    }
    
    // MARK: - 加载数据
    func loadData() -> Void 
    {
        MTTAboutViewModel.getAboutTwitterData { (dataArray) in
            self.dataSource = dataArray
            self.aboutTableView?.reloadData()
        }
    }
    
    // MARK: - 初始化控件
    func setupSubview() -> Void
    {
        self.setupNavigationBar()
        self.view.backgroundColor = kMainLightGrayColor()
        
        //aboutTableView
        aboutTableView = UITableView()
        aboutTableView?.delegate = self
        aboutTableView?.dataSource = self
        aboutTableView?.register(MTTAboutNormalCell.self, forCellReuseIdentifier: reusedAbortNormalCellId)
        aboutTableView?.register(MTTAboutSwitchCell.self, forCellReuseIdentifier: reusedAbortSwitchCellId)
        aboutTableView?.backgroundColor = kMainLightGrayColor()
        aboutTableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        self.view.addSubview(aboutTableView!)
    }
    
    func setupNavigationBar() -> Void
    {
        //titleLabel
        titleLabel = UILabel()
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel?.text = "关于 Twitter"
        titleLabel?.textColor = UIColor.black
        titleLabel?.textAlignment = NSTextAlignment.center
        self.navigationItem.titleView = titleLabel
        
        //rightButton
        rightButton = UIButton()
        rightButton?.setImage(UIImage.init(named: "twitter_close"), for: UIControlState.normal)
        rightButton?.imageEdgeInsets = UIEdgeInsetsMake(15, 11, 15, 11)
        rightButton?.frame = CGRect(x: 0, y: 0, width: 40, height: 44)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightButton!)
    }
    
    // MARK: - 布局控件
    func layoutSubview() -> Void
    {
        //aboutTableView
        aboutTableView?.snp.makeConstraints({ (make) in
            make.top.left.bottom.right.equalTo(self.view)
        })
    }
    
    // MARK: - 初始化事件源
    func setupEvent() -> Void
    {
        rightButton?.rx.tap.subscribe(onNext:{
            self.dismiss(animated: true) {
                
            }
        }).addDisposableTo(disposeBag)
    }
    
    // MARK: - tableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int 
    {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        switch section 
        {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 4
        default:
            return 300
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        switch indexPath.section 
        {
        case 1: 
            
            if indexPath.item == 0
            {
                var switchCell = tableView.dequeueReusableCell(withIdentifier: reusedAbortSwitchCellId, for: indexPath) as? MTTAboutSwitchCell
                if switchCell == nil
                {
                    switchCell = MTTAboutSwitchCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedAbortSwitchCellId)
                }
                switchCell?.aboutModel = self.dataSource[indexPath.section][indexPath.item]
                return switchCell!
                
            } else
            {
                var normalCell = tableView.dequeueReusableCell(withIdentifier: reusedAbortNormalCellId, for: indexPath) as? MTTAboutNormalCell
                if normalCell == nil
                {
                    normalCell = MTTAboutNormalCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedAbortNormalCellId)
                }
                normalCell?.aboutModel = self.dataSource[indexPath.section][indexPath.item]
                normalCell?.versionLabel?.isHidden = true
                normalCell?.arrowImageView?.isHidden = false
                return normalCell!
            }
            
        default:
            var normalCell = tableView.dequeueReusableCell(withIdentifier: reusedAbortNormalCellId, for: indexPath) as? MTTAboutNormalCell
            if (normalCell == nil) 
            {
                normalCell = MTTAboutNormalCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedAbortNormalCellId)
            }
            normalCell?.aboutModel = self.dataSource[indexPath.section][indexPath.item]
            normalCell?.versionLabel?.isHidden = true
            normalCell?.arrowImageView?.isHidden = false
            
            if indexPath.section == 0
            {
                normalCell?.versionLabel?.isHidden = false
                normalCell?.arrowImageView?.isHidden = true
            }
            
            return normalCell!
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? 
    {
        switch section {
        case 0:
            return UIView()
        case 1:
            let sectionHeaderOne = MTTAboutHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 60))
            sectionHeaderOne.headerTitleLabel?.text = "获得帮助"
            return sectionHeaderOne
        case 2:
            let sectionHeaderTwo = MTTAboutHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 60))
            sectionHeaderTwo.headerTitleLabel?.text = "法律信息"
            return sectionHeaderTwo
        default: 
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat 
    {
        switch indexPath.section 
        {
        case 1:
            if indexPath.item == 0
            {
                return 90
            } else
            {
                return 40
            }
        default:
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat 
    {
        switch section {
        case 0:
            return 0
        default:
            return 60
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
    

}
