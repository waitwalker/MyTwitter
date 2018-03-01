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
        
        layoutSubview()
    }
    
    func setupSubview() -> Void 
    {
        self.view.backgroundColor = UIColor.black
        
        backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage.imageNamed(name: "shake_back_ground")
        self.view.addSubview(backgroundImageView)
        
        topContainerView = UIView()
        topContainerView.backgroundColor = UIColor.blue
        self.view.addSubview(topContainerView)
        
        bottomContainerView = UIView()
        bottomContainerView.backgroundColor = UIColor.orange
        self.view.addSubview(bottomContainerView)
        
        topImageView = UIImageView()
        topImageView.image = UIImage.imageNamed(name: "shake_top")
        topContainerView.addSubview(topImageView)
        
        bottomImageView = UIImageView()
        bottomImageView.image = UIImage.imageNamed(name: "shake_bottom")
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

    override func didReceiveMemoryWarning() 
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
