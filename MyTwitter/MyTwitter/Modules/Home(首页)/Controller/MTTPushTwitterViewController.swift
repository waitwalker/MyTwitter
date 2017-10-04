//
//  MTTPushTwitterViewController.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/9/28.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTPushTwitterViewController: MTTViewController,UITextViewDelegate {

    var placeHolderLabel:UILabel?
    
    var rightButton:UIButton?
    var pushTextView:UITextView?
    var pushScrollContainerView:UIScrollView?
    
    var contentView:UIView?
    var nextButton:UIButton?
    var secondLine:UIView?
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        addNotificationObserver()
        setupSubview()
        layoutSubview()
        setupEvent()
        addGesture()
        
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
        pushTextView?.becomeFirstResponder()
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
        
        //nextButton
        nextButton = UIButton()
        nextButton?.setTitle("下一步", for: UIControlState.normal)
        nextButton?.setTitleColor(kMainRedColor(), for: UIControlState.highlighted)
        nextButton?.setTitleColor(kMainGrayColor(), for: UIControlState.normal)
        nextButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        nextButton?.backgroundColor = kMainBlueColor()
        nextButton?.layer.cornerRadius = 17.5
        nextButton?.clipsToBounds = true
        contentView?.addSubview(nextButton!)
        
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
        contentView?.snp.makeConstraints({ (make) in            make.left.right.equalTo(self.view).offset(0)
            make.height.equalTo(50)
            make.bottom.equalTo(self.view).offset(0)
        })
        //secondLine
        secondLine?.snp.makeConstraints({ (make) in            make.left.right.equalTo(self.contentView!).offset(0)
            make.top.equalTo(self.contentView!).offset(0)
            make.height.equalTo(0.3)
        })
        //nextButton
        nextButton?.snp.makeConstraints({ (make) in            make.right.equalTo(self.contentView!).offset(-20)
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
            self.navigationController?.dismiss(animated: true, completion: {
                
            })
        }).addDisposableTo(disposeBag)
        
        pushTextView?.rx.text.map({($0?.characters.count)! > 0})
            .subscribe(onNext:{ isTrue in
                
                if isTrue
                {
                    self.placeHolderLabel?.isHidden = true
                } else
                {
                    self.placeHolderLabel?.isHidden = false
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
            self.contentView?.y = keyboardFrame.origin.y - 50
        }) { (completed) in
            
        }
    }
    
    @objc func keyboardWillHideAction(notify:Notification) -> Void
    {
        UIView.animate(withDuration: 0.2, animations: {
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
    
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
}
