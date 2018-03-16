//
//  MTTTabMdeiaView.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2018/2/24.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

/***********
 媒体
 ***********/

import UIKit
import RxSwift
import RxCocoa

class MTTTabMediaView: MTTTabBaseView {

    let reusedMediaId:String = "reusedMediaId"
    var viewModel:MTTTabMediaViewModel!
    var tabMediaModels:[MTTTabMediaModel]!
    
    
    // 自定义事件序列类型 
    let parameterJust = { (element:[String:Any]) -> Observable<[String:Any]> in
        return Observable.create({ observer -> Disposable in
            observer.onNext(element)
            observer.onCompleted()
            return Disposables.create()
        })
    }

    override func loadData() {
        viewModel = MTTTabMediaViewModel()
        viewModel.getMediaData(parameter: parameterJust(["name":"etiantian"]))
        
        // outputs
        viewModel.mediaModels
            .asObservable()
            .subscribe(onNext: { elements in
                
            }, onError: { error in
                
            }, onCompleted: { 
                
            }).disposed(by: disposeBag)
        viewModel.mediaModels
            .asObservable()
            .subscribe(onNext: { elements in
                self.tabMediaModels = elements
                self.tableView.reloadData()
        }, onError: { error in
            
        }, onCompleted: { 
            
        }).disposed(by: DisposeBag())
    }
    
    override init(frame: CGRect) 
    {
        super.init(frame: frame)
        self.backgroundColor = kMainRandomColor()
        self.tableView.register(MTTTabMediaCell.self, forCellReuseIdentifier: reusedMediaId)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tabMediaModels != nil ? tabMediaModels.count : 0 
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: reusedMediaId) as? MTTTabMediaCell
        
        if cell == nil 
        {
            cell = MTTTabMediaCell(style: UITableViewCellStyle.default, reuseIdentifier: reusedMediaId)
        }
        if tabMediaModels != nil
        {
            cell?.mediaModel = tabMediaModels[indexPath.item]
        }
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat 
    {
        return 150
    }

}
