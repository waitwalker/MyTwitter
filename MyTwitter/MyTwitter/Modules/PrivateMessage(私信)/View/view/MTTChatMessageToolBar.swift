//
//  MTTChatMessageToolBar.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/11/28.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTChatMessageToolBar: MTTView
{
    
    var addButton:UIButton!
    var inputTextView:UITextView!
    var placeLabel:UILabel!
    var pictureButton:UIButton!
    var expressionButton:UIButton!
    var sendButton:UIButton!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    
    override func setupSubview()
    {
        addButton = UIButton()
        addButton.setImage(UIImage.imageNamed(name: "twitter_add_normald"), for: UIControlState.normal)
        self.addSubview(addButton)
        
        inputTextView = UITextView()
        inputTextView.textColor = UIColor.black
        inputTextView.isEditable = true
        inputTextView.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(inputTextView)
        
        placeLabel = UILabel()
        placeLabel.text = "开始写私信"
        placeLabel.textColor = UIColor.black
        placeLabel.font = UIFont.systemFont(ofSize: 15)
        placeLabel.textAlignment = NSTextAlignment.left
        self.addSubview(placeLabel)
        
        pictureButton = UIButton()
        pictureButton.setImage(UIImage.imageNamed(name: "twitter_pictures_normald"), for: UIControlState.normal)
        self.addSubview(pictureButton)
        
        expressionButton = UIButton()
        expressionButton.setImage(UIImage.imageNamed(name: "twitter_expression_normald"), for: UIControlState.normal)
        self.addSubview(expressionButton)
        
        sendButton = UIButton()
        sendButton.setImage(UIImage.imageNamed(name: "twitter_send_normald"), for: UIControlState.normal)
        self.addSubview(sendButton)
    }
    
    
    override func layoutSubview()
    {
        
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
