//
//  MTTPersonalViewController.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/10/24.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTPersonalViewController: MTTViewController 
{
    var logoutButton:UIButton?

    override func viewDidLoad() 
    {
        super.viewDidLoad()
        setupSubview()
        layoutSubview()
        setupEvent()

    }
    
    func setupSubview() -> Void 
    {
        logoutButton = UIButton()
        logoutButton?.setTitle("退出", for: UIControlState.normal)
        logoutButton?.setTitleColor(kMainWhiteColor(), for: UIControlState.normal)
        logoutButton?.backgroundColor = kMainBlueColor()
        self.view.addSubview(logoutButton!)
    }
    
    func layoutSubview() -> Void 
    {
        logoutButton?.snp.makeConstraints({ (make) in
            make.height.equalTo(50)
            make.width.equalTo(200)
            make.center.equalTo(self.view)
        })
    }
    
    
    func setupEvent() -> Void 
    {
        (logoutButton?.rx.tap)?.subscribe(onNext:{ [unowned self] in
            let loginVC = MTTLoginViewController()
            let appDelegate = UIApplication.shared.delegate! as UIApplicationDelegate
            appDelegate.window??.rootViewController = loginVC
            appDelegate.window??.makeKeyAndVisible()
            
        }).addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() 
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
