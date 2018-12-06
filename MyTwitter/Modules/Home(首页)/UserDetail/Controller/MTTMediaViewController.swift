//
//  MTTMediaViewController.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/11/21.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTMediaViewController: MTTViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = kMainRandomColor()
        let label                 = UILabel()
        label.frame               = CGRect(x: 100, y: 20, width: 100, height: 100)
        label.text                = "第3页"
        self.view.addSubview(label)
    }

    override func didReceiveMemoryWarning() {
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
