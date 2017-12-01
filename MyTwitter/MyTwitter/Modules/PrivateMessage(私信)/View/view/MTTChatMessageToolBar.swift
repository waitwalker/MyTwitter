//
//  MTTChatMessageToolBar.swift
//  MyTwitter
//
//  Created by WangJunZi on 1017/11/28.
//  Copyright © 1017年 waitWalker. All rights reserved.
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
        inputContainerView.layer.cornerRadius = 10
        inputContainerView.clipsToBounds = true
        self.addSubview(inputContainerView)
        
        inputTextView = UITextView()
        inputTextView.delegate = self
        inputTextView.backgroundColor = UIColor.clear
        inputTextView.textColor = UIColor.black
        inputTextView.isEditable = true
        inputTextView.font = UIFont.systemFont(ofSize: 18)
        inputContainerView.addSubview(inputTextView)

        placeLabel = UILabel()
        placeLabel.text = "开始写私信"
        placeLabel.textColor = UIColor.black
        placeLabel.font = UIFont.systemFont(ofSize: 18)
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
            make.left.equalTo(10)
        }
        
        pictureButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(24)
            make.top.equalTo(13)
            make.right.equalTo(-10)
        }

        expressionButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(24)
            make.top.equalTo(13)
            make.right.equalTo(self.pictureButton.snp.left).offset(-10)
        }
        
        sendButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(24)
            make.top.equalTo(13)
            make.right.equalTo(-10)
        }
        
        inputContainerView.frame = CGRect(x: 44, y: 5, width: kScreenWidth - 44 - 78, height: 40)
        
        placeLabel.frame = CGRect(x: 13, y: 0, width: 180, height: 40)
        
        inputTextView.frame = CGRect(x: 10, y: 0, width: inputContainerView.frame.size.width - 20, height: 40)
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
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MTTChatMessageToolBar:UITextViewDelegate
{
    func textViewDidChange(_ textView: UITextView)
    {
        
        let maxHeight:CGFloat = 300
        
        let frame = textView.frame
        
        let constraintSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        
        let size = textView.sizeThatFits(constraintSize)
        
        if size.height >= maxHeight
        {
            self.frame = CGRect(x: 0, y: kScreenHeight - maxHeight - 10 - 44, width: kScreenWidth, height: maxHeight + 10)
            
            self.inputContainerView.frame = CGRect(x: 44, y: 5, width: kScreenWidth - 44 - 44, height: maxHeight - 5)
            self.inputTextView.frame = CGRect(x: 10, y: 0, width: self.inputContainerView.width - 20, height: self.inputContainerView.height)
            
        } else
        {
            if size.height < 40
            {
                self.inputContainerView.width = kScreenWidth - 44 - 44
                self.inputTextView.width = self.inputContainerView.width - 20
                self.inputContainerView.height = 40
                self.inputTextView.height = 40
                return
            }
            
            print("size.height:\(size.height)")
            
            self.frame = CGRect(x: 0, y: kScreenHeight - size.height - 10 - 44, width: kScreenWidth, height: size.height + 10)
            self.inputContainerView.frame = CGRect(x: 44, y: 5, width: kScreenWidth - 44 - 44, height: size.height - 5)
            self.inputTextView.frame = CGRect(x: 10, y: 0, width: self.inputContainerView.width - 20, height: self.inputContainerView.height)
        }
        
    }
    
    
    func changeFrame(height:CGFloat) -> Void
    {
        var origianlFrame = self.frame
        var textViewContainerViewFrame = self.inputContainerView.frame
        var textViewFrame = self.inputTextView.frame
        
        origianlFrame.size.height = height + 10
        origianlFrame.origin.y = kScreenHeight - height - 20 - 44;
        
        textViewContainerViewFrame.size.width = origianlFrame.size.width - 44 - 44
        textViewContainerViewFrame.size.height = origianlFrame.size.height - 10
        
        textViewFrame.size.width = textViewContainerViewFrame.size.width - 10
        textViewFrame.size.height = textViewContainerViewFrame.size.height
        UIView.animate(withDuration: 0.3) {
            self.frame = origianlFrame
            self.inputContainerView.frame = textViewContainerViewFrame
            self.inputTextView.frame = textViewFrame
        }
        
    }
    
}

