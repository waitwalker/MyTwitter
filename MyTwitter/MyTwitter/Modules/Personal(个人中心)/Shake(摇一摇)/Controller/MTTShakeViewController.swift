//
//  MTTShakeViewController.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2018/2/26.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

import UIKit

class MTTShakeViewController: MTTViewController {
    
    var backgroundImageView:UIImageView!
    
    var topContainerView:UIView!
    var bottomContainerView:UIView!
    
    var topImageView:UIImageView!
    var bottomImageView:UIImageView!
    
    
    
    
    override func viewWillAppear(_ animated: Bool) 
    {
        super.viewWillAppear(animated)
        sharedInstance.setupClearNavigationBar(controller: self)
    }
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        
        setupSubview()
        
        //layoutSubview()
    }
    
    func setupSubview() -> Void 
    {
        self.view.backgroundColor = UIColor.black
        
        backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage.imageNamed(name: "shake_back_ground")
        backgroundImageView.frame = CGRect(x: 0, y: kScreenHeight / 4, width: kScreenWidth, height: kScreenHeight / 2)
        self.view.addSubview(backgroundImageView)
        
        topContainerView = UIView()
        topContainerView.backgroundColor = UIColor.blue
        topContainerView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight / 2)
        self.view.addSubview(topContainerView)
        
        bottomContainerView = UIView()
        bottomContainerView.frame = CGRect(x: 0, y: kScreenHeight / 2, width: kScreenWidth, height: kScreenHeight / 2)
        bottomContainerView.backgroundColor = UIColor.orange
        self.view.addSubview(bottomContainerView)
        
        topImageView = UIImageView()
        topImageView.image = UIImage.imageNamed(name: "shake_top")
        topImageView.frame = CGRect(x: (kScreenWidth - 70) / 2, y: (kScreenHeight / 2 - 50), width: 70, height: 50)
        topContainerView.addSubview(topImageView)
        
        bottomImageView = UIImageView()
        bottomImageView.image = UIImage.imageNamed(name: "shake_bottom")
        bottomImageView.frame = CGRect(x: (kScreenWidth - 70) / 2, y: 0, width: 70, height: 50)
        bottomContainerView.addSubview(bottomImageView)
    }
    
    func layoutSubview() -> Void 
    {
        backgroundImageView.snp.makeConstraints { make in
            make.center.equalTo(self.view)
            make.height.equalTo(self.view.height / 2)
            make.width.equalTo(self.view)
        }
        
        topContainerView.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(self.view.height / 2)
        }
        
        bottomContainerView.snp.makeConstraints { make in
            make.left.bottom.right.equalTo(self.view)
            make.top.equalTo(self.view.height / 2)
        }
        
        topImageView.snp.makeConstraints { make in
            make.bottom.equalTo(self.topContainerView.snp.bottom)
            make.centerX.equalTo(self.topContainerView)
            make.height.equalTo(50)
            make.width.equalTo(70)
        }
        
        bottomImageView.snp.makeConstraints { make in
            make.centerX.top.equalTo(self.bottomContainerView)
            make.height.equalTo(50)
            make.width.equalTo(70)
        }
        
    }
    
    func setupNavigationBar() -> Void 
    {
        
    }
    
    // MARK: - 加速剂事件
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) 
    {
        UIView.animate(withDuration: 1.0, animations: { 
            self.topContainerView.frame = CGRect(x: 0, y: -(kScreenHeight / 4), width: kScreenWidth, height: kScreenHeight / 2)
            self.bottomContainerView.frame = CGRect(x: 0, y: (kScreenHeight / 4 + kScreenHeight / 2), width: kScreenWidth, height: kScreenHeight / 2)
        }) { completed in
            
            UIView.animate(withDuration: 1.0, animations: { 
                
                self.topContainerView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight / 2)
                self.bottomContainerView.frame = CGRect(x: 0, y: kScreenHeight / 2, width: kScreenWidth, height: kScreenHeight / 2)
            })
            
        }
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) 
    {
        print("摇一摇结束")
    }
    
    override func motionCancelled(_ motion: UIEventSubtype, with event: UIEvent?) 
    {
        print("摇一摇被打断取消")
    }

    override func didReceiveMemoryWarning() 
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
