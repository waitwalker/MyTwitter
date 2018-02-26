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
    
    
    override func viewWillAppear(_ animated: Bool) 
    {
        super.viewWillAppear(animated)
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
    }
    
    func layoutSubview() -> Void 
    {
        backgroundImageView.snp.makeConstraints { make in
            make.center.equalTo(self.view)
            make.height.equalTo(self.view.width / 2)
            make.width.equalTo(self.view)
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
