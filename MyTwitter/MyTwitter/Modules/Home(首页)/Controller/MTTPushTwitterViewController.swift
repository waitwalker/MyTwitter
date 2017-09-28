//
//  MTTPushTwitterViewController.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/9/28.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTPushTwitterViewController: MTTViewController {

    var rightButton:UIButton?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        setupSubview()
        layoutSubview()
        setupEvent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupSubview() -> Void
    {
        setupNavBar()
    }
    
    func layoutSubview() -> Void
    {
        
    }
    
    func setupNavBar() -> Void
    {
        rightButton = UIButton()
        rightButton?.setImage(UIImage.init(named: "twitter_close"), for: UIControlState.normal)
        rightButton?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        rightButton?.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightButton!)
    }
    
    func setupEvent() -> Void
    {
        (rightButton?.rx.tap)?.subscribe(onNext:{
            self.navigationController?.dismiss(animated: true, completion: {
                
            })
        }).addDisposableTo(disposeBag)
    }

}
