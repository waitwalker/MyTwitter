//
//  MTTPhotoBrowserView.swift
//  MyTwitter
//
//  Created by junzi on 2018/4/30.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

import UIKit
import Kingfisher


// MARK: - 图片浏览器delegate
protocol MTTPhotoBrowserViewDelegate:class {
    
    func DBrowserViewSingleTapAction() -> Void
    
    func DBrowserViewLongPressAction(image:UIImage?) -> Void
    
}

// MARK: - 图片浏览器视图 
class MTTPhotoBrowserView: UIView {
    
    weak var delegate:MTTPhotoBrowserViewDelegate?
    
    let reusedPhotoBrowserId:String = "reusedPhotoBrowserId"
    
    var pageControl:UIPageControl!
    
    
    var collectionView:UICollectionView!
    
    var dataSources:[String]!
    
    
    init(dataSource:[String]?, currentItem:Int?) {
        super.init(frame: UIScreen.main.bounds)
        self.frame = UIScreen.main.bounds
        self.backgroundColor = UIColor.white
        dataSources = dataSource
        VSetupSubview(dataSource: dataSource,currentItem: currentItem)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func VSetupSubview(dataSource:[String]?, currentItem:Int?) -> Void
    {
        let photoFlowLayout                         = UICollectionViewFlowLayout()
        photoFlowLayout.scrollDirection             = UICollectionViewScrollDirection.horizontal
        photoFlowLayout.minimumLineSpacing          = 0
        photoFlowLayout.minimumInteritemSpacing     = 0
        
        collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: photoFlowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MTTPhotoBrowserCell.self, forCellWithReuseIdentifier: reusedPhotoBrowserId)
        self.addSubview(collectionView)
        
        pageControl = UIPageControl(frame: CGRect(x: (kScreenWidth - 180) / 2, y: kScreenHeight - 80, width: 180, height: 50))
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = kMainBlueColor()
        pageControl.numberOfPages = (dataSource?.count)!
        pageControl.currentPage = currentItem!
        self.addSubview(pageControl)
        self.bringSubview(toFront: pageControl)
        
        collectionView.scrollToItem(at: IndexPath(item: currentItem!, section: 0), at: UICollectionViewScrollPosition.right, animated: true)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("图片浏览器被移除")
    }
    
}

extension MTTPhotoBrowserView:UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let width = scrollView.frame.width
        pageControl.currentPage = Int(offsetX / width + 0.5)
        self.bringSubview(toFront: pageControl)
    }
}

extension MTTPhotoBrowserView:UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSources.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusedPhotoBrowserId, for: indexPath) as! MTTPhotoBrowserCell
        cell.delegate = self
        cell.imageURLString = self.dataSources[indexPath.item]
        return cell
    }
    
}

extension MTTPhotoBrowserView: MTTPhotoBrowserCellDelegate
{
    func DLongPressActionCallBack(image: UIImage?) {
        delegate?.DBrowserViewLongPressAction(image: image)
    }
    
    func DSingleTapActionCallBack() {
        
        delegate?.DBrowserViewSingleTapAction()
        
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MTTPhotoBrowserView:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: kScreenWidth, height: kScreenHeight)
    }
    
}

// MARK: - UICollectionViewDelegate
extension MTTPhotoBrowserView:UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("current index:\(indexPath.item)")
    }
}

// MARK: - MTTPhotoBrowserCell
class MTTPhotoBrowserCell: UICollectionViewCell {
    
    weak var delegate:MTTPhotoBrowserCellDelegate?
    
    var imageURLString:String?{
        didSet{
            
            let placeImage = UIImage.imageNamed(name: "1.JPG")
            imageView.kf.setImage(with: URL(string: imageURLString!),
                                  placeholder: placeImage,
                                  options: [KingfisherOptionsInfoItem.backgroundDecode],
                                  progressBlock: { (receivedSize, totalSize) in
                                    
                                    print("当前图片下载进度:\(receivedSize)")
                                    
            }) { (image, error, cacheType, url) in
                
                if let theImage = image
                {
                    let scaleImage = theImage.scaleImageWithWidth(expectWidth: kScreenWidth, sourceImage: theImage)
                    
                    self.imageView.frame = CGRect(x: (self.containerScrollView.width - scaleImage.size.width) / 2, y: (self.containerScrollView.height - scaleImage.size.height) / 2, width: scaleImage.size.width, height: scaleImage.size.height)
                    self.imageView.center = self.contentView.center
                    
                    self.imageView.image = scaleImage
                    
                    print("imageView frame:\(self.imageView.frame)")
                }
            }
        }
    }
    
    
    /// 取图片适屏frame
    private var fitFrame: CGRect {
        let size = fitSize
        let y = (containerScrollView.bounds.height - size.height) > 0 ? (containerScrollView.bounds.height - size.height) * 0.5 : 0
        return CGRect(x: 0, y: y, width: size.width, height: size.height)
    }
    
    /// 计算contentSize应处于的中心位置
    var centerOfContentSize: CGPoint {
        let deltaWidth = bounds.width - containerScrollView.contentSize.width
        let offsetX = deltaWidth > 0 ? deltaWidth * 0.5 : 0
        let deltaHeight = bounds.height - containerScrollView.contentSize.height
        let offsetY = deltaHeight > 0 ? deltaHeight * 0.5 : 0
        return CGPoint(x: containerScrollView.contentSize.width * 0.5 + offsetX,
                       y: containerScrollView.contentSize.height * 0.5 + offsetY)
    }
    
    /// 取图片适屏size
    private var fitSize: CGSize {
        guard let image = imageView.image else {
            return CGSize.zero
        }
        let width = containerScrollView.bounds.width
        let scale = image.size.height / image.size.width
        return CGSize(width: width, height: scale * width)
    }
    
