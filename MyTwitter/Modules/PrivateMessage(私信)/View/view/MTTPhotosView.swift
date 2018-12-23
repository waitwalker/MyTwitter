//
//  MTTPhotosView.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/12/13.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

/**********************
 选择照片滚动视图
***********************/

import UIKit
import Photos

class MTTPhotosView: MTTView
{
    
    var photoLibraryCollectionView:UICollectionView!
    let photoIcons:[String]         = ["twitter_camera_large","twittwer_video_large","twittwer_live_large"]
    let titles:[String]             = ["照片","视频","直播"]
    let reusedPhotoLibraryId:String = "reusedPhotoLibraryId"
    let reusedPhotoLibraryIconId:String = "reusedPhotoLibraryIconId"
    
    var originalY:CGFloat!
    var currentY:CGFloat!
    
    var delegate:MTTPhotosViewDelegate?
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        _ = getAllPhotoCount()
        setupGesture()
        self.originalY = frame.origin.y
    }
    
    // MARK: - 获取相册中全部照片数量
    func getAllPhotoCount() -> Int
    {
        let photoAuthStatus = shardInstance.getPhotoLibraryAuthorizationStatus()
        
        if photoAuthStatus
        {
            let fetchOptions = PHFetchOptions()
            let assets       = PHAsset.fetchAssets( with: fetchOptions)
            return assets.count
        } else
        {
            shardInstance.showAlter(with: "您还没授权访问相册,请您先去授权")
            return 0
        }
        
    }
    
    override func layoutSubview()
    {
        super.layoutSubview()
    }
    

    override func setupSubview()
    {
        let photoFlowLayout                        = UICollectionViewFlowLayout()
        photoFlowLayout.scrollDirection            = UICollectionViewScrollDirection.vertical
        photoFlowLayout.minimumLineSpacing         = 0
        photoFlowLayout.minimumInteritemSpacing    = 0

        photoLibraryCollectionView                 = UICollectionView(frame: self.bounds, collectionViewLayout: photoFlowLayout)
        photoLibraryCollectionView.register(MTTPhotosCell.self, forCellWithReuseIdentifier: reusedPhotoLibraryId)
        photoLibraryCollectionView.register(MTTPhotosIconCell.self, forCellWithReuseIdentifier: reusedPhotoLibraryIconId)
        photoLibraryCollectionView.backgroundColor = kMainChatBackgroundGrayColor()
        photoLibraryCollectionView.delegate        = self
        photoLibraryCollectionView.dataSource      = self
        self.addSubview(photoLibraryCollectionView)
    }
    
    override func layoutSubviews()
    {
        
    }
    
    func getAllPictureFromPhotoLibrary(cell:MTTPhotosCell,index:Int) -> Void
    {
        //开一个后台线程用于处理相册照片
        let photoQueue = DispatchQueue(
            label: "photoQueue", 
            qos: DispatchQoS.background, 
            attributes: DispatchQueue.Attributes.concurrent, 
            autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.never, 
            target: DispatchQueue?.none)
        photoQueue.async {
            let fetchOptions = PHFetchOptions()
            let assets       = PHAsset.fetchAssets( with: fetchOptions)
            let manager      = PHImageManager.default()
            let options      = PHImageRequestOptions()
            
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
    
    func setupGesture() -> Void
    {
        let panGes = UIPanGestureRecognizer(target: self, action: #selector(panGesAction(pan:)))
            
        self.addGestureRecognizer(panGes)
    }
    
    func panGesAction(pan:UIPanGestureRecognizer) -> Void
    {
        if pan.state == UIGestureRecognizerState.changed
        {
            let offset = pan.translation(in: self)
            if offset.y > 0
            {
                return
            }
            self.center.y = self.center.y + offset.y
            pan.setTranslation(CGPoint(x: 0,y: 0), in: self)
            
            
        }
        
        // 当滚动视图超过一定距离后 模态出控制器
        if pan.state == UIGestureRecognizerState.ended
        {
            if self.y > 250
            {
                UIView.animate(withDuration: 0.5, animations: {
                    self.y = self.originalY
                })
                
            }else
            {
                self.delegate?.photosViewDragDelegate()
            }
        }
        
    }
    
    // MARK: - touch事件会被上层捕获 事件无法穿透
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        print("开始被触摸:\(self)")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first
        let currentPoint = touch?.location(in: self.photoLibraryCollectionView)
        
        let prePoint = touch?.previousLocation(in: self.photoLibraryCollectionView)
        
        let offSetY = (currentPoint?.y)! - (prePoint?.y)!
        
        self.transform = CGAffineTransform(translationX: 0, y: offSetY)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MTTPhotosView:
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
            let cell                      = collectionView.dequeueReusableCell(withReuseIdentifier: reusedPhotoLibraryIconId, for: indexPath) as! MTTPhotosIconCell
            cell.photoTitleLabel.text     = titles[indexPath.item]
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


