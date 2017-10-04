//
//  MTTPushTwitterViewController.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/9/28.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import Photos

class MTTPushTwitterViewController: MTTViewController,UITextViewDelegate ,UICollectionViewDelegate,UICollectionViewDataSource{

    var placeHolderLabel:UILabel?
    
    var rightButton:UIButton?
    var pushTextView:UITextView?
    var pushScrollContainerView:UIScrollView?
    
    var contentView:UIView?
    var pushButton:UIButton?
    var secondLine:UIView?
    
    var bottomCollectionView:UICollectionView?
    let reusedPushBottomId = "reusedPushBottomId"
    
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        addNotificationObserver()
        setupSubview()
        layoutSubview()
        setupEvent()
        addGesture()
    }
    
    func getPhotosImage(cell:MTTPushBottomCell, index:Int, isOriginal:Bool) -> Void
    {
        
        let fetchOptions = PHFetchOptions()
        let assets = PHAsset.fetchAssets( with: fetchOptions)
        print(assets.count)
        
        let manager = PHImageManager.default()
        
        let options = PHImageRequestOptions()
        
        let size = isOriginal ? PHImageManagerMaximumSize : CGSize.zero
        
        
        manager.requestImage(for: assets.object(at: index), targetSize: size, contentMode: PHImageContentMode.aspectFit, options: options) { (image, hashable) in
            print(image as Any)
            cell.backgroundImageView?.image = image
        }
        
        
        
        
        
        
    }
    
    // MARK: - 初始化控件
    func setupSubview() -> Void
    {
        setupNavBar()
        
        //pushScrollContainerView
        pushScrollContainerView = UIScrollView()
        pushScrollContainerView?.isUserInteractionEnabled = true
        pushScrollContainerView?.backgroundColor = kMainBlueColor()
        pushScrollContainerView?.isPagingEnabled = true
        pushScrollContainerView?.showsVerticalScrollIndicator = false
        pushScrollContainerView?.contentSize = CGSize(width: 0, height: kScreenHeight - 59 - 50)
        pushScrollContainerView?.isScrollEnabled = true
        self.view.addSubview(pushScrollContainerView!)
        
        //pushTextView
        pushTextView = UITextView()
        pushTextView?.placeholderText = "有什么新鲜事?"
        pushTextView?.textColor = kMainGrayColor()
        pushTextView?.backgroundColor = kMainWhiteColor()
        pushTextView?.font = UIFont.systemFont(ofSize: 20)
        pushTextView?.delegate = self
        pushTextView?.frame = CGRect(x: 20, y: 5, width: kScreenWidth - 40, height: 40)
        pushScrollContainerView?.addSubview(pushTextView!)
        
        //placeHolderLabel
        placeHolderLabel = UILabel()
        placeHolderLabel?.text = "有什么新鲜事?"
        placeHolderLabel?.textAlignment = NSTextAlignment.left
        placeHolderLabel?.textColor = kMainGrayColor()
        placeHolderLabel?.frame = CGRect(x: 3, y: 0, width: kScreenWidth - 5, height: 40)
        placeHolderLabel?.font = UIFont.systemFont(ofSize: 20)
        pushTextView?.addSubview(placeHolderLabel!)
        
        //contentView
        contentView = UIView()
        contentView?.backgroundColor = kMainWhiteColor()
        self.view.addSubview(contentView!)
        
        //secondLine
        secondLine = UIView()
        secondLine?.backgroundColor = kMainGrayColor()
        contentView?.addSubview(secondLine!)
        
        //pushButton
        pushButton = UIButton()
        pushButton?.setTitle("发推", for: UIControlState.normal)
        pushButton?.setTitleColor(kMainGrayColor(), for: UIControlState.normal)
        pushButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        pushButton?.backgroundColor = kMainBlueColor()
        pushButton?.layer.cornerRadius = 17.5
        pushButton?.clipsToBounds = true
        contentView?.addSubview(pushButton!)
        
        //bottomCollectionView
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.itemSize = CGSize(width: 70, height: 70)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5)
        
        bottomCollectionView = UICollectionView(frame: CGRect.init(x: 0, y: kScreenHeight - 50 - 90, width: kScreenWidth, height: 80), collectionViewLayout: flowLayout)
        bottomCollectionView?.delegate = self
        bottomCollectionView?.dataSource = self
        bottomCollectionView?.showsHorizontalScrollIndicator = false
        bottomCollectionView?.backgroundColor = kMainGreenColor()
        bottomCollectionView?.register(MTTPushBottomCell.self, forCellWithReuseIdentifier: reusedPushBottomId)
        self.view.addSubview(bottomCollectionView!)
        
        
    }
    
    func layoutSubview() -> Void
    {
        //pushScrollContainerView
        pushScrollContainerView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(-50)
        })
        
        //contentView
        contentView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self.view).offset(0)
            make.height.equalTo(50)
            make.bottom.equalTo(self.view).offset(0)
        })
        
        //secondLine
        secondLine?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self.contentView!).offset(0)
            make.top.equalTo(self.contentView!).offset(0)
            make.height.equalTo(0.3)
        })
        
        //pushButton
        pushButton?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.contentView!).offset(-20)
            make.height.equalTo(35)
            make.top.equalTo((self.secondLine?.snp.bottom)!).offset(7.5)
            make.width.equalTo(70)
        })
        
    }
    
    func setupNavBar() -> Void
    {
        rightButton = UIButton()
        rightButton?.setImage(UIImage.init(named: "twitter_close"), for: UIControlState.normal)
        rightButton?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        rightButton?.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightButton!)
    }
    
    // MARK: - 处理事件流
    func setupEvent() -> Void
    {
        //close
        (rightButton?.rx.tap)?.subscribe(onNext:{
            self.view.endEditing(true)
            self.navigationController?.dismiss(animated: true, completion: {
                
            })
        }).addDisposableTo(disposeBag)
        
        pushTextView?.rx.text.map({($0?.characters.count)! > 0})
            .subscribe(onNext:{ isTrue in
                
                if isTrue
                {
                    self.placeHolderLabel?.isHidden = true
                    
                    UIView.animate(withDuration: 0.2, animations: {
                        self.bottomCollectionView?.isHidden = true
                    })
                } else
                {
                    self.placeHolderLabel?.isHidden = false
                    self.bottomCollectionView?.isHidden = false
                }
                
            }).addDisposableTo(disposeBag)
        
    }
    
    // MARK: - 处理键盘
    func addNotificationObserver() -> Void
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowAction(notify:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideAction(notify:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShowAction(notify:Notification) -> Void
    {
        let userInfo = notify.userInfo
        let keyboardFrame = userInfo![UIKeyboardFrameEndUserInfoKey] as! CGRect
        UIView.animate(withDuration: 0.5, animations: {
            self.bottomCollectionView?.y = keyboardFrame.origin.y - 50 - 90
            self.contentView?.y = keyboardFrame.origin.y - 50
        }) { (completed) in
            
        }
    }
    
    @objc func keyboardWillHideAction(notify:Notification) -> Void
    {
        UIView.animate(withDuration: 0.2, animations: {
            self.bottomCollectionView?.y = kScreenHeight - 50 - 90
            
            //contentView
            self.contentView?.frame = CGRect(x: 0, y: kScreenHeight - 50, width: kScreenWidth, height: 50)
        }) { (completed) in
            
        }
    }
    
    // MARK: - 处理手势
    func addGesture() -> Void
    {
        let tap = UITapGestureRecognizer(target: self, action: #selector(pushScrollContainerViewTapAction))
        pushScrollContainerView?.addGestureRecognizer(tap)
        
    }
    
    func pushScrollContainerViewTapAction() -> Void
    {
        pushScrollContainerView?.endEditing(true)
    }

    // MARK: - UITextView Delegate
    func textViewDidChange(_ textView: UITextView)
    {
        let maxHeight:CGFloat = kScreenHeight - 50 - 236 - 64 - 10
        
        let frame = textView.frame
        
        let constraintSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        
        let size = textView.sizeThatFits(constraintSize)
        
        if size.height >= maxHeight
        {
            pushTextView?.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: textView.contentSize.width, height: maxHeight)
        } else
        {
            pushTextView?.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: textView.contentSize.width, height: textView.contentSize.height)
        }
    }
    
    // MARK: - collectionView DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusedPushBottomId, for: indexPath) as? MTTPushBottomCell
        cell?.innerImageView?.isHidden = false
        cell?.innerTitleLabel?.isHidden = false
        switch indexPath.item {
        case 0:
            cell?.innerImageView?.image = UIImage.init(named: "twitter_camera")
            cell?.innerTitleLabel?.text = "相机"
            cell?.backgroundImageView?.image = UIImage()
        case 1:
            cell?.innerImageView?.image = UIImage.init(named: "twitter_live")
            cell?.innerTitleLabel?.text = "直播"
            cell?.backgroundImageView?.image = UIImage()
        case 19:
            cell?.innerImageView?.image = UIImage.init(named: "twitter_photo")
            cell?.innerTitleLabel?.text = "库"
            cell?.backgroundImageView?.image = UIImage()
        default:
            getPhotosImage(cell: cell!, index: indexPath.item - 2, isOriginal: false)
            cell?.innerImageView?.isHidden = true
            cell?.innerTitleLabel?.isHidden = true
            
        }
        return cell!
        
    }
    
    // MARK: - collectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print("%@",indexPath)
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
}
