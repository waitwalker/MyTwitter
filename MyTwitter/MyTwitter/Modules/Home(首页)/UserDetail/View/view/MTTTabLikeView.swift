//
//  MTTTabLikeView.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2018/2/24.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

/***********
 喜欢
 ***********/

import UIKit
import RxCocoa
import RxSwift

class MTTTabLikeView: MTTTabBaseView {

    let disposeBag = DisposeBag()
    
    var homeModels:[MTTHomeModel] = []
    
    let reusedLikeId:String = "reusedLikeId"
    
    
    // 自定义事件序列类型 
    let parameterJust = { (element:[String:Any]) -> Observable<[String:Any]> in
        return Observable.create({ observer -> Disposable in
            observer.onNext(element)
            observer.onCompleted()
            return Disposables.create()
        })
    }
    
    override init(frame: CGRect) 
    {
        super.init(frame: frame)
        self.backgroundColor = kMainRandomColor()
        self.tableView.register(MTTHomeCell.self, forCellReuseIdentifier: reusedLikeId)
    }
    
    override func loadData() {
        
        let para:[String:Any] = ["date":"2018"]
        
        // input 
        let parameterSequence = parameterJust(para)
        
        let viewModel = MTTUserDetailViewModel(parameters: parameterSequence, service: MTTBaseService.sharedService)
        
        // output 
        viewModel.models
            .asObservable()
            .subscribe(onNext:{element in 
                
                self.homeModels = element
                DispatchQueue.main.async(execute: { 
                    self.tableView.reloadData()
                })
                
            }).disposed(by: disposeBag)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int 
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        
        return self.homeModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        
        if self.homeModels.count > 0 
        {
            var homeCell = tableView.dequeueReusableCell(withIdentifier: reusedLikeId) as? MTTHomeCell
            if homeCell == nil
            {
                homeCell = MTTHomeCell(style: UITableViewCellStyle.default, reuseIdentifier: reusedLikeId)
            }
            homeCell?.homeModel = self.homeModels[indexPath.item]
            
            return homeCell!
        } else
        {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat 
    {
        if self.homeModels.count > 0 
        {
            let homeModel = self.homeModels[indexPath.item]
            
            return homeModel.cellHeight!
        } else
        {
            return 44
        }
    }

}
