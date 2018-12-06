//
//  MTTPhotoDisplayView.swift
//  MyTwitter
//
//  Created by junzi on 2018/5/1.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

import UIKit
import Kingfisher

// MARK: - MTTPhotoDisplayViewDelegate
protocol MTTPhotoDisplayViewDelegate:class {
    
    // MARK: - 选中item的回调
    func DDidSelectIndexPathAction(dataSource:[String]?,currentItem:Int?) -> Void
}

// MARK: - 图片展示View
class MTTPhotoDisplayView: UIView {
    
    private var collectionView:UICollectionView!
    
    let reusedDisplayId:String = "reusedDisplayId"
    
    weak var delegate:MTTPhotoDisplayViewDelegate?
    
    
    
    var imageStrings:[String]?
    {
        didSet{
            
            self.collectionView.height = self.height
            self.collectionView.reloadData()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        VSetupSubview()
    }
    
    func VSetupSubview() -> Void
    {
        let photoFlowLayout                         = UICollectionViewFlowLayout()
        photoFlowLayout.scrollDirection             = UICollectionViewScrollDirection.vertical
        
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: photoFlowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MTTPhotoDisplayCell.self, forCellWithReuseIdentifier: reusedDisplayId)
        self.addSubview(collectionView)
    }
    
    func VLayoutSubview() -> Void
    {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MTTPhotoDisplayView:UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.imageStrings?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusedDisplayId, for: indexPath) as? MTTPhotoDisplayCell
        if (self.imageStrings?.count)! > 0
        {
            cell?.imageURLString = self.imageStrings?[indexPath.item]
        }
        return cell!
    }
}

extension MTTPhotoDisplayView:UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.DDidSelectIndexPathAction(dataSource: self.imageStrings, currentItem: indexPath.item)
    }
}

extension MTTPhotoDisplayView:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsetsMake(20, 20, 20, 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 20
    }
}

class MTTPhotoDisplayCell: UICollectionViewCell
{
    var imageView:UIImageView!
    
    var imageURLString:String?{
        didSet{
            let placeImage = UIImage.imageNamed(name: "1.JPG")
            
            imageView.kf.setImage(with: URL(string: imageURLString!),
                                  placeholder: placeImage,
                                  options: [KingfisherOptionsInfoItem.backgroundDecode],
                                  progressBlock: { (receivedSize, totalSize) in
                                    
            }) { (image, error, catchType, url) in
                if let theImage = image
                {
                    let scaleImage = theImage.scaleImageWithWidth(expectWidth: 120, sourceImage: theImage)
                    
                    self.imageView.frame = CGRect(x: (self.contentView.width - scaleImage.size.width) / 2, y: (self.contentView.height - scaleImage.size.height) / 2, width: scaleImage.size.width, height: scaleImage.size.height)
                    
                    self.imageView.image = scaleImage
                    
                    print("imageView frame:\(self.imageView.frame)")
                }
            }
        }
    }
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        VSetupSubview()
    }
    
    func VSetupSubview() -> Void
    {
        imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.frame = self.bounds
        imageView.backgroundColor = kMainRandomColor()
        self.contentView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
