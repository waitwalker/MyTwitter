//
//  MTTHomeViewController.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/9/16.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTHomeViewController: MTTViewController ,UITableViewDataSource,UITableViewDelegate
{
    let reusedHomeCellId = "reusedHomeCellId"
    
    var homeTableView:UITableView?
    
    var rightButton:UIButton?
    
    var leftButton:UIButton?
    
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        
        self.setupSubview()
        
        self.layoutSubview()
        
        setupEvent()
        
    }
    
    private func setupSubview() -> Void 
    {
        homeTableView = UITableView()
        homeTableView?.delegate = self
        homeTableView?.dataSource = self
        homeTableView?.register(MTTHomeCell.self, forCellReuseIdentifier: reusedHomeCellId)
        homeTableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        self.view.addSubview(homeTableView!)
        
        setupNavBar()
    }
    
    private func layoutSubview() -> Void 
    {
        homeTableView?.snp.makeConstraints({ (make) in
            make.left.right.top.bottom.equalTo(self.view)
        })
    }
    
    
    func setupNavBar() -> Void
    {
        self.navigationItem.title = "主页"
        rightButton = UIButton()
        rightButton?.setImage(UIImage.init(named: "twitter_push"), for: UIControlState.normal)
        rightButton?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightButton!)
        
        leftButton = UIButton()
        leftButton?.setImage(UIImage.init(named: "twitter_push"), for: UIControlState.normal)
        leftButton?.backgroundColor = kMainBlueColor()
        leftButton?.layer.cornerRadius = 20
        leftButton?.clipsToBounds = true
        leftButton?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftButton!)
        
    }
    
    func setupEvent() -> Void
    {
        (rightButton?.rx.tap)?.subscribe(onNext:{
            print("发推按钮被点击了")
            let pushVC = MTTPushTwitterViewController()
            let nav = MTTNavigationController.init(rootViewController: pushVC)
            self.present(nav, animated: true, completion: {
                
            })
            
            
        }).addDisposableTo(disposeBag)
    }
    
    // MARK: - tableView dataSource 数据源回调
    func numberOfSections(in tableView: UITableView) -> Int 
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        var homeCell = tableView.dequeueReusableCell(withIdentifier: reusedHomeCellId, for: indexPath) as? MTTHomeCell
        if homeCell == nil 
        {
            homeCell = MTTHomeCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedHomeCellId)
        }
        return homeCell!
        
    }
    
    // MARK: - tableView delegate 代理回调
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat 
    {
        return 255
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) 
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    

    override func didReceiveMemoryWarning() 
    {
        super.didReceiveMemoryWarning()
    }
    

    

}
