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
    
    var keyboardHeight:CGFloat?
    var original_y:CGFloat?
    
    
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.original_y = self.y
        setupEvent()
        setupNotification()
    }
    
    
    override func setupSubview()
    {
        // 添加按钮
        addButton = UIButton()
        addButton.setImage(UIImage.imageNamed(name: "twitter_add_normal"), for: UIControlState.normal)
        self.addSubview(addButton)
        
        // 输入框容器
        inputContainerView = UIView()
        inputContainerView.backgroundColor = kMainLightGrayColor()
        inputContainerView.layer.cornerRadius = 10
        inputContainerView.clipsToBounds = true
        self.addSubview(inputContainerView)
        
        // 输入框
        inputTextView = UITextView()
        inputTextView.delegate = self
        inputTextView.backgroundColor = UIColor.clear
        inputTextView.textColor = UIColor.black
        inputTextView.isEditable = true
        inputTextView.font = UIFont.systemFont(ofSize: 18)
        inputContainerView.addSubview(inputTextView)

        // 站位label
        placeLabel = UILabel()
        placeLabel.text = "开始写私信"
        placeLabel.textColor = UIColor.black
        placeLabel.font = UIFont.systemFont(ofSize: 18)
        placeLabel.textAlignment = NSTextAlignment.left
        inputContainerView.addSubview(placeLabel)
        
        // 图片按钮
        pictureButton = UIButton()
        pictureButton.setImage(UIImage.imageNamed(name: "twitter_pictures_normal"), for: UIControlState.normal)
        self.addSubview(pictureButton)
        
        // 表情按钮
        expressionButton = UIButton()
        expressionButton.setImage(UIImage.imageNamed(name: "twitter_expression_normal"), for: UIControlState.normal)
        self.addSubview(expressionButton)
        
        // 发送按钮
        sendButton = UIButton()
        sendButton.isHidden = true
        sendButton.setImage(UIImage.imageNamed(name: "twitter_send_normal"), for: UIControlState.normal)
        self.addSubview(sendButton)
    }
    
    
    override func layoutSubview()
    {
        addButton.frame = CGRect(x: 10, y: 13, width: 24, height: 24)
        
        inputContainerView.frame = CGRect(x: 44, y: 5, width: kScreenWidth - 44 - 78, height: 40)
        
        placeLabel.frame = CGRect(x: 13, y: 0, width: 180, height: 40)
        
        inputTextView.frame = CGRect(x: 10, y: 0, width: inputContainerView.frame.size.width - 20, height: 40)
        
        pictureButton.frame = CGRect(x: inputContainerView.frame.maxX + 10, y: 13, width: 24, height: 24)
        
        expressionButton.frame = CGRect(x: pictureButton.frame.maxX + 10, y: 13, width: 24, height: 24)
        
        sendButton.frame = CGRect(x: kScreenWidth - 24 - 20, y: 13, width: 24, height: 24)
        
    }
    
    func setupNotification() -> Void
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowAction(notify:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideAction(notify:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShowAction(notify:Notification) -> Void
    {
        let keyboardFrame = notify.userInfo![UIKeyboardFrameEndUserInfoKey] as! CGRect
        
        keyboardHeight = keyboardFrame.size.height
        
        let duration = notify.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! CGFloat
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(TimeInterval(duration))
        UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
        self.y = keyboardFrame.origin.y - self.height
        UIView.commitAnimations()
        
    }
    
    @objc func keyboardWillHideAction(notify:Notification) -> Void
    {
        let duration = notify.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: duration) {
            self.y = self.original_y!
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
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MTTChatMessageToolBar:UITextViewDelegate
{
    func textViewDidChange(_ textView: UITextView)
    {
        
        
        
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

