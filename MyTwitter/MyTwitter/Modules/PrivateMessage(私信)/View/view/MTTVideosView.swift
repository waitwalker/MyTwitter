//
//  MTTVideosView.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/12/18.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTVideosView: MTTView {

    var addVideoCollectionView:UICollectionView!
    
    let reusedAddVideoId:String = "reusedAddVideoId"
    
    var delegate:MTTVideosViewDelegate?
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    
    override func setupSubview()
    {
        let photoFlowLayout                     = UICollectionViewFlowLayout()
        photoFlowLayout.scrollDirection         = UICollectionViewScrollDirection.vertical
        photoFlowLayout.minimumLineSpacing      = 0
        photoFlowLayout.minimumInteritemSpacing = 0

        addVideoCollectionView                  = UICollectionView(frame: CGRect.zero, collectionViewLayout: photoFlowLayout)
        addVideoCollectionView.register(MTTAddVideoCell.self, forCellWithReuseIdentifier: reusedAddVideoId)
        addVideoCollectionView.backgroundColor  = kMainLightGrayColor()
        addVideoCollectionView.delegate         = self
        addVideoCollectionView.dataSource       = self
        self.addSubview(addVideoCollectionView)
    }
    
    override func layoutSubview()
    {
        super.layoutSubview()
        addVideoCollectionView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
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

extension MTTVideosView:
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
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        switch indexPath.item {
        case 0:
            let cell                 = collectionView.dequeueReusableCell(withReuseIdentifier: reusedAddVideoId, for: indexPath) as! MTTAddVideoCell
            cell.iconImageView.image = UIImage.imageNamed(name: "twitter_micro_recorder")
            cell.lineView.isHidden   = true
            cell.vTitleLabel.text    = "录音"
            return cell
            
        case 1:
            let cell                 = collectionView.dequeueReusableCell(withReuseIdentifier: reusedAddVideoId, for: indexPath) as! MTTAddVideoCell
            cell.iconImageView.image = UIImage.imageNamed(name: "twitter_photo")
            cell.lineView.isHidden   = false
            cell.vTitleLabel.text    = "拍摄照片或视频"
            return cell
        case 2:
            let cell                 = collectionView.dequeueReusableCell(withReuseIdentifier: reusedAddVideoId, for: indexPath) as! MTTAddVideoCell
            cell.iconImageView.image = UIImage.imageNamed(name: "twitter_gif")
            cell.lineView.isHidden   = false
            cell.vTitleLabel.text    = "发送一个 GIF"
            return cell
        default: break
            
        }
        return MTTAddVideoCell()
    }
    
    // MARK: - collectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        switch indexPath.item 
        {
        case 0:
            handleSelectMicroRecorder()
            break
        case 1:
            break
        case 2:
            break
        default: break
            
        }
    }
    
    // MARK: - 处理cell选中相关操作 
    func handleSelectMicroRecorder() -> Void 
    {
        self.delegate?.selectMicroRecorderAction(with: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: kScreenWidth, height: 44)
    }
    
}

