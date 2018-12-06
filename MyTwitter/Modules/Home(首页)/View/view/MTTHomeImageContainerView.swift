//
//  MTTHomeImageContainerView.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/9/25.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTHomeImageContainerView: MTTView,UIScrollViewDelegate
{
    var delegate:MTTHomeImageCellImageViewDelegate?
    
    var imageBackgroundView:UIView?
    var imageScrollView:UIScrollView?
    var imagePreview:UIImageView?

    
    
    var homeImagesArray: [String]?
    {
        didSet
        {
            self.setupSubview()
        }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupSubview()
    {
        let margin:CGFloat          = 5.0
        let imageViewWidth          = (kScreenWidth - 80 - 10 - 5) / 2
        let imageViewHeight:CGFloat = (150.0 - 5.0) / 2
        
        
        switch homeImagesArray?.count {
        case 1?:
            
            let imageView                      = UIImageView()
            imageView.isUserInteractionEnabled = true
            imageView.layer.shouldRasterize    = true
            imageView.image                    = UIImage(named: String(format: "%@.JPG", (self.homeImagesArray?.first)!))
            self.addSubview(imageView)
            imageView.frame                    = CGRect(x: 0, y: 0, width: imageViewWidth * 2 + 5, height: 150)

            let tap                            = UITapGestureRecognizer.init(target: self, action: #selector(imageViewTapAction(tap:)))
            imageView.addGestureRecognizer(tap)
            
            break
        case 2?:
            
            for i in 0...1
            {
                let imageView                      = UIImageView()
                imageView.isUserInteractionEnabled = true
                imageView.layer.shouldRasterize    = true
                imageView.tag                      = i
                imageView.image                    = UIImage(named: String(format: "%@.JPG", (self.homeImagesArray![i])))
                self.addSubview(imageView)

                imageView.frame                    = CGRect(x: (margin + imageViewWidth) * CGFloat(i), y: 0, width: imageViewWidth, height: 150)
                let tap                            = UITapGestureRecognizer.init(target: self, action: #selector(imageViewTapAction(tap:)))
                imageView.addGestureRecognizer(tap)
            }
            
            break
        case 3?:
            for i in 0...2
            {
                let imageView                      = UIImageView()
                imageView.isUserInteractionEnabled = true
                imageView.layer.shouldRasterize    = true
                imageView.tag                      = i
                imageView.image                    = UIImage(named: String(format: "%@.JPG", (self.homeImagesArray![i])))
                self.addSubview(imageView)
                
                if i == 0
                {
                    imageView.frame = CGRect(x: (margin + imageViewWidth) * CGFloat(i), y: 0, width: imageViewWidth, height: 150)
                } else if i == 1
                {
                    imageView.frame = CGRect(x: (margin + imageViewWidth) * CGFloat(i), y: (margin + imageViewHeight) * CGFloat(i - 1), width: imageViewWidth, height: imageViewHeight)
                } else 
                {
                    imageView.frame = CGRect(x: (margin + imageViewWidth) * CGFloat(i - 1), y: (margin + imageViewHeight) * CGFloat(i - 1), width: imageViewWidth, height: imageViewHeight)
                }
                let tap = UITapGestureRecognizer.init(target: self, action: #selector(imageViewTapAction(tap:)))
                imageView.addGestureRecognizer(tap)
                
            }
            break
        case 4?:
            for i in 0...3
            {
                let imageView                      = UIImageView()
                imageView.isUserInteractionEnabled = true
                imageView.layer.shouldRasterize    = true
                imageView.tag                      = i
                imageView.image                    = UIImage(named: String(format: "%@.JPG", (self.homeImagesArray![i])))
                self.addSubview(imageView)
                
                if i < 2
                {
                    imageView.frame = CGRect(x: (margin + imageViewWidth) * CGFloat(i), y: 0, width: imageViewWidth, height: imageViewHeight)
                } else
                {
                    imageView.frame = CGRect(x: (margin + imageViewWidth) * CGFloat(i - 2), y: (margin + imageViewHeight), width: imageViewWidth, height: imageViewHeight)
                }
                let tap = UITapGestureRecognizer.init(target: self, action: #selector(imageViewTapAction(tap:)))
                imageView.addGestureRecognizer(tap)
            }
            
            break
        default:
            break
        }
    }
    
    override func layoutSubview()
    {
        
    }
    
    // MARK: - 缩略图的单击
    @objc func imageViewTapAction(tap:UITapGestureRecognizer) -> Void 
    {
        let imageView = tap.view as! UIImageView
        
        self.addPreview(imageViewPara: imageView)
    }
    
    private func addPreview(imageViewPara:UIImageView) -> Void
    {
        let appDelegate                                = UIApplication.shared.delegate
        appDelegate?.window??.isUserInteractionEnabled = true
        imageBackgroundView                            = UIView()
        imageBackgroundView?.frame                     = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        imageBackgroundView?.backgroundColor           = kMainRandomColor()
        appDelegate?.window??.addSubview(imageBackgroundView!)

        imageScrollView                                = UIScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        imageScrollView?.maximumZoomScale              = 2
        imageScrollView?.minimumZoomScale              = 0.5
        imageScrollView?.delegate                      = self
        imageScrollView?.isUserInteractionEnabled      = true
        imageScrollView?.contentSize                   = CGSize(width: kScreenWidth * CGFloat((homeImagesArray?.count)!), height: 0)
        imageScrollView?.isPagingEnabled               = true
        imageBackgroundView?.addSubview(imageScrollView!)
        
        for i in Int(0)...(homeImagesArray?.count)! - 1
        {
            let imageView                      = UIImageView()
            imageView.isUserInteractionEnabled = true

            imageView.tag                      = i
            imageView.image                    = UIImage(named: String(format: "%@.JPG", (self.homeImagesArray![i])))
            let size                           = imageView.image?.size
            let scale:CGFloat                  = (size?.width)! / (size?.height)!

            imageView.frame                    = CGRect(x: CGFloat(i) * kScreenWidth, y: 0, width: kScreenWidth, height: scale * kScreenWidth)
            imageView.frame.origin.y           = (kScreenHeight - imageView.frame.size.height) / 2
            imageScrollView?.addSubview(imageView)
            let tap                            = UITapGestureRecognizer.init(target: self, action: #selector(tapGesAction(tap:)))
            tap.numberOfTapsRequired           = 1
            imageView.addGestureRecognizer(tap)

            let doubleTap                      = UITapGestureRecognizer.init(target: self, action: #selector(doubleTapAction(doubleTap:)))
            doubleTap.numberOfTapsRequired     = 2
            imageView.addGestureRecognizer(doubleTap)

            tap.require(toFail: doubleTap)
        }
        
        imageScrollView?.contentOffset = CGPoint(x: kScreenWidth * CGFloat(imageViewPara.tag), y: (imageScrollView?.frame.origin.y)!)
    }
    
    // MARK: - 预览图的单击
    @objc func tapGesAction(tap:UITapGestureRecognizer) -> Void
    {
        imageBackgroundView?.removeFromSuperview()
    }
    
    // MARK: - 预览图的双击
    func doubleTapAction(doubleTap:UITapGestureRecognizer) -> Void
    {
        imagePreview = (doubleTap.view as! UIImageView)
        
        if (imageScrollView?.zoomScale)! >= CGFloat(2.0)
        {
            imageScrollView?.setZoomScale(1.0, animated: true)
        }else
        {
            let touchPoint   = doubleTap.location(in: imagePreview)
            
            let w = (imageScrollView?.bounds.size.width)! / 2
            let h = (imageScrollView?.bounds.size.height)! / 2
            let x = touchPoint.x - (w / 2.0)
            let y = touchPoint.y - (h / 2.0)
            
            let newZoomScale = imageScrollView?.maximumZoomScale
            let xsize        = kScreenWidth / newZoomScale!
            let ysize        = kScreenHeight / newZoomScale!
            
            
            imageScrollView?.zoom(to: CGRect(x: x, y: y, width: w, height: h), animated: true)
            
            //imageScrollView?.zoom(to: CGRect.init(x:touchPoint.x - xsize / 2, y:touchPoint.y - ysize / 2, width:xsize, height:ysize), animated: true)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView?
    {
        return imagePreview
    }
    
}
