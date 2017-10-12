//
//  MTTPhotoLibraryViewController.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/10/11.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import Photos

class MTTPhotoLibraryViewController: MTTViewController ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    var photos:[UIImage]?
    
    var photoLibraryCollectionView:UICollectionView?
    var leftButton:UIButton?
    var rightButton:UIButton?
    
    var photoIcons:[String] = ["twitter_camera_large","twittwer_video_large","twittwer_live_large"]
    var titles:[String] = ["照片","视频","直播"]
    
    var selectedIndexPath:IndexPath?
    var isHiddenSelected:Bool?
    var selectedColor:UIColor?
    
    
    
    
    
    let reusedPhotoLibraryId = "reusedPhotoLibraryId"
    let reusedPhotoLibraryIconId = "reusedPhotoLibraryIconId"
    
    
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        setupSubview()
        layoutSubview()
        setupEvent()

    }
    
    override func viewWillAppear(_ animated: Bool) 
    {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - 获取相册中全部照片
    func getAllPhotoCount() -> Int 
    {
        let fetchOptions = PHFetchOptions()
        
        let assets = PHAsset.fetchAssets( with: fetchOptions)
        
        return assets.count
    }
    
    func getAllPictureFromPhotoLibrary(cell:MTTPhotoLibraryCell,index:Int) -> Void 
    {
        //开一个后台线程用于处理相册照片
        let photoQueue = DispatchQueue(label: "photoQueue", qos: DispatchQoS.background, attributes: DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.never, target: DispatchQueue?.none)
        photoQueue.async {
            let fetchOptions = PHFetchOptions()
            
            let assets = PHAsset.fetchAssets( with: fetchOptions)
            
            let manager = PHImageManager.default()
            
            let options = PHImageRequestOptions()
            
            manager.requestImage(for: assets.object(at: index), targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.aspectFit, options: options, resultHandler: { (image, hashable) in
                
                //压缩之后 有些卡 待优化
                //let imageData = UIImageJPEGRepresentation(image!, 0.5)
                //let newImage = UIImage(data: imageData!)
                DispatchQueue.main.async {
                    
                    cell.photoBackgroundImageView?.image = image
                }
            })
        }
    }
    
    private func setupSubview() -> Void 
    {
        let photoFlowLayout = UICollectionViewFlowLayout()
        photoFlowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        photoFlowLayout.minimumLineSpacing = 0
        photoFlowLayout.minimumInteritemSpacing = 0
        
        photoLibraryCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: photoFlowLayout)
        photoLibraryCollectionView?.register(MTTPhotoLibraryCell.self, forCellWithReuseIdentifier: reusedPhotoLibraryId)
        photoLibraryCollectionView?.register(MTTPhotoLibraryIconCell.self, forCellWithReuseIdentifier: reusedPhotoLibraryIconId)
        photoLibraryCollectionView?.backgroundColor = kMainWhiteColor()
        photoLibraryCollectionView?.delegate = self
        photoLibraryCollectionView?.dataSource = self
        self.view.addSubview(photoLibraryCollectionView!)
        
        setupNavigationBar()
    }
    
    private func layoutSubview() -> Void 
    {
        
    }
    
    private func setupNavigationBar() -> Void 
    {
        leftButton = UIButton()
        leftButton?.setTitle("取消", for: UIControlState.normal)
        leftButton?.setTitleColor(kMainBlueColor(), for: UIControlState.normal)
        leftButton?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        leftButton?.frame = CGRect(x: 0, y: 0, width: 40, height: 44)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftButton!)
        
        rightButton = UIButton()
        rightButton?.setTitle("添加", for: UIControlState.normal)
        rightButton?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        rightButton?.setTitleColor(kMainLightGrayColor(), for: UIControlState.normal)
        rightButton?.isEnabled = false
        rightButton?.frame = CGRect(x: 0, y: 0, width: 40, height: 44)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightButton!)
        
        self.navigationItem.title = "全部照片"
    }
    
    func setupEvent() -> Void 
    {
        leftButton?.rx.tap.subscribe(onNext:{ [unowned self] in
            self.dismiss(animated: true, completion: { 
                
            })
        }).addDisposableTo(disposeBag)
    }
    
    // MARK: - collectionView DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int 
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int 
    {
        return getAllPhotoCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell 
    {
        if indexPath.item <= 2 
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusedPhotoLibraryIconId, for: indexPath) as! MTTPhotoLibraryIconCell
            cell.photoTitleLabel?.text = titles[indexPath.item]
            cell.photoIconImageView?.image = UIImage(named: photoIcons[indexPath.item])
            return cell
            
        } else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusedPhotoLibraryId, for: indexPath) as! MTTPhotoLibraryCell
            getAllPictureFromPhotoLibrary(cell: cell, index: indexPath.item - 3)
            if selectedIndexPath == indexPath
            {
                cell.photoSelectedCoverView?.isHidden = isHiddenSelected!
                cell.photoBackgroundView?.backgroundColor = isHiddenSelected! ? kMainLightGrayColor() : kMainGreenColor()
            } else
            {
                cell.photoSelectedCoverView?.isHidden = true
                cell.photoBackgroundView?.backgroundColor = kMainLightGrayColor()
            }
            
            return cell
        }
    }
    
    // MARK: - collectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) 
    {
        if indexPath.item > 2
        {
            selectedIndexPath = indexPath
            let cell = collectionView.cellForItem(at: indexPath) as! MTTPhotoLibraryCell
            
            if (cell.photoSelectedCoverView?.isHidden)! == true
            {
                cell.photoSelectedCoverView?.isHidden = false
                cell.photoBackgroundView?.backgroundColor = kMainGreenColor()
            } else
            {
                cell.photoSelectedCoverView?.isHidden = true
                cell.photoBackgroundView?.backgroundColor = kMainLightGrayColor()
            }
            isHiddenSelected = cell.photoSelectedCoverView?.isHidden
            collectionView.reloadItems(at: [indexPath])
            
            rightButton?.setTitleColor(kMainBlueColor(), for: UIControlState.normal)
            rightButton?.isEnabled = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize 
    {
        return CGSize(width: kScreenWidth / 3, height: kScreenWidth / 3)
    }
    
    
    

    override func didReceiveMemoryWarning() 
    {
        super.didReceiveMemoryWarning()
    }
    


}
