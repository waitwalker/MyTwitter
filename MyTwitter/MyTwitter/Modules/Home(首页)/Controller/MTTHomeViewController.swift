//
//  MTTHomeViewController.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/9/16.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import Photos
import MJRefresh
import AudioToolbox

private let homeLogger = MTTLogger.homeLogger

class MTTHomeViewController: MTTViewController ,UITableViewDataSource,UITableViewDelegate,MTTHomeCellButtonDelegate
{
    let reusedHomeCellId = "reusedHomeCellId"
    
    var homeTableView:UITableView?
    
    var rightButton:UIButton?
    
    var leftButton:UIButton?
    
    var homeDataArray:[MTTHomeModel]?
    
    var tableViewHeader:MJRefreshNormalHeader?
    
    
    override func viewWillAppear(_ animated: Bool) 
    {
        super.viewDidAppear(animated)
        self.loadNewData()
    }
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        
        self.setupSubview()
        
        self.layoutSubview()
        
        setupEvent()
        
        log()
        
        loadData()
    }
    
    func loadData() -> Void
    {
        MTTHomeViewModel.getHomeNetworkData { (dataArray) in
            if dataArray.count > Int(0)
            {
                self.homeDataArray = dataArray
                self.homeTableView?.reloadData()
            } else
            {
                MTTHomeViewModel.getHomeData { (dataArray) in
                    if dataArray.count > Int(0)
                    {
                        self.homeDataArray = dataArray
                        self.homeTableView?.reloadData()
                    }
                }
            }
        }
        
        //暂时添加的调试代码 以后可以去掉
        MTTHomeViewModel.getHomeData { (dataArray) in
            if dataArray.count > Int(0)
            {
                self.homeDataArray = dataArray
                self.homeTableView?.reloadData()
            }
        }
    }
    
    private func log() -> Void
    {
        
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        homeLogger.debug(path)
        print("路径:",path as Any)
        
        
        homeLogger.verbose("一条verbose级别消息：程序执行时最详细的信息。")
        homeLogger.debug("一条debug级别消息：用于代码调试。")
        homeLogger.info("一条info级别消息：常用与用户在console.app中查看。")
        homeLogger.warning("一条warning级别消息：警告消息，表示一个可能的错误。")
        homeLogger.error("一条error级别消息：表示产生了一个可恢复的错误，用于告知发生了什么事情。")
        homeLogger.severe("一条severe error级别消息：表示产生了一个严重错误。程序可能很快会奔溃。")
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
        
        tableViewHeader = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(loadNewData))
        homeTableView?.mj_header = tableViewHeader
    }
    
    @objc func loadNewData() -> Void 
    {
        self.loadData()
        
        let timeInterval:TimeInterval = 2.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeInterval) { 
            self.homeTableView?.mj_header.endRefreshing()
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
        
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
        leftButton?.setImage(UIImage.init(named: "my_head.jpg"), for: UIControlState.normal)
        leftButton?.layer.cornerRadius = 20
        leftButton?.clipsToBounds = true
        leftButton?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftButton!)
        
    }
    
    func setupEvent() -> Void
    {
        rightButton?.rx.tap.subscribe(onNext:{
            print("发推按钮被点击了")
            
            let pushVC = MTTPushTwitterViewController()
            let nav = MTTNavigationController.init(rootViewController: pushVC)
            
            self.present(nav, animated: true, completion: {
                
            })
            
            
        }).addDisposableTo(disposeBag)
        
        (leftButton?.rx.tap)?.subscribe(onNext:{ [unowned self] in
            print("发送头像被点击",self)
            
            let personalVC = MTTPersonalViewController()
            personalVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(personalVC, animated: true)
            
        }).addDisposableTo(disposeBag)
    }
    
    // MARK: - tableView dataSource 数据源回调
    func numberOfSections(in tableView: UITableView) -> Int 
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        if homeDataArray == nil
        {
            return 1
        } else
        {
            return (homeDataArray?.count)! 
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        if homeDataArray == nil
        {
            return UITableViewCell()
        } else
        {
          
            var homeCell = tableView.dequeueReusableCell(withIdentifier: reusedHomeCellId, for: indexPath) as? MTTHomeCell
            if homeCell == nil 
            {
                homeCell = MTTHomeCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedHomeCellId)
            }
            homeCell?.delegate = self
            homeCell?.commentButton?.indexPath = indexPath
            homeCell?.retwitterButton?.indexPath = indexPath
            homeCell?.likeButton?.indexPath = indexPath
            homeCell?.privateMessageButton?.indexPath = indexPath
            homeCell?.homeModel = homeDataArray?[indexPath.item]
            return homeCell!  
        }
    }
    
    // MARK: - tableView delegate 代理回调
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat 
    {
        if self.homeDataArray != nil
        {
            let homeModel = homeDataArray![indexPath.row]
            
            return homeModel.cellHeight!
        } else
        {
            return 300
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) 
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let followAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "关注") { (rowAction, indexPath) in
            
            print("点击关注了")
            tableView.isEditing = false
        }
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "删除") { (rowAction, indexPath) in
            self.homeDataArray?.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.bottom)
        }
        
        return [followAction,deleteAction]
    }
    
    // MARK: - homeCell四个按钮代理回调
    func tappedCommentButton(commentButton: UIButton, homeCell: MTTHomeCell)
    {
        homeTableView?.reloadRows(at: [commentButton.indexPath], with: UITableViewRowAnimation.fade)
    }
    
    func tappedRetwitterButton(retwitterButton: UIButton, homeCell: MTTHomeCell)
    {
        homeTableView?.reloadRows(at: [retwitterButton.indexPath], with: UITableViewRowAnimation.bottom)
    }
    
    func tappedlikeButton(likeButton: UIButton, homeCell: MTTHomeCell)
    {
        //根据模型中这个indexPath的喜欢状态 修改对应模型状态
        
        //刷新当前行
        homeTableView?.reloadRows(at: [likeButton.indexPath], with: UITableViewRowAnimation.automatic)
    }
    
    func tappedMessageButton(messageButton: UIButton, homeCell: MTTHomeCell)
    {
        homeTableView?.reloadRows(at: [messageButton.indexPath], with: UITableViewRowAnimation.right)
    }

    override func didReceiveMemoryWarning() 
    {
        super.didReceiveMemoryWarning()
    }
    

    

}
