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
    var user_name:String = ""
    var email:String = ""
    var phone_num:String = ""
    var password:String = ""
    var tappedImageIndex:Int = 0
    
    
    static let sharedInstance = MTTSingletonManager()
    
    private override init
    () {
        super.init()
    }
    
    // 隐藏 显示 tabBar
    func getRootViewController() -> UIViewController
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let rootVC = appDelegate.window?.rootViewController
        
        return rootVC!
    }
    
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
}
