//
//  MTTPhotoBrowserView.swift
//  MyTwitter
//
//  Created by junzi on 2018/4/30.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

import UIKit

class MTTPhotoBrowserView: UIView {
    
    let reusedPhotoBrowserId:String = "reusedPhotoBrowserId"
    
    var pageControl:UIPageControl!
    
    
    /// 容器layout
    private lazy var flowLayout: MTTPhotoBrowserLayout = {
        return MTTPhotoBrowserLayout()
    }()
    
    var collectionView:UICollectionView!
    
    init(dataSource:[String]) {
        super.init(frame: UIScreen.main.bounds)
        self.frame = UIScreen.main.bounds
        self.backgroundColor = UIColor.white
        VSetupSubview()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func VSetupSubview() -> Void
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
        pageControl.numberOfPages = 20
        self.addSubview(pageControl)
        self.bringSubview(toFront: pageControl)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
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
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusedPhotoBrowserId, for: indexPath) as! MTTPhotoBrowserCell
        
        return cell
    }
    
}

extension MTTPhotoBrowserView:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: kScreenWidth, height: kScreenHeight)
    }
    
}

extension MTTPhotoBrowserView:UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("current index:\(indexPath.item)")
    }
}


class MTTPhotoBrowserLayout: UICollectionViewFlowLayout {
    
    /// 一页宽度，算上空隙
    private var pageWidth: CGFloat {
        return self.itemSize.width + self.minimumLineSpacing
    }
    
    /// 上次页码
    private lazy var lastPage: CGFloat = {
        guard let offsetX = self.collectionView?.contentOffset.x else {
            return 0
        }
        return round(offsetX / self.pageWidth)
    }()
    
    /// 最小页码
    private let minPage: CGFloat = 0
    
    /// 最大页码
    private lazy var maxPage: CGFloat = {
        guard var contentWidth = self.collectionView?.contentSize.width else {
            return 0
        }
        contentWidth += self.minimumLineSpacing
        return contentWidth / self.pageWidth - 1
    }()
    
    override init() {
        super.init()
        scrollDirection = .horizontal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 调整scroll停下来的位置
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        // 页码
        var page = round(proposedContentOffset.x / pageWidth)
        // 处理轻微滑动
        if velocity.x > 0.2 {
            page += 1
        } else if velocity.x < -0.2 {
            page -= 1
        }
        
        // 一次滑动不允许超过一页
        if page > lastPage + 1 {
            page = lastPage + 1
        } else if page < lastPage - 1 {
            page = lastPage - 1
        }
        if page > maxPage {
            page = maxPage
        } else if page < minPage {
            page = minPage
        }
        lastPage = page
        return CGPoint(x: page * pageWidth, y: 0)
    }
}

class MTTPhotoBrowserCell: UICollectionViewCell {
    
    var imageView:UIImageView!
    var containerScrollView:UIScrollView!
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = kMainRandomColor()
        
        //VSetupSubview()
    }
    
    private func VSetupSubview() -> Void
    {
        containerScrollView = UIScrollView()
        containerScrollView.maximumZoomScale = 2.0
        containerScrollView.minimumZoomScale = 0.5
        containerScrollView.frame = contentView.frame
        contentView.addSubview(containerScrollView)
        
        let image = UIImage.imageNamed(name: String(format: "%d", Int(arc4random_uniform(10))))
        
        
        imageView = UIImageView()
        imageView.image = image
        imageView.frame = containerScrollView.bounds//CGRect(x: (containerScrollView.width - image.size.width) / 2, y: (containerScrollView.height - image.size.height) / 2, width: image.size.width, height: image.size.height)
        containerScrollView.addSubview(imageView)
        
        // 长按手势
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(onLongPress(_:)))
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
        let pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        //pan.delegate = self
        containerScrollView.addGestureRecognizer(pan)
    }
    
    /// 响应单击
    @objc func onSingleTap() {
//        if let dlg = photoBrowserCellDelegate {
//            dlg.photoBrowserCell(self, didSingleTap: imageView.image)
//        }
        
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
//        if press.state == .began, let dlg = photoBrowserCellDelegate, let image = imageView.image {
//            dlg.photoBrowserCell(self, didLongPressWith: image)
//        }
    }
    
    private func VLayoutSubview() -> Void
    {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

