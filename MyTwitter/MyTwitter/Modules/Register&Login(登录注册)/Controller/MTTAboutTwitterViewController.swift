//
//  MTTAboutTwitterViewController.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/9/20.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTAboutTwitterViewController: MTTViewController {

    var aboutTableView:UITableView?
    var rightButton:UIButton?
    var titleLabel:UILabel?
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupSubview()
        self.layoutSubview()
        self.setupEvent()

    }
    
    // MARK: - 初始化控件
    func setupSubview() -> Void
    {
        self.setupNavigationBar()
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
        
    }
    
    // MARK: - 初始化事件源
    func setupEvent() -> Void
    {
        rightButton?.rx.tap.subscribe(onNext:{
            self.dismiss(animated: true) {
                
            }
        }).addDisposableTo(disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