    var imageView:UIImageView!
    var containerScrollView:UIScrollView!
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        //self.contentView.backgroundColor = kMainRandomColor()
        
        VSetupSubview()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        VLayoutSubview()
    }
    
    
    private func VLayoutSubview() -> Void
    {
        containerScrollView.frame = contentView.bounds
        containerScrollView.setZoomScale(1.0, animated: false)
    }
    
    private func VSetupSubview() -> Void
    {
        containerScrollView = UIScrollView()
        containerScrollView.maximumZoomScale = 2.0
        containerScrollView.minimumZoomScale = 1.0
        containerScrollView.delegate = self
        containerScrollView.backgroundColor = kMainRedColor()
        containerScrollView.showsVerticalScrollIndicator = false
        containerScrollView.showsHorizontalScrollIndicator = false
        
        contentView.addSubview(containerScrollView)
        
        
        
        imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        containerScrollView.addSubview(imageView)
        
        // 长按手势
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(onLongPress(_:)))
        longPress.minimumPressDuration = 1.0
        contentView.addGestureRecognizer(longPress)
        
        // 双击手势
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(onDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        contentView.addGestureRecognizer(doubleTap)
        
        // 单击手势
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(onSingleTap))
        contentView.addGestureRecognizer(singleTap)
        singleTap.require(toFail: doubleTap)
        
        // 拖动手势
        //let pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        //pan.delegate = self
        //containerScrollView.addGestureRecognizer(pan)
    }
    
    /// 响应单击
    @objc func onSingleTap() {
        
        delegate?.DSingleTapActionCallBack()
        
    }
    
    /// 响应双击
    @objc func onDoubleTap(_ dbTap: UITapGestureRecognizer) {
        // 如果当前没有任何缩放，则放大到目标比例
        // 否则重置到原比例
        if containerScrollView.zoomScale == 1.0 {
            // 以点击的位置为中心，放大
            let pointInView = dbTap.location(in: imageView)
            let w = containerScrollView.bounds.size.width / 2
            let h = containerScrollView.bounds.size.height / 2
            let x = pointInView.x - (w / 2.0)
            let y = pointInView.y - (h / 2.0)
            containerScrollView.zoom(to: CGRect(x: x, y: y, width: w, height: h), animated: true)
        } else {
            containerScrollView.setZoomScale(1.0, animated: true)
        }
    }
    
    /// 响应拖动
    @objc func onPan(_ pan: UIPanGestureRecognizer) {
//        guard imageView.image != nil else {
//            return
//        }
//
//        var results: (CGRect, CGFloat) {
//            // 拖动偏移量
//            let translation = pan.translation(in: scrollView)
//            let currentTouch = pan.location(in: scrollView)
//
//            // 由下拉的偏移值决定缩放比例，越往下偏移，缩得越小。scale值区间[0.3, 1.0]
//            let scale = min(1.0, max(0.3, 1 - translation.y / bounds.height))
//
//            let width = beganFrame.size.width * scale
//            let height = beganFrame.size.height * scale
//
//            // 计算x和y。保持手指在图片上的相对位置不变。
//            // 即如果手势开始时，手指在图片X轴三分之一处，那么在移动图片时，保持手指始终位于图片X轴的三分之一处
//            let xRate = (beganTouch.x - beganFrame.origin.x) / beganFrame.size.width
//            let currentTouchDeltaX = xRate * width
//            let x = currentTouch.x - currentTouchDeltaX
//
//            let yRate = (beganTouch.y - beganFrame.origin.y) / beganFrame.size.height
//            let currentTouchDeltaY = yRate * height
//            let y = currentTouch.y - currentTouchDeltaY
//
//            return (CGRect(x: x, y: y, width: width, height: height), scale)
//        }
//
//        switch pan.state {
//        case .began:
//            beganFrame = imageView.frame
//            beganTouch = pan.location(in: scrollView)
//        case .changed:
//            let r = results
//            imageView.frame = r.0
//
//            // 通知代理，发生了缩放。代理可依scale值改变背景蒙板alpha值
//            if let dlg = photoBrowserCellDelegate {
//                dlg.photoBrowserCell(self, didPanScale: r.1)
//            }
//        case .ended, .cancelled:
//            if pan.velocity(in: self).y > 0 {
//                // dismiss
//                enableLayout = false
//                imageView.frame = results.0
//                onSingleTap()
//            } else {
//                // 取消dismiss
//                endPan()
//            }
//        default:
//            endPan()
//        }
    }
    
    private func endPan() {
//        if let dlg = photoBrowserCellDelegate {
//            dlg.photoBrowserCell(self, didPanScale: 1.0)
//        }
//        // 如果图片当前显示的size小于原size，则重置为原size
//        let size = fitSize
//        let needResetSize = imageView.bounds.size.width < size.width
//            || imageView.bounds.size.height < size.height
//        UIView.animate(withDuration: 0.25) {
//            self.imageView.center = self.centerOfContentSize
//            if needResetSize {
//                self.imageView.bounds.size = size
//            }
//        }
    }
    
    /// 响应长按
    @objc func onLongPress(_ press: UILongPressGestureRecognizer) {
        
        if press.state == UIGestureRecognizerState.began
        {
            delegate?.DLongPressActionCallBack(image: imageView.image)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MTTPhotoBrowserCell:UIScrollViewDelegate
{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        imageView.center = centerOfContentSize
    }
}

// MARK: - cell delegate
protocol MTTPhotoBrowserCellDelegate:class {
    
    func DSingleTapActionCallBack() -> Void
    
    func DLongPressActionCallBack(image:UIImage?) -> Void
}

