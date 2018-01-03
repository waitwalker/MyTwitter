//
//  MTTSingletonManager.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2017/9/18.
//  Copyright © 2017年 waitWalker. All rights reserved.
//

import UIKit
import Foundation
import Photos
import AssetsLibrary
import AVFoundation

class MTTSingletonManager: NSObject 
{
    var user_name:String     = ""
    var email:String         = ""
    var phone_num:String     = ""
    var password:String      = ""
    var tappedImageIndex:Int = 0
    
    var audioRecorder:AVAudioRecorder!
    

    static let sharedInstance = MTTSingletonManager()
    
    private override init
    () {
        super.init()
    }
    
    // MARK: - AppDelegate 相关
    func getAppDelegate() -> AppDelegate
    {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func getKeyWindow() -> UIWindow
    {
        return getAppDelegate().window!
    }
    
    func getRootViewController() -> UIViewController
    {
        return getKeyWindow().rootViewController!
    }
    
    // MARK: - 隐藏 显示 tabBar
    func hideTabbar() -> Void
    {
        let rootVC = getRootViewController()
        
        if (rootVC.isKind(of: UITabBarController.self))
        {
            let tabBarVC = rootVC as! UITabBarController
            tabBarVC.tabBar.isHidden = true
        } else
        {
            rootVC.tabBarController?.tabBar.isHidden = true
        }
        
    }
    
    func showTabbar() -> Void
    {
        let rootVC = getRootViewController()
        
        if (rootVC.isKind(of: UITabBarController.self))
        {
            let tabBarVC = rootVC as! UITabBarController
            tabBarVC.tabBar.isHidden = false
        } else
        {
            rootVC.tabBarController?.tabBar.isHidden = false
        }
    }
    
    // MARK: - 获取相机相册权限状态
    func getCameraAuthorizationStatus() -> Bool
    {
        let authStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        
        if authStatus != AVAuthorizationStatus.denied
        {
            return true
        }
        return false
    }
    
    func getPhotoLibraryAuthorizationStatus() -> Bool
    {
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.denied
        {
            return true
        }
        return false
    }
    
    // MARK: - 授权失败弹框
    func showAlter(with message: String) -> Void
    {
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let confirmAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { action in
            UIApplication.shared.open(URL(string: "App-Prefs:root=Privacy")!, options: ["" : ""], completionHandler: { completed in
                
            })
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { action in
            
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        
        getRootViewController().present(alertController, animated: true) {
            
        }
    }
    
    // MARK: - recorder 相关 
    func startRecorder(with path:String,view:UIView) -> Void 
    {
        
    }
    
    private func startRecorder(with path:String) -> Void 
    {
        if self.audioRecorder == nil 
        {
            // 设置recorder会话类型 
            try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
            
            self.audioRecorder = try! AVAudioRecorder(url: URL(string: path)!, settings: setupSettings())
            //self.audioRecorder.delegate = self
            //self.audioRecorder.
        }
    }
    
    private func setupSettings() -> [String:Any] 
    {
        var setting:[String:Any] = [:]
        
        // 设置编码格式
        setting.updateValue(kAudioFormatLinearPCM, forKey: AVFormatIDKey)
        
        // 设置采样率 
        setting.updateValue(11025.0, forKey: AVSampleRateKey)
        
        // 设置通道数 
        setting.updateValue(1, forKey: AVNumberOfChannelsKey)
        
        // 设置音频质量,采样质量 
        setting.updateValue(AVAudioQuality.high, forKey: AVEncoderAudioQualityKey)
        
        // 设置每个采样点位数,分为8,16,24,32
        setting.updateValue(8, forKey: AVLinearPCMBitDepthKey)
        
        return setting
        
    }
}
