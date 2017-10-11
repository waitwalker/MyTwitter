//
//  MTTPhotoLibraryViewController.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/10/11.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTPhotoLibraryViewController: MTTViewController ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    var photos:[UIImage]?
    
    var photoLibraryCollectionView:UICollectionView?
    var leftButton:UIButton?
    var rightButton:UIButton?
    
    
    let reusedPhotoLibraryId = "reusedPhotoLibraryId"
    
    
    
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        setupSubview()
        layoutSubview()
        setupEvent()

    }
    
    private func setupSubview() -> Void 
    {
        let photoFlowLayout = UICollectionViewFlowLayout()
        photoFlowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        
        photoLibraryCollectionView = UICollectionView()
        photoLibraryCollectionView?.collectionViewLayout = photoFlowLayout
        photoLibraryCollectionView?.register(MTTPhotoLibraryCell.self, forCellWithReuseIdentifier: reusedPhotoLibraryId)
        photoLibraryCollectionView?.delegate = self
        photoLibraryCollectionView?.dataSource = self
        self.view.addSubview(photoLibraryCollectionView!)
        
        setupNavigationBar()
    }
    
    private func layoutSubview() -> Void 
    {
        photoLibraryCollectionView?.snp.makeConstraints({ (make) in
            make.top.left.bottom.right.equalTo(0)
        })
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
        rightButton?.setTitleColor(kMainBlueColor(), for: UIControlState.normal)
        rightButton?.frame = CGRect(x: 0, y: 0, width: 40, height: 44)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightButton!)
        
        self.navigationItem.title = "全部照片"
    }
    
    func setupEvent() -> Void 
    {
        leftButton?.rx.tap.subscribe(onNext:{ [unowned self] in
            self.dismiss(animated: true, completion: { 
                
            })
        })
    }
    
    // MARK: - collectionView DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int 
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int 
    {
        //return (photos?.count)! + 3
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell 
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusedPhotoLibraryId, for: indexPath) as! MTTPhotoLibraryCell
        //cell.photoBackgroundImageView?.image = photos?[indexPath.item + 3]
        return cell
    }
    
    // MARK: - collectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) 
    {
        
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
