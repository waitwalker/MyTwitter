//
//  MTTPhotosViewController.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/12/18.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import Photos
import RxCocoa
import RxSwift

class MTTPhotosViewController: MTTViewController {

    var photoLibraryCollectionView:UICollectionView!
    let photoIcons:[String] = ["twitter_camera_large","twittwer_video_large","twittwer_live_large"]
    let titles:[String] = ["照片","视频","直播"]
    let reusedPhotoLibraryId:String = "reusedPhotoLibraryId"
    let reusedPhotoLibraryIconId:String = "reusedPhotoLibraryIconId"
    var backButton:UIButton!
    var disposeBag = DisposeBag()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        _ = getAllPhotoCount()
        setupSubview()
        
        setupEvent()
    }
    
    
    private func setupNavigationBar() -> Void
    {
        backButton                             = UIButton()
        backButton.frame                       = CGRect(x: 0, y: 0, width: 40, height: 44)
        backButton.backgroundColor = UIColor.red
        backButton.titleEdgeInsets = UIEdgeInsetsMake(2, 0, -2, 5)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        backButton.setTitle("取消", for: UIControlState.normal)
        backButton.setTitleColor(kMainBlueColor(), for: UIControlState.normal)
        backButton.setTitleColor(kMainLightGrayColor(), for: UIControlState.highlighted)
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: backButton)
        
    }
    
    func setupEvent() -> Void
    {
        (backButton.rx.tap)
            .subscribe(onNext:{[unowned self] in
                self.dismiss(animated: true, completion: {
                    
                })
            }).disposed(by: disposeBag)
    }
    
    // MARK: - 获取相册中全部照片数量
    func getAllPhotoCount() -> Int
    {
        let fetchOptions = PHFetchOptions()
        
        let assets = PHAsset.fetchAssets( with: fetchOptions)
        
        return assets.count
    }
    
    func setupSubview() -> Void
    {
        let photoFlowLayout = UICollectionViewFlowLayout()
        photoFlowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        photoFlowLayout.minimumLineSpacing = 0
        photoFlowLayout.minimumInteritemSpacing = 0
        
        photoLibraryCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: photoFlowLayout)
        photoLibraryCollectionView.register(MTTPhotosCell.self, forCellWithReuseIdentifier: reusedPhotoLibraryId)
        photoLibraryCollectionView.register(MTTPhotosIconCell.self, forCellWithReuseIdentifier: reusedPhotoLibraryIconId)
        photoLibraryCollectionView.backgroundColor = kMainChatBackgroundGrayColor()
        photoLibraryCollectionView.delegate = self
        photoLibraryCollectionView.dataSource = self
        self.view.addSubview(photoLibraryCollectionView)
        
        setupNavigationBar()
    }
    
    func getAllPictureFromPhotoLibrary(cell:MTTPhotosCell,index:Int) -> Void
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
                    
                    cell.photoBackgroundImageView.image = image
                }
            })
        }
    }

}

extension MTTPhotosViewController:
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
{
    // MARK: - collectionView DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return getAllPhotoCount() + 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if indexPath.item <= 2
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusedPhotoLibraryIconId, for: indexPath) as! MTTPhotosIconCell
            cell.photoTitleLabel.text = titles[indexPath.item]
            cell.photoIconImageView.image = UIImage(named: photoIcons[indexPath.item])
            return cell
            
        } else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusedPhotoLibraryId, for: indexPath) as! MTTPhotosCell
            getAllPictureFromPhotoLibrary(cell: cell, index: indexPath.item - 3)
            
            return cell
        }
    }
    
    // MARK: - collectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if indexPath.item > 2
        {
            
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: kScreenWidth / 3 - 4, height: kScreenWidth / 3 - 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsetsMake(1, 1, -1, -1)
    }
}
