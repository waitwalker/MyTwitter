//
//  MTTPersonalViewController.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/10/24.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTPersonalViewController: MTTViewController ,UITableViewDelegate,UITableViewDataSource
{
    var logoutButton:UIButton?
    var headerContainerView:UIView?
    var logoImageView:UIImageView?
    var accountButton:UIButton?
    var nickNameButton:UIButton?
    var followedButton:UIButton?
    var followingButton:UIButton?
    var personalTableView:UITableView?
    
    var bottomContainerView:UIView?
    var dayNightButton:UIButton?
    var QRCodeButton:UIButton?
    
    
    
    var dataSourceArray:[MTTPersonalModel]?
    
    
    let reusedPersonalId = "personalTableViewId"
    
    
    
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        setupSubview()
        layoutSubview()
        setupEvent()
        loadData()
    }
    
    func loadData() -> Void 
    {
        MTTPersonalViewModel.getPersoalData { (dataArray) in
            self.dataSourceArray = dataArray
            self.personalTableView?.reloadData()
        }
    }
    
    func setupSubview() -> Void 
    {
        logoutButton = UIButton()
        logoutButton?.setTitle("退出", for: UIControlState.normal)
        logoutButton?.setTitleColor(kMainWhiteColor(), for: UIControlState.normal)
        logoutButton?.backgroundColor = kMainBlueColor()
        self.view.addSubview(logoutButton!)
        
        headerContainerView = UIView()
        headerContainerView?.backgroundColor = kMainBlueColor()
        self.view.addSubview(headerContainerView!)
        
        logoImageView = UIImageView()
        logoImageView?.image = UIImage(named: "my_head.jpg")
        logoImageView?.isUserInteractionEnabled = true
        logoImageView?.layer.cornerRadius = 30
        logoImageView?.clipsToBounds = true
        headerContainerView?.addSubview(logoImageView!)
        
        accountButton = UIButton()
        accountButton?.setTitle("偶尔登南山", for: UIControlState.normal)
        accountButton?.setTitleColor(UIColor.black, for: UIControlState.normal)
        accountButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        headerContainerView?.addSubview(accountButton!)
        
        nickNameButton = UIButton()
        nickNameButton?.setTitleColor(kMainGrayColor(), for: UIControlState.normal)
        nickNameButton?.setTitle("@284485487", for: UIControlState.normal)
        nickNameButton?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        headerContainerView?.addSubview(nickNameButton!)
        
        followedButton = UIButton()
        followedButton?.setTitle("1,632关注", for: UIControlState.normal)
        followedButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        followedButton?.setTitleColor(UIColor.black, for: UIControlState.normal)
        followedButton?.setTitleColor(kMainBlueColor(), for: UIControlState.highlighted)
        followedButton?.sizeToFit()
        headerContainerView?.addSubview(followedButton!)
        
        followingButton = UIButton()
        followingButton?.setTitle("390关注者", for: UIControlState.normal)
        followingButton?.setTitleColor(UIColor.black, for: UIControlState.normal)
        followingButton?.setTitleColor(kMainBlueColor(), for: UIControlState.highlighted)
        followingButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        followingButton?.sizeToFit()
        headerContainerView?.addSubview(followingButton!)
        
        personalTableView = UITableView()
        personalTableView?.register(MTTPersonalCell.self, forCellReuseIdentifier: reusedPersonalId)
        personalTableView?.delegate = self
        personalTableView?.dataSource = self
        personalTableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        self.view.addSubview(personalTableView!)
        
        bottomContainerView = UIView()
        self.view.addSubview(bottomContainerView!)
        
        dayNightButton = UIButton()
        dayNightButton?.setImage(UIImage(named: "twitter_day_night"), for: UIControlState.normal)
        bottomContainerView?.addSubview(dayNightButton!)
        
        QRCodeButton = UIButton()
        QRCodeButton?.setImage(UIImage(named: "twitter_QRCode"), for: UIControlState.normal)
        bottomContainerView?.addSubview(QRCodeButton!)
        
    }
    
    func layoutSubview() -> Void 
    {
        logoutButton?.snp.makeConstraints({ (make) in
            make.height.equalTo(50)
            make.width.equalTo(200)
            make.center.equalTo(self.view)
        })
        
        headerContainerView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(64)
            make.height.equalTo(170)
        })
        
        logoImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.top.equalTo(20)
            make.width.height.equalTo(60)
        })
        
        accountButton?.snp.makeConstraints({ (make) in
            make.top.equalTo((logoImageView?.snp.bottom)!).offset(5)
            make.left.equalTo(20)
            make.width.equalTo(80)
            make.height.equalTo(20)
        })
        
        nickNameButton?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.height.equalTo(20)
            make.top.equalTo((accountButton?.snp.bottom)!).offset(0)
            make.width.equalTo(80)
        })
        
        followedButton?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.height.equalTo(20)
            make.top.equalTo((nickNameButton?.snp.bottom)!).offset(10)
        })
        
        followingButton?.snp.makeConstraints({ (make) in
            make.left.equalTo((followedButton?.snp.right)!).offset(10)
            make.height.top.equalTo(followedButton!)
        })
        
        personalTableView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(0)
            make.top.equalTo((headerContainerView?.snp.bottom)!).offset(0)
            make.bottom.equalTo(-50)
        })
        
        bottomContainerView?.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(50)
        })
        
        dayNightButton?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.height.width.equalTo(20)
            make.top.equalTo(15)
        })
        
        QRCodeButton?.snp.makeConstraints({ (make) in
            make.right.equalTo(-20)
            make.height.width.equalTo(20)
            make.top.equalTo(15)
        })
    }
    
    
    func setupEvent() -> Void 
    {
        (logoutButton?.rx.tap)?.subscribe(onNext:{ [unowned self] in
            let loginVC = MTTLoginViewController()
            let appDelegate = UIApplication.shared.delegate! as UIApplicationDelegate
            appDelegate.window??.rootViewController = loginVC
            appDelegate.window??.makeKeyAndVisible()
            print(self)
        }).disposed(by: disposeBag)
        
        dayNightButton?.rx.tap.subscribe(onNext:{ [unowned self] in
            print(self)
            self.dayNightButton?.isSelected = !(self.dayNightButton?.isSelected)!
            if (self.dayNightButton?.isSelected)!
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kDayNotificationString), object: nil)
            } else
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNightNotificationString), object: nil)
            }
            
        }).disposed(by: disposeBag)
    }

    func numberOfSections(in tableView: UITableView) -> Int 
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        switch section 
        {
        case 0:
            return 3
        default:
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        switch indexPath.section 
        {
        case 0:
            var cell = tableView.dequeueReusableCell(withIdentifier: reusedPersonalId) as? MTTPersonalCell
            if cell == nil
            {
                cell = MTTPersonalCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedPersonalId)
            }
            cell?.personalModel = dataSourceArray?[indexPath.item]
            return cell!
        default:
            let cellTitle:[String] = ["设置和隐私","帮助中心"]
            
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            if cell == nil
            {
                cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
                cell?.textLabel?.textAlignment = NSTextAlignment.left
                cell?.textLabel?.textColor = kMainGrayColor()
            }
            cell?.textLabel?.text = cellTitle[indexPath.item]
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) 
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat 
    {
        switch section 
        {
        case 0:
            return 0
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? 
    {
        switch section 
        {
        case 0:
            return UIView()
        default:
            let view = UIView()
            view.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 1)
            view.backgroundColor = kMainGrayColor()
            return view
        }
    }

}
