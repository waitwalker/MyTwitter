//
//  MTTPushTwitterViewController.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/9/28.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

/*
    细节容错判断完善 超过20个 小于20个的
 
 */

import UIKit
import Photos

private let pushLogger = MTTLogger.homeLogger

class MTTPushTwitterViewController: MTTViewController,UITextViewDelegate ,UICollectionViewDelegate,UICollectionViewDataSource , MTTPushImageViewDelegate , CLLocationManagerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MTTPushNewTwitterDelegate{

    var placeHolderLabel:UILabel?
    
    var leftButton:UIButton?
    var rightButton:UIButton?
    var pushTextView:UITextView = UITextView()
    var pushScrollContainerView:UIScrollView?
    
    var contentView:UIView?
    var pictureButton:UIButton?
    var gifButton:UIButton?
    var voteButton:UIButton?
    var locationButton:UIButton?
    var textCountLabel:UILabel?
    
    
    var pushButton:UIButton?
    var secondLine:UIView?
    
    var bottomCollectionView:UICollectionView?
    let reusedPushBottomId = "reusedPushBottomId"
    
    var imageViewContainerView:UIView?
    var pushSingleImageView:MTTPushImageView?
    var whoExistImageView:UIImageView?
    var whoExistLabel:UILabel?
    
    
    
    var locationManager:CLLocationManager?
    var locationContainerView:UIView?
    var locationImageView:UIImageView?
    var locationLabel:UILabel?
    var locationTimes:Int?
    
