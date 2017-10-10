//
//  MTTLocationViewController.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/10/9.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTLocationViewController: MTTViewController,UITableViewDelegate,UITableViewDataSource
{

    typealias locationRemoveCallBack = (_ isRemove:Bool) -> ()
    typealias locationFinishCallBack = (_ place:String) -> ()
    
    var locationTableView:UITableView?
    var locationBottomContainerView:UIView?
    var locationLineView:UIView?
    var locationSwitch:UISwitch?
    var locationLatitudeLongitudeLabel:UILabel?
    var locationShareLabel:UILabel?
    
    
    var leftButton:UIButton?
    var rightButton:UIButton?
    
    
    
    
    
    var places:[String]?
    var latitude:Double?
    var longitude:Double?
    var placeString:String?
    var latitudelongitudeString:String?
    var removeCallBack:locationRemoveCallBack?
    var finishCallBack:locationFinishCallBack?
    
    var selectedIndexPath:IndexPath?
    
    
    
    let reusedLocationId = "reusedLocationId"
    let reusedLocationSearchId = "reusedLocationSearchId" 
    
    
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupSubview()
        layoutSubview()
        setupEvent()

    }
    
    private func setupSubview() -> Void
    {
        locationTableView = UITableView()
        locationTableView?.delegate = self
        locationTableView?.dataSource = self
        locationTableView?.register(
            MTTLocationCell.self, forCellReuseIdentifier: reusedLocationId)
        locationTableView?.register(MTTLocationSearchCell.self, forCellReuseIdentifier: reusedLocationSearchId)
        locationTableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        self.view.addSubview(locationTableView!)
        
        locationBottomContainerView = UIView()
        self.view.addSubview(locationBottomContainerView!)
        
        locationLineView = UIView()
        locationLineView?.backgroundColor = kMainGrayColor()
        locationBottomContainerView?.addSubview(locationLineView!)
        
        locationShareLabel = UILabel()
        locationShareLabel?.text = "分享准确位置"
        locationShareLabel?.textColor = UIColor.black
        locationShareLabel?.textAlignment = NSTextAlignment.left
        locationShareLabel?.font = UIFont.systemFont(ofSize: 15)
        locationBottomContainerView?.addSubview(locationShareLabel!)
        
        locationLatitudeLongitudeLabel = UILabel()
        locationLatitudeLongitudeLabel?.textAlignment = NSTextAlignment.left
        locationLatitudeLongitudeLabel?.font = UIFont.systemFont(ofSize: 14)
        locationLatitudeLongitudeLabel?.textColor = kMainGrayColor()
        locationLatitudeLongitudeLabel?.text = latitudelongitudeString
        locationBottomContainerView?.addSubview(locationLatitudeLongitudeLabel!)
        
        locationSwitch = UISwitch()
        locationSwitch?.addTarget(self, action: #selector(locationSwitchAction(locationSwitch:)), for: UIControlEvents.touchUpInside)
        locationSwitch?.isOn = false
        locationBottomContainerView?.addSubview(locationSwitch!)
        
        setupNavigationBar()
    }
    
    @objc func locationSwitchAction(locationSwitch:UISwitch) -> Void 
    {
        
    }
    
    private func layoutSubview() -> Void
    {
        locationTableView?.snp.makeConstraints({ (make) in
            make.left.right.top.equalTo(0)
            make.bottom.equalTo(-50)
        })
        
        locationBottomContainerView?.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(50)
        })
        
        locationLineView?.snp.makeConstraints({ (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(0.3)
        })
        
        locationShareLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.top.equalTo(5)
            make.height.equalTo(20)
            make.width.equalTo(200)
        })
        
        locationLatitudeLongitudeLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.top.equalTo((self.locationShareLabel?.snp.bottom)!).offset(0)
            make.width.equalTo(200)
            make.height.equalTo(20)
        })
        
        locationSwitch?.snp.makeConstraints({ (make) in
            make.right.equalTo((self.locationBottomContainerView?.snp.right)!).offset(-40)
            make.height.equalTo(20)
            make.width.equalTo(30)
            make.top.equalTo(10)
        })
    }
    
    private func setupEvent() -> Void 
    {
        (leftButton?.rx.tap)?.subscribe(onNext:{[unowned self] in
            
            self.dismiss(animated: true, completion: { 
                self.removeCallBack!(true)
            })
            
        }).addDisposableTo(disposeBag)
        
        (rightButton?.rx.tap)?.subscribe(onNext:{[unowned self] in
            
            if self.placeString?.characters.count == 0
            {
                self.placeString = self.places?.first
            }
            
            self.dismiss(animated: true, completion: { 
                
                print(self.placeString as Any)
                
                self.finishCallBack!(self.placeString!)
            })
        }).addDisposableTo(disposeBag)
    }
    
    private func setupNavigationBar() -> Void 
    {
        leftButton = UIButton()
        leftButton?.setTitle("移除", for: UIControlState.normal)
        leftButton?.setTitleColor(kMainBlueColor(), for: UIControlState.normal)
        leftButton?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        leftButton?.frame = CGRect(x: 0, y: 0, width: 40, height: 44)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftButton!)
        
        rightButton = UIButton()
        rightButton?.setTitle("完成", for: UIControlState.normal)
        rightButton?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        rightButton?.setTitleColor(kMainBlueColor(), for: UIControlState.normal)
        rightButton?.frame = CGRect(x: 0, y: 0, width: 40, height: 44)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightButton!)
        
        self.navigationItem.title = "标记位置"
    }
    
    // MARK: - tabelView DataSource
    func numberOfSections(in tableView: UITableView) -> Int 
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        return (places?.count)! + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        switch indexPath.item 
        {
        case 0:
            var cell = tableView.dequeueReusableCell(withIdentifier: reusedLocationSearchId) as? MTTLocationSearchCell
            if cell == nil 
            {
                cell = MTTLocationSearchCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedLocationSearchId)
            }
            return cell!
        default:
            
            var cell = tableView.dequeueReusableCell(withIdentifier: reusedLocationId) as? MTTLocationCell
            if cell == nil 
            {
                cell = MTTLocationCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reusedLocationId)
            }
            
            if selectedIndexPath == indexPath
            {
                cell?.locationImageView?.isHidden = false
            } else
            {
                cell?.locationImageView?.isHidden = true
            }
            
            cell?.locationTitleLabel?.text = places?[indexPath.item - 1]
            
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) 
    {
        if indexPath.item > 0 
        {
            let cell = tableView.cellForRow(at: indexPath) as! MTTLocationCell
            placeString = cell.locationTitleLabel?.text
            cell.locationImageView?.isHidden = false
            selectedIndexPath = indexPath
            tableView.reloadData()
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) 
    {
        if indexPath.item > 0 
        {
            let cell = tableView.cellForRow(at: indexPath) as! MTTLocationCell
            cell.locationImageView?.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat 
    {
        return 50
    }

}
