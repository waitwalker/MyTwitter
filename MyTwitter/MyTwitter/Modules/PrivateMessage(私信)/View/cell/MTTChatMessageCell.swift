//
//  MTTChatMessageCell.swift
//  MyTwitter
//
//  Created by WangJunZi on 2017/12/5.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit

class MTTChatMessageCell: MTTTableViewCell
{
    
    let kMargin:CGFloat            = 10

    let kBaseWidth:CGFloat         = 240

    let kAvatarHeightWidth:CGFloat = 50

    let image1 = UIImage.imageNamed(name: "twitter_voice_play_1")
    let image2 = UIImage.imageNamed(name: "twitter_voice_play_2")
    let image3 = UIImage.imageNamed(name: "twitter_voice_play_3")
    var contentBackgroundImageView:UIImageView!
    
    var avatarImageView:UIImageView!
    var timeLabel:UILabel!
    var contentTextLabel:UILabel!
    
    var contentImageView:UIImageView!
    
    var contentVoiceImageView:UIImageView!
    
    var contentVoiceTotalTimeLabel:UILabel!
    
    
    
    var chatMessageModel:MTTChatMessageModel?
    {
        didSet
        {
            //print(chatMessageModel?.messageFrom as Any)
            
        }
    }
    
    func setChatMessageModel(model:MTTChatMessageModel) -> Void
    {
        layoutSubview(model: model)
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.none
        setupSubview()
    }
    
    func setupSubview() -> Void
    {
        timeLabel                                           = UILabel()
        timeLabel.font                                      = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor                                 = UIColor.black
        timeLabel.textAlignment                             = NSTextAlignment.center
        self.contentView.addSubview(timeLabel)

        avatarImageView                                     = UIImageView()
        avatarImageView.layer.cornerRadius                  = 25
        avatarImageView.clipsToBounds                       = true
        avatarImageView.backgroundColor                     = kMainRandomColor()
        avatarImageView.isUserInteractionEnabled            = true
        self.contentView.addSubview(avatarImageView)

        contentBackgroundImageView                          = UIImageView()
        contentBackgroundImageView.isUserInteractionEnabled = true
        self.contentView.addSubview(contentBackgroundImageView)

        contentTextLabel                                    = UILabel()
        contentTextLabel.font                               = UIFont.systemFont(ofSize: 18)
        contentTextLabel.textColor                          = kMainRandomColor()
        contentTextLabel.numberOfLines                      = 0
        contentTextLabel.sizeToFit()
        contentBackgroundImageView.addSubview(contentTextLabel)

        contentImageView                                    = UIImageView()
        contentImageView.backgroundColor                    = kMainRandomColor()
        contentImageView.isUserInteractionEnabled           = true
        contentBackgroundImageView.addSubview(contentImageView)

        contentVoiceImageView                               = UIImageView()
        contentVoiceImageView.isUserInteractionEnabled      = true
        contentBackgroundImageView.addSubview(contentVoiceImageView)
        
        contentVoiceTotalTimeLabel = UILabel()
        contentVoiceTotalTimeLabel.textColor = UIColor.black
        contentVoiceTotalTimeLabel.font = UIFont.systemFont(ofSize: 18)
        contentBackgroundImageView.addSubview(contentVoiceTotalTimeLabel)
    }
    
    func layoutSubview(model:MTTChatMessageModel) -> Void
    {
        // 聊天时间
        timeLabel.frame = CGRect(x: kMargin, y: kMargin, width: kScreenWidth - 20, height: 20)
        timeLabel.text  = String.getSuitableDateHint(TimeInterval(model.chatDateStamp)) + "  " + String.getTimeString(date: model.chatDate)
        
        print(model.messageFrom)
        
        if model.messageFrom == Int(0)
        {
           self.layoutMyMessageSubview(model: model)
        } else
        {
            self.layoutOthersMessageSubview(model: model)
        }
    }
    