    var photos:[UIImage]?
    
    
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        addNotificationObserver()
        setupSubview()
        layoutSubview()
        setupEvent()
        addGesture()
    }
    
    // MARK: - 从相机获取照片
    func getImageFromCamera() -> Void 
    {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.allowsEditing = true
        imagePickerVC.sourceType = UIImagePickerControllerSourceType.camera
        imagePickerVC.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        {
            self.present(imagePickerVC, animated: true) { 
                
            }
        } else
        {
            showAlertWithMessage(message: "相机不可用")
        }
        
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) 
    {
        self.dismiss(animated: true) { 
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) 
    {
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        if mediaType == "public.image"
        {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            imageViewContainerView?.isHidden = false
            pushSingleImageView?.image = image
            picker.dismiss(animated: true, completion: { 
                
                if self.locationContainerView?.isHidden == false
                {
                    self.locationContainerView?.frame = CGRect(x: 0, y: (self.imageViewContainerView?.frame.maxY)! + 10, width: kScreenWidth, height: 20);
                }
            })
        }
    }
    
    // MARK: - 获取相册库中多张照片
    func getPhotosImage(cell:MTTPushBottomCell, index:Int, isOriginal:Bool, isSelected:Bool) -> Void
    {
        let fetchOptions = PHFetchOptions()
        let assets = PHAsset.fetchAssets( with: fetchOptions)
        print(assets.count)
        
        let manager = PHImageManager.default()
        
        let options = PHImageRequestOptions()
        
        let size = isOriginal ? PHImageManagerMaximumSize : CGSize.zero
        
        manager.requestImage(for: assets.object(at: index), targetSize: size, contentMode: PHImageContentMode.aspectFit, options: options) { (image, hashable) in
            if isSelected
            {
                self.imageViewContainerView?.isHidden = false
                self.pushSingleImageView?.image = image
            } else
            {
                cell.backgroundImageView?.image = image
            }
        }
    }
    
    func getAllPictureFromPhotoLibrary() -> Void 
    {
        //开一个后台线程用于处理相册照片
        let photoQueue = DispatchQueue(label: "photoQueue", qos: DispatchQoS.background, attributes: DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.never, target: DispatchQueue?.none)
        photoQueue.async {
            let fetchOptions = PHFetchOptions()
            
            let assets = PHAsset.fetchAssets( with: fetchOptions)
            
            let manager = PHImageManager.default()
            
            let options = PHImageRequestOptions()
            
            for index in 0...assets.count - 1 
            {
                manager.requestImage(for: assets.object(at: index), targetSize: CGSize.zero, contentMode: PHImageContentMode.aspectFit, options: options, resultHandler: { (image, hashable) in
                    self.photos?.append(image!)
                })
            }
        }
    }
    
    // MARK: - 初始化控件
    func setupSubview() -> Void
    {
        setupNavBar()
        
        self.locationTimes = 0
        
        //pushScrollContainerView
        pushScrollContainerView = UIScrollView()
        pushScrollContainerView?.isUserInteractionEnabled = true
        pushScrollContainerView?.isPagingEnabled = true
        pushScrollContainerView?.showsVerticalScrollIndicator = false
        pushScrollContainerView?.contentSize = CGSize(width: 0, height: kScreenHeight - 59 - 50)
        pushScrollContainerView?.isScrollEnabled = true
        self.view.addSubview(pushScrollContainerView!)
        
        //pushTextView
        pushTextView = UITextView()
        pushTextView.placeholderText = "有什么新鲜事?"
        pushTextView.textColor = kMainGrayColor()
        pushTextView.text = ""
        pushTextView.backgroundColor = kMainWhiteColor()
        pushTextView.font = UIFont.systemFont(ofSize: 20)
        pushTextView.delegate = self
        pushTextView.frame = CGRect(x: 20, y: 5, width: kScreenWidth - 40, height: 40)
        pushScrollContainerView?.addSubview(pushTextView)
        
        //placeHolderLabel
        placeHolderLabel = UILabel()
        placeHolderLabel?.text = "有什么新鲜事?"
        placeHolderLabel?.textAlignment = NSTextAlignment.left
        placeHolderLabel?.textColor = kMainGrayColor()
        placeHolderLabel?.frame = CGRect(x: 3, y: 0, width: kScreenWidth - 5, height: 40)
        placeHolderLabel?.font = UIFont.systemFont(ofSize: 20)
        pushTextView.addSubview(placeHolderLabel!)
        
        //locationContainerView
        locationContainerView = UIView()
        locationContainerView?.isHidden = true
        locationContainerView?.frame = CGRect(x: 0, y: pushTextView.frame.maxY + 10, width: kScreenWidth, height: 20);
        locationContainerView?.isUserInteractionEnabled = true
        pushScrollContainerView?.addSubview(locationContainerView!)
        
        //locationImageView
        locationImageView = UIImageView()
        locationImageView?.image = UIImage(named: "twitter_location_normal")
        locationImageView?.frame = CGRect(x: 20, y: 2.5, width: 20, height: 15);
        locationImageView?.isUserInteractionEnabled = true
        locationContainerView?.addSubview(locationImageView!)
        
        //locationLabel
        locationLabel = UILabel()
        locationLabel?.font = UIFont.systemFont(ofSize: 15)
        locationLabel?.textColor = kMainGrayColor()
        locationLabel?.textAlignment = NSTextAlignment.left
        locationLabel?.isUserInteractionEnabled = true
        locationLabel?.frame = CGRect(x: (locationImageView?.frame.maxX)! + 10, y: 0, width: 200, height: 20)
        locationContainerView?.addSubview(locationLabel!)
        
        //imageViewContainerView
        imageViewContainerView = UIView()
        imageViewContainerView?.frame = CGRect(x: 0, y: pushTextView.frame.maxY + 10, width: kScreenWidth, height: 330)
        imageViewContainerView?.isHidden = true
        pushScrollContainerView?.addSubview(imageViewContainerView!)
        
        //pushSingleImageView
        pushSingleImageView = MTTPushImageView(frame: CGRect(x: 20, y: 0, width: kScreenWidth - 40, height: 300))
        pushSingleImageView?.delegate = self
        pushSingleImageView?.backgroundColor = kMainRandomColor()
        imageViewContainerView?.addSubview(pushSingleImageView!)
        
        //whoExistImageView
        whoExistImageView = UIImageView()
        whoExistImageView?.image = UIImage(named: "man-user")
        whoExistImageView?.isUserInteractionEnabled = true
        whoExistImageView?.frame = CGRect(x: 20, y: (pushSingleImageView?.frame.maxY)! + 10, width: 20, height: 20)
        imageViewContainerView?.addSubview(whoExistImageView!)
        
        //whoExistLabel
        whoExistLabel = UILabel()
        whoExistLabel?.text = "谁在这张照片里?"
        whoExistLabel?.font = UIFont.systemFont(ofSize: 12)
        whoExistLabel?.textAlignment = NSTextAlignment.left
        whoExistLabel?.textColor = kMainBlueColor()
        whoExistLabel?.isUserInteractionEnabled = true
        whoExistLabel?.frame = CGRect(x: (whoExistImageView?.frame.maxX)! + 10, y: (pushSingleImageView?.frame.maxY)! + 10, width: 200, height: 20)
        imageViewContainerView?.addSubview(whoExistLabel!)
        
        //contentView
        contentView = UIView()
        contentView?.backgroundColor = kMainWhiteColor()
        self.view.addSubview(contentView!)
        
        //secondLine
        secondLine = UIView()
        secondLine?.backgroundColor = kMainGrayColor()
        contentView?.addSubview(secondLine!)
        
        //pictureButton
        pictureButton = UIButton()
        pictureButton?.setImage(UIImage.init(named: "twitter_photo"), for: UIControlState.normal)
        pictureButton?.layer.cornerRadius = 2
        pictureButton?.clipsToBounds = true
        contentView?.addSubview(pictureButton!)
        
        //gifButton
        gifButton = UIButton()
        gifButton?.setImage(UIImage.init(named: "twitter_gif"), for: UIControlState.normal)
        gifButton?.layer.cornerRadius = 2
        gifButton?.clipsToBounds = true
        contentView?.addSubview(gifButton!)
        
        //voteButton
        voteButton = UIButton()
        voteButton?.setImage(UIImage.init(named: "twitter_vote"), for: UIControlState.normal)
        voteButton?.layer.cornerRadius = 2
        voteButton?.clipsToBounds = true
        contentView?.addSubview(voteButton!)
        
        //locationButton
        locationButton = UIButton()
        locationButton?.setImage(UIImage.init(named: "twitter_location"), for: UIControlState.normal)
        locationButton?.layer.cornerRadius = 2
        locationButton?.clipsToBounds = true
        contentView?.addSubview(locationButton!)
        
        //pushButton
        pushButton = UIButton()
        pushButton?.setTitle("发推", for: UIControlState.normal)
        pushButton?.setTitleColor(kMainGrayColor(), for: UIControlState.normal)
        pushButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        pushButton?.backgroundColor = kMainBlueColor()
        pushButton?.layer.cornerRadius = 17.5
        pushButton?.clipsToBounds = true
        contentView?.addSubview(pushButton!)
        
        //textCountLabel
        textCountLabel = UILabel()
        textCountLabel?.textColor = kMainGrayColor()
        textCountLabel?.textAlignment = NSTextAlignment.right
        textCountLabel?.font = UIFont.systemFont(ofSize: 15)
        textCountLabel?.text = "140"
        contentView?.addSubview(textCountLabel!)
        
        //bottomCollectionView
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.itemSize = CGSize(width: 70, height: 70)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5)
        bottomCollectionView = UICollectionView(frame: CGRect.init(x: 0, y: kScreenHeight - 50 - 90, width: kScreenWidth, height: 80), collectionViewLayout: flowLayout)
        bottomCollectionView?.delegate = self
        bottomCollectionView?.dataSource = self
        bottomCollectionView?.showsHorizontalScrollIndicator = false
        bottomCollectionView?.backgroundColor = kMainWhiteColor()
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
        
        //pictureButton
        pictureButton?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.contentView!).offset(20)
            make.height.width.equalTo(25)
            make.top.equalTo((self.secondLine?.snp.bottom)!).offset(12.5)
        })
        
        //gifButton
        gifButton?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.pictureButton?.snp.right)!).offset(20)
            make.width.equalTo(30)
            make.height.equalTo(20)
            make.centerY.equalTo(self.pictureButton!)
        })
        
        //voteButton
        voteButton?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.gifButton?.snp.right)!).offset(20)
            make.width.equalTo(30)
            make.height.equalTo(20)
            make.centerY.equalTo(self.pictureButton!)
        })
        
        //locationButton
        locationButton?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.voteButton?.snp.right)!).offset(20)
            make.width.equalTo(30)
            make.height.equalTo(20)
            make.centerY.equalTo(self.pictureButton!)
        })
        
        //pushButton
        pushButton?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.contentView!).offset(-20)
            make.height.equalTo(35)
            make.top.equalTo((self.secondLine?.snp.bottom)!).offset(7.5)
            make.width.equalTo(70)
        })
        
        //textCountLabel
        textCountLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo((self.pushButton?.snp.left)!).offset(-10)
            make.height.equalTo(30)
            make.width.equalTo(100)
            make.centerY.equalTo(self.pushButton!)
        })
        
    }
    
    func setupNavBar() -> Void
    {
        rightButton = UIButton()
        rightButton?.setImage(UIImage.init(named: "twitter_close"), for: UIControlState.normal)
        rightButton?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        rightButton?.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightButton!)
        
        leftButton = UIButton()
        leftButton?.setImage(UIImage.init(named: "my_head.jpg"), for: UIControlState.normal)
        leftButton?.layer.cornerRadius = 20
        leftButton?.clipsToBounds = true
        leftButton?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftButton!)
    }
    
    // MARK: - 处理事件流
    func setupEvent() -> Void
    {
        //leftButton
        leftButton?.rx.tap.subscribe(onNext:{ [unowned self] in
            print("发送头像被点击",self)
        }).disposed(by: disposeBag)
        
        //close rightButton
        (rightButton?.rx.tap)?.subscribe(onNext:{
            self.view.endEditing(true)
            self.navigationController?.dismiss(animated: true, completion: {
                
            })
        }).disposed(by: disposeBag)
        
        //location
        (locationButton?.rx.tap)?.subscribe(onNext:{ [unowned self] in
            
            self.setupLoactionManager()
        }).disposed(by: disposeBag)
        
        //pictureButton
        (pictureButton?.rx.tap)?.subscribe(onNext:{ [unowned self] in
            
            let photoLibraryVC = MTTPhotoLibraryViewController()
            let nav = MTTNavigationController(rootViewController: photoLibraryVC)
            photoLibraryVC.addCallBack = { (addedImage) in
                
                self.imageViewContainerView?.isHidden = false
                self.pushSingleImageView?.image = addedImage
                if self.locationContainerView?.isHidden == false
                {
                    self.locationContainerView?.frame = CGRect(x: 0, y: (self.imageViewContainerView?.frame.maxY)! + 10, width: kScreenWidth, height: 20)
                }
            }
            
            self.present(nav, animated: true, completion: { 
                
            })
            
        }).disposed(by: disposeBag)
        
        pushTextView.rx.text.map({($0?.count)! > 0})
            .subscribe(onNext:{ isTrue in
                
                if isTrue
                {
                    self.placeHolderLabel?.isHidden = true
                    self.textCountLabel?.text = String.init(format: "%d", 140 - self.pushTextView.text.count)
                    
                    if self.pushTextView.text.count >= Int(120)
                    {
                        self.textCountLabel?.textColor = kMainRedColor()
                        print("输入框个数:",self.pushTextView.text.count as Any)
                    } else
                    {
                        self.textCountLabel?.textColor = kMainGrayColor()
                    }
                    
                    if self.pushTextView.text.count <= Int(140)
                    {
                        self.pushButton?.setTitleColor(kMainWhiteColor(), for: UIControlState.normal)
                        self.pushButton?.isEnabled = true
                    } else
                    {
                        self.pushButton?.setTitleColor(kMainGrayColor(), for: UIControlState.normal)
                        self.pushButton?.isEnabled = false
                    }
                    
                    if self.bottomCollectionView?.isHidden == false
                    {
                        UIView.animate(withDuration: 0.2, animations: {
                            self.bottomCollectionView?.isHidden = true
                        })
                    }
                    
                } else
                {
                    self.textCountLabel?.text = "140"
                    self.placeHolderLabel?.isHidden = false
                    self.bottomCollectionView?.isHidden = false
                    self.pushButton?.setTitleColor(kMainGrayColor(), for: UIControlState.normal)
                    self.pushButton?.isEnabled = false
                }
            }).disposed(by: disposeBag)
        
        //pushButton
        pushButton?.rx.tap.subscribe(onNext:{ [unowned self] in
            print("发推按钮被点击了",self)
            
            let retwitterArray = ["1","like","3","retwitter","2","5"]
            let retwitterType = retwitterArray[self.getRandomNum()]
            let avatarImage = String(format: "%d", self.getRandomNum())
            let retwitterAccountArray = ["Javascript🔥TOP Q&A‏","The Guardian‏","Brightwater Recruit‏","TheTimesofLondon‏","ABS-CBNNewsChannel‏","朝日新聞(asahi shimbun）"]
            let retwitterAccount = retwitterAccountArray[self.getRandomNum()]
            let nickName = "@" + retwitterAccount
            let accountArray = ["The Guardian‏","Javascript🔥TOP Q&A‏","Brightwater Recruit‏","朝日新聞(asahi shimbun）","TheTimesofLondon‏","ABS-CBNNewsChannel‏"]
            let account = accountArray[self.getRandomNum()]
            
            let parameter = ["retwitterType":retwitterType,
                             "retwitterAccount":retwitterAccount,
                             "avatarImage":avatarImage,
                             "account":account,
                             "nickName":nickName,
                             "time":"20171024 12:20:22",
                             "content":self.pushTextView.text,
                             "contentImages":"contentImages",
                             "contentVideo":"contentVideo",
                             "commentCount":self.getRandomNum222(),
                             "retwitterCount":self.getRandomNum222(),
                             "likeCount":self.getRandomNum222(),
                             "privateMessageCount":self.getRandomNum222()] as [String : Any]
            
            let pushViewModel = MTTPushTwitterViewModel()
            pushViewModel.delegate = self
            pushViewModel.getPushTwitterStatus(parameters: parameter as NSDictionary)
            
            
        }).disposed(by: disposeBag)
        
    }
    
    // MARK: - 发推状态回调
    func successCallBack(data: NSDictionary)
    {
        self.dismiss(animated: true) {
            
        }
    }
    
    func failureCallBack(error: NSError)
    {
        
    }
    
    // MARK: - 获取随机数
    func getRandomNum() -> Int
    {
        let num = (arc4random() % 5)
        return Int(num)
    }
    
    func getRandomNum222() -> String
    {
        let num = (arc4random() % 2225)
        return String(format: "%d", num)
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
        
        let locationTap = UITapGestureRecognizer.init(target: self, action: #selector(locationTapAction(locationTap:)))
        
        locationContainerView?.addGestureRecognizer(locationTap)
    }
    
    func pushScrollContainerViewTapAction() -> Void
    {
        pushScrollContainerView?.endEditing(true)
    }
    
    func locationTapAction(locationTap:UITapGestureRecognizer) -> Void
    {
        setupLoactionManager()
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
            pushTextView.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: textView.contentSize.width, height: maxHeight)
        } else
        {
            pushTextView.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: textView.contentSize.width, height: textView.contentSize.height)
        }
        
        if imageViewContainerView?.isHidden == true
        {
            locationContainerView?.frame = CGRect(x: 0, y: pushTextView.frame.maxY + 10, width: kScreenWidth, height: 20)
        } else
        {
            imageViewContainerView?.frame = CGRect(x: 0, y: pushTextView.frame.maxY + 10, width: kScreenWidth, height: 330)
            
            locationContainerView?.frame = CGRect(x: 0, y: (imageViewContainerView?.frame.maxY)! + 10, width: kScreenWidth, height: 20)
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
            //getPhotosImage(cell: cell!, index: indexPath.item - 2, isOriginal: false, isSelected: false)
            cell?.innerImageView?.isHidden = true
            cell?.innerTitleLabel?.isHidden = true
            
        }
        return cell!
        
    }
    
    // MARK: - collectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if indexPath.item > 1 && indexPath.item < 19
        {
            let cell = collectionView.cellForItem(at: indexPath) as! MTTPushBottomCell
            getPhotosImage(cell: cell, index: indexPath.item - 2, isOriginal: true, isSelected: true)
            locationContainerView?.frame = CGRect(x: 0, y: (imageViewContainerView?.frame.maxY)! + 10, width: kScreenWidth, height: 20);
        } else if indexPath.item == 0
        {
            getImageFromCamera()
        } else if indexPath.item == 1
        {
            
        } else
        {
            let photoLibraryVC = MTTPhotoLibraryViewController()
            let nav = MTTNavigationController(rootViewController: photoLibraryVC)
            
            self.present(nav, animated: true, completion: { 
                
            })
        }
        
    }
    
    // MARK: - 图片的代理回调
    func tappedCloseImageView(closeImageView: UIImageView)
    {
        imageViewContainerView?.isHidden = true
        pushSingleImageView?.image = UIImage()
        
        if locationContainerView?.isHidden == false
        {
            locationContainerView?.frame = CGRect(x: 0, y: pushTextView.frame.maxY + 10, width: kScreenWidth, height: 20);
        }
    }
    
    func tappedExpressionImageView(expressionImageView: UIImageView)
    {
        
    }
    
    func tappedEditImageView(editImageView: UIImageView)
    {
        
    }
    
    // MARK: - 初始化定位
    private func setupLoactionManager() -> Void
    {
        locationTimes = 0
        
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.requestAlwaysAuthorization()
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.distanceFilter = 5.0
            locationManager?.startUpdatingLocation()
        } else
        {
            showAlertWithoutMessage()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) 
    {
        locationManager?.stopUpdatingLocation()
        let currentLocation = locations.last
        let geoCoder = CLGeocoder()
        print("当前经纬度:",currentLocation?.coordinate.latitude as Any,currentLocation?.coordinate.longitude as Any)
        
        if locationTimes != 0
        {
            return
        } else
        {
            locationTimes = 1
            geoCoder.reverseGeocodeLocation(currentLocation!) { (placemarks, error) in
                
                if (error != nil)
                {
                    self.showAlertWithMessage(message: "网络有问题,定位失败,请稍候重试.")
                } else
                {
                    var places:[String] = ["中华人民共和国","河北,中华人民共和国","天津,中华人民共和国"]
                    
                    
                    let placeMark = placemarks?.first
                    
                    print(placeMark?.locality as Any,placeMark?.country as Any)
                    
                    let place = (placeMark?.locality)! + "," + "中华人民共和国"
                    let latitudelongitudeString = String.init(format: "(%.2f...,%.2f...)", (currentLocation?.coordinate.latitude)!,(currentLocation?.coordinate.longitude)!)
                    
                    
                    if place.count > 1
                    {
                        places.insert(place, at: 0)
                        
                        let locationVC = MTTLocationViewController()
                        locationVC.places = places
                        locationVC.latitudelongitudeString = latitudelongitudeString
                        let nav = MTTNavigationController(rootViewController: locationVC)
                        self.present(nav, animated: true, completion: {
                            
                        })
                        locationVC.finishCallBack = { (placeString) in
                            self.locationContainerView?.isHidden = false
                            self.locationLabel?.text = placeString
                            
                            if self.imageViewContainerView?.isHidden == false
                            {
                                self.locationContainerView?.frame = CGRect(x: 0, y: (self.imageViewContainerView?.frame.maxY)! + 10, width: kScreenWidth, height: 20)
                            } else
                            {
                                self.locationContainerView?.frame = CGRect(x: 0, y: self.pushTextView.frame.maxY + 10, width: kScreenWidth, height: 20)
                                
                            }
                            
                        }
                        
                        locationVC.removeCallBack = { (isRemove) in
                            if isRemove
                            {
                                self.locationContainerView?.isHidden = true
                            }
                        }
                    }
                }
            }
            locationManager?.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        switch (error as NSError).code
        {
        case 1:
            showAlertWithoutMessage()
            break;

        case 2:
            showAlertWithMessage(message: "网络有问题,定位失败,请稍候重试.")
            
        default:
            showAlertWithMessage(message: "定位失败,无法获取当前定位数据")
            break
        }
    }
    
    func showAlertWithoutMessage() -> Void
    {
        let alert = UIAlertController.init(title: "提示", message: "无法定位,请先在设置中打开定位功能", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default) { (action) in
            let settingURL = NSURL.init(string: UIApplicationOpenSettingsURLString)
            UIApplication.shared.open(settingURL! as URL, options: [:], completionHandler: { (completed) in
                
            })
        }
        
        let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel) { (action) in
            
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true) {
            
        }
        
    }
    
    func showAlertWithMessage(message:String) -> Void
    {
        let alert = UIAlertController.init(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default) { (action) in
            
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true) {
            
        }
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
}
