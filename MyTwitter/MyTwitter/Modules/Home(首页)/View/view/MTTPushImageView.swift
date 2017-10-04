//
//  MTTPushImageView.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/10/4.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTPushImageView: UIImageView
{
    var closeImageView:UIImageView?
    var expressionImageView:UIImageView?
    var editImageView:UIImageView?
    var delegate:MTTPushImageViewDelegate?
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        setupSubview()
        layoutSubview()
        addGesture()
    }
    
    func setupSubview() -> Void
    {
        //close
        closeImageView = UIImageView()
        closeImageView?.image = UIImage(named: "twitter_blcak_close")
        closeImageView?.alpha = 0.7
        closeImageView?.isUserInteractionEnabled = true
        self.addSubview(closeImageView!)
        
        //expression
        expressionImageView = UIImageView()
        expressionImageView?.image = UIImage(named: "twitter_black_expression")
        expressionImageView?.alpha = 0.7
        expressionImageView?.isUserInteractionEnabled = true
        self.addSubview(expressionImageView!)
        
        //edit
        editImageView = UIImageView()
        editImageView?.image = UIImage(named: "twitter_black_edit")
        editImageView?.alpha = 0.7
        editImageView?.isUserInteractionEnabled = true
        self.addSubview(editImageView!)
        
    }
    
    func layoutSubview() -> Void
    {
        closeImageView?.snp.makeConstraints({ (make) in
            make.top.equalTo(10)
            make.right.equalTo(-10)
            make.height.width.equalTo(25)
        })
        
        editImageView?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(-10)
            make.right.equalTo(-10)
            make.height.width.equalTo(25)
        })
        
        expressionImageView?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(-10)
            make.right.equalTo((self.editImageView?.snp.left)!).offset(-10)
            make.height.width.equalTo(25)
        })
    }
    
    func addGesture() -> Void
    {
        let closeTapGes = UITapGestureRecognizer.init(target: self, action: #selector(closeImageViewTapAction(closeImageView:)))
        closeImageView?.addGestureRecognizer(closeTapGes)
        
        let expressionTapGes = UITapGestureRecognizer.init(target: self, action: #selector(expressionImageViewTapAction(expressionImageView:)))
        expressionImageView?.addGestureRecognizer(expressionTapGes)
        
        let editTapGes = UITapGestureRecognizer.init(target: self, action: #selector(editImageViewTapAction(editImageView:)))
        editImageView?.addGestureRecognizer(editTapGes)
        
    }
    
    func closeImageViewTapAction(closeImageView:UIImageView) -> Void
    {
        delegate?.tappedCloseImageView(closeImageView: closeImageView)
    }
    
    func editImageViewTapAction(editImageView:UIImageView) -> Void
    {
        delegate?.tappedEditImageView(editImageView: editImageView)
    }
    
    func expressionImageViewTapAction(expressionImageView:UIImageView) -> Void
    {
        delegate?.tappedExpressionImageView(expressionImageView: expressionImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
