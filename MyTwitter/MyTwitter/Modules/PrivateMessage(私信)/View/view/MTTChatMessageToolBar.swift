//
//  MTTChatMessageToolBar.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/11/28.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MTTChatMessageToolBar: MTTView
{
    var disposeBag = DisposeBag()
    
    
    var lineView:UIView!
    
    var addButton:UIButton!
    var inputContainerView:UIView!
    var inputTextView:UITextView!
    var placeLabel:UILabel!
    var pictureButton:UIButton!
    var expressionButton:UIButton!
    var sendButton:UIButton!
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setupEvent()
    }
    
    
    override func setupSubview()
    {
        
        
        addButton = UIButton()
        addButton.setImage(UIImage.imageNamed(name: "twitter_add_normal"), for: UIControlState.normal)
        self.addSubview(addButton)
        
        inputContainerView = UIView()
        inputContainerView.backgroundColor = kMainLightGrayColor()
        inputContainerView.layer.cornerRadius = 20
        inputContainerView.clipsToBounds = true
        self.addSubview(inputContainerView)
        
        inputTextView = UITextView()
        inputTextView.backgroundColor = UIColor.clear
        inputTextView.textColor = UIColor.black
        inputTextView.isEditable = true
        inputTextView.font = UIFont.systemFont(ofSize: 15)
        inputContainerView.addSubview(inputTextView)

        placeLabel = UILabel()
        placeLabel.text = "开始写私信"
        placeLabel.textColor = UIColor.black
        placeLabel.font = UIFont.systemFont(ofSize: 15)
        placeLabel.textAlignment = NSTextAlignment.left
        inputContainerView.addSubview(placeLabel)
        
        pictureButton = UIButton()
        pictureButton.setImage(UIImage.imageNamed(name: "twitter_pictures_normal"), for: UIControlState.normal)
        self.addSubview(pictureButton)
        
        expressionButton = UIButton()
        expressionButton.setImage(UIImage.imageNamed(name: "twitter_expression_normal"), for: UIControlState.normal)
        self.addSubview(expressionButton)
        
        sendButton = UIButton()
        sendButton.isHidden = true
        sendButton.setImage(UIImage.imageNamed(name: "twitter_send_normal"), for: UIControlState.normal)
        self.addSubview(sendButton)
    }
    
    
    override func layoutSubview()
    {
        addButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(24)
            make.top.equalTo(13)
            make.left.equalTo(20)
        }
        
        pictureButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(24)
            make.top.equalTo(13)
            make.right.equalTo(-20)
        }

        expressionButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(24)
            make.top.equalTo(13)
            make.right.equalTo(self.pictureButton.snp.left).offset(-20)
        }
        
        sendButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(24)
            make.top.equalTo(13)
            make.right.equalTo(-20)
        }
        
        inputContainerView.snp.makeConstraints { (make) in
            make.left.equalTo(self.addButton.snp.right).offset(20)
            make.top.equalTo(5)
            make.height.equalTo(40)
            make.right.equalTo(self.expressionButton.snp.left).offset(-20)
        }
        
        placeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.top.bottom.equalTo(0)
            make.right.equalTo(-10)
        }
        
        inputTextView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.bottom.equalTo(0)
            make.right.equalTo(-10)
        }
    }
    
    private func setupEvent() -> Void
    {
        let inputTextViewSequence = (inputTextView.rx.text)
            .orEmpty
            .map{ $0.characters.count > 0}
            .share(replay: 1)
        
        let inputTextViewSequenceNegate = (inputTextView.rx.text)
            .orEmpty
            .map{ $0.characters.count <= 0}
            .share(replay: 1)
        
        inputTextViewSequence
            .bind(to: placeLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        inputTextViewSequence
            .bind(to: expressionButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        inputTextViewSequence
            .bind(to: pictureButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        inputTextViewSequenceNegate
            .bind(to: sendButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        inputTextViewSequence
            .subscribe(onNext:{[unowned self] element in
                print(element)
                
                if element
                {
                    self.inputContainerView.snp.makeConstraints { (make) in
                        make.left.equalTo(self.addButton.snp.right).offset(20)
                        make.top.equalTo(5)
                        make.height.equalTo(40)
                        make.right.equalTo(self.expressionButton.snp.left).offset(-20)
                    }
                } else
                {
                    self.inputContainerView.snp.makeConstraints { (make) in
                        make.left.equalTo(self.addButton.snp.right).offset(20)
                        make.top.equalTo(5)
                        make.height.equalTo(40)
                        make.right.equalTo(self.sendButton.snp.left).offset(-20)
                    }
                }
                
            }).disposed(by: disposeBag)
        
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
