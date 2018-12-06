//
//  MTTSearchSelectedViewController.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/10/13.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTSearchSelectedViewController: MTTViewController {

    /**
     case lableCellType          //标题类型
     case showMoreCellType       //显示更多
     case twitterCellType        //发推类型
     case popularArticleCellType //流行文章
     case searchAllCellType      //搜索全部
     */
    
    // MARK: - 工厂模式  根据选中不同的cell 跳转到不同的控制器
    class func initWithSearchSelectedType(type:MTTSearchCellType) -> MTTSearchSelectedViewController
    {
        var searchSelectedVC:MTTSearchSelectedViewController?
        switch type
        {
        case MTTSearchCellType.lableCellType:
            searchSelectedVC = MTTSearchLabelViewController()
            return searchSelectedVC!
        case MTTSearchCellType.showMoreCellType:
            searchSelectedVC = MTTSearchShowMoreViewController()
            return searchSelectedVC!
        case MTTSearchCellType.twitterCellType:
            searchSelectedVC = MTTSearchTwitterViewController()
            return searchSelectedVC!
        case MTTSearchCellType.popularArticleCellType:
            searchSelectedVC = MTTSearchPopularArticleViewController()
            return searchSelectedVC!
        case MTTSearchCellType.searchAllCellType:
            searchSelectedVC = MTTSearchSearchAllViewController()
            return searchSelectedVC!
        }
        
    }
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