    // MARK: - 布局别人发的消息
    func layoutOthersMessageSubview(model:MTTChatMessageModel) -> Void
    {
        // 头像
        avatarImageView.frame           = CGRect(
            x: kMargin, 
            y: timeLabel.frame.maxY + kMargin / 2, 
            width: kAvatarHeightWidth, 
            height: kAvatarHeightWidth)

        // 聊天背景气泡
        contentBackgroundImageView.frame = CGRect(
            x: kAvatarHeightWidth + kMargin * 2, 
            y: timeLabel.frame.maxY + kMargin / 2, 
            width: kBaseWidth, 
            height: CGFloat(model.contentBackImageHeight))
        
        switch model.messageType
        {
        case 0:
            
            contentTextLabel.text     = model.messageContent
            // 聊天文本
            contentTextLabel.frame    = CGRect(x: 15, y: 5, width: kBaseWidth - 15, height: CGFloat(model.contentTextHeight))

            contentTextLabel.isHidden = false
            contentImageView.isHidden = true
            contentVoiceImageView.isHidden = true
            
            break
        case 1:
            // 聊天图片
            contentImageView.frame         = CGRect(x: 15, y: 5, width: kBaseWidth - 15, height: CGFloat(model.contentPictureHeight))
            contentImageView.image         = UIImage(data: model.pictureData)
            contentTextLabel.isHidden      = true
            contentImageView.isHidden      = false
            contentVoiceImageView.isHidden = true
            
            break
        case 2:
            // 聊天语音
            //contentVoiceTotalTimeLabel.frame = CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
            
            contentVoiceImageView.frame    = CGRect(x: 15, y: 5, width: kBaseWidth - 15, height: CGFloat(model.contentVoiceHeight))
            
            contentVoiceImageView.highlightedAnimationImages = [image1,image2,image3]
            contentVoiceImageView.animationDuration = 1.5
            contentVoiceImageView.animationRepeatCount = Int(MAXFLOAT)
            contentVoiceImageView.startAnimating()
            contentTextLabel.isHidden      = true
            contentImageView.isHidden      = true
            contentVoiceImageView.isHidden = false
            break
            
        default:
            break
            
        }
        
        var contentBackImage             = UIImage.imageNamed(name: "twitter_chat_message_others")
        contentBackImage                 = contentBackImage.resizableImage(withCapInsets: UIEdgeInsetsMake(35, 10, 10, 22), resizingMode: UIImageResizingMode.tile)
        contentBackgroundImageView.image = contentBackImage

        contentTextLabel.textAlignment   = NSTextAlignment.left
    }
    
    // MARK: - 布局自己发的消息
    func layoutMyMessageSubview(model:MTTChatMessageModel) -> Void
    {
        avatarImageView.frame = CGRect(
            x: kScreenWidth - kAvatarHeightWidth - kMargin, 
            y: timeLabel.frame.maxY + kMargin / 2, 
            width: kAvatarHeightWidth, 
            height: kAvatarHeightWidth)
        
        
        // 聊天背景气泡
        contentBackgroundImageView.frame = CGRect(
            x: kScreenWidth - kBaseWidth - kAvatarHeightWidth - 15, 
            y: timeLabel.frame.maxY + kMargin / 2, 
            width: kBaseWidth, 
            height: CGFloat(model.contentBackImageHeight))
        
        switch model.messageType
        {
        case 0:
            contentTextLabel.text          = model.messageContent
            // 聊天文本
            contentTextLabel.frame         = CGRect(x: 0, y: 5, width: kBaseWidth - 15, height: CGFloat(model.contentTextHeight))

            contentTextLabel.isHidden      = false
            contentImageView.isHidden      = true
            contentVoiceImageView.isHidden = true

            break
        case 1:
            
            // 聊天图片
            contentImageView.frame         = CGRect(x: 0, y: 5, width: kBaseWidth - 15, height: CGFloat(model.contentPictureHeight))

            contentTextLabel.isHidden      = true
            contentImageView.isHidden      = false
            contentVoiceImageView.isHidden = true

            break
        case 2:
            // 聊天语音
            contentVoiceTotalTimeLabel.frame = CGRect(x: 20, y: 0, width: 45, height: 50)
            contentVoiceTotalTimeLabel.textAlignment = NSTextAlignment.right
            contentVoiceTotalTimeLabel.text = String(format: "%d''", model.contentVoiceTotalTime)
            
            contentVoiceImageView.frame    = CGRect(x: 70, y: 12, width: 18, height: 27)
            contentVoiceImageView.image = image3
            contentVoiceImageView.highlightedAnimationImages = [image1,image2,image3]
            contentVoiceImageView.animationDuration = 1.5
            contentVoiceImageView.animationRepeatCount = 0
            if model.contentVoiceIsPlaying == 1
            {
                contentVoiceImageView.isHighlighted = true
                contentVoiceImageView.startAnimating()
                let fileString = shardInstance.getRecorderFilePath() + model.messageVoiceName
                shardInstance.playerVoice(with: fileString)
            } else
            {
                contentVoiceImageView.isHighlighted = false
                contentVoiceImageView.stopAnimating()
            }
            
            contentTextLabel.isHidden      = true
            contentImageView.isHidden      = true
            contentVoiceImageView.isHidden = false
            break
            
        default:
            break
            
        }
        var contentBackImage             = UIImage.imageNamed(name: "twitter_chat_message_my")
        contentBackImage                 = contentBackImage.resizableImage(withCapInsets: UIEdgeInsetsMake(35, 22, 10, 10), resizingMode: UIImageResizingMode.stretch)
        contentBackgroundImageView.image = contentBackImage
        contentTextLabel.textAlignment   = model.contentTextHeight > 40 ? NSTextAlignment.left : NSTextAlignment.right
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
