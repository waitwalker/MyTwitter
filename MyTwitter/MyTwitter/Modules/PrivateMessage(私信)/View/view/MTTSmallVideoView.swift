//
//  MTTSmallVideoView.swift
//  MyTwitter
//
//  Created by LiuChuanan on 2018/2/12.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

/********
 小视频视图 
 ********/

import UIKit
import RxCocoa
import RxSwift
import AVFoundation

class MTTSmallVideoView: MTTView {

    let disposeBag = DisposeBag()
    
    
    // 灰色背景容器 
    var containerView:UIView!
    
    // 视频相关容器 
    var videoContainerView:UIView!
    
    // 视频顶部bar
    var videoTopBarView:UIView!
    var videoBarImageView:UIImageView!
    var videoRecordingHintImageView:UIImageView!
    
    // 视频录制
    var videoRecordView:UIView!
    
    // 下部容器
    var videoBottomContainerView:UIView!
    var videoListButton:UIButton!
    var videoRecordButton:UIButton!
    var videoRemoveButton:UIButton!
    
    // 录制相关 
    var captureSession:AVCaptureSession! //捕获会话 
    var captureVideoPreviewLayer:AVCaptureVideoPreviewLayer!
    var captureVideoDevice:AVCaptureDevice!
    
    var captureVideoDataOutput:AVCaptureVideoDataOutput!
    var captureAudioDataOutput:AVCaptureAudioDataOutput!
    
    var assetWriter:AVAssetWriter!
    var assetWriterInputPixelBufferAdaptor:AVAssetWriterInputPixelBufferAdaptor!
    var assetWriterVideoInput:AVAssetWriterInput!
    var assetWriterAudioInput:AVAssetWriterInput!
    
    var videoQueue:DispatchQueue!
    
    
    
    
    
    
    
    
    
    
    
    override init(frame: CGRect) 
    {
        super.init(frame: frame)
        
        setupEvent()
    }
    
    override func setupSubview() 
    {
        // 背景大容器
        containerView = UIView(frame: self.bounds)
        containerView.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
        self.addSubview(containerView)
        
        // 视频相关容器 
        videoContainerView = UIView(frame: CGRect(x: 0, y: 260, width: kScreenWidth, height: kScreenHeight - 260))
        videoContainerView.backgroundColor = UIColor.black
        containerView.addSubview(videoContainerView)
        
        // 录制视频上部bar
        videoTopBarView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 20))
        videoTopBarView.backgroundColor = UIColor.orange
        videoContainerView.addSubview(videoTopBarView)
        
        videoBarImageView = UIImageView()
        videoBarImageView.isUserInteractionEnabled = true
        videoBarImageView.image = UIImage.imageNamed(name: "small_video_bar")
        videoTopBarView.addSubview(videoBarImageView)
        
        videoRecordingHintImageView = UIImageView()
        videoRecordingHintImageView.layer.cornerRadius = 5.0
        videoRecordingHintImageView.clipsToBounds = true
        videoRecordingHintImageView.image = UIImage.imageNamed(name: "small_video_dot")
        videoRecordingHintImageView.isUserInteractionEnabled = true
        videoRecordingHintImageView.isHidden = true
        videoTopBarView.addSubview(videoRecordingHintImageView)
        
        // 视频录制视图
        videoRecordView = UIView(frame: CGRect(x: 0, y: 20, width: kScreenWidth, height: 260))
        videoRecordView.backgroundColor = kMainBlueColor()
        videoContainerView.addSubview(videoRecordView)
        
        // 下部视图 
        videoBottomContainerView = UIView(frame: CGRect(x: 0, y: self.videoRecordView.frame.maxY, width: kScreenWidth, height: videoContainerView.height - 20 - 260))
        videoBottomContainerView.backgroundColor = UIColor.green
        videoContainerView.addSubview(videoBottomContainerView)
        
        videoRemoveButton = UIButton(frame: CGRect(x: kScreenWidth - 30 - 24, y: (videoBottomContainerView.height - 24) / 2, width: 24, height: 24))
        videoRemoveButton.setImage(UIImage.imageNamed(name: "small_video_remove"), for: UIControlState.normal)
        videoBottomContainerView.addSubview(videoRemoveButton)
        
        // 设置视频录制
        self.setupVideoRecordCapture()
    }
    
    func layoutSubviewss()
    {
        containerView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalTo(self)
        }
        
        videoContainerView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(self).offset(260)
        }
        
        videoTopBarView.snp.makeConstraints { make in
            make.left.top.right.equalTo(self.videoContainerView)
            make.height.equalTo(20)
        }
        
        videoBarImageView.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalTo(20)
            make.center.equalTo(self.videoTopBarView)
        }
        
        videoRecordingHintImageView.snp.makeConstraints { make in
            make.height.width.equalTo(10)
            make.center.equalTo(self.videoTopBarView)
        }
        
        videoRecordView.snp.makeConstraints { make in
            make.top.equalTo(self.videoTopBarView.snp.bottom).offset(0)
            make.width.left.equalTo(self.videoContainerView)
            make.height.equalTo(260)
        }
        
        videoBottomContainerView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.videoContainerView)
            make.top.equalTo(self.videoRecordView.snp.bottom).offset(0)
        }
        
        videoRemoveButton.snp.makeConstraints { make in
            make.right.equalTo(self.videoBottomContainerView.snp.right).offset(-30)
            make.height.equalTo(24)
            make.width.equalTo(24)
            make.centerY.equalTo(self.videoBottomContainerView)
        }
        
        
        
    }
    
    // MARK: - 监听相关事件 
    func setupEvent() -> Void 
    {
        videoRemoveButton.rx.tap
            .subscribe(onNext:{ _ in
                self.videoRemoveButtonAction()
            }).disposed(by: disposeBag)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension MTTSmallVideoView
{
    // 移除按钮相关事件回调 
    func videoRemoveButtonAction() -> Void 
    {
        UIView.animate(withDuration: 0.3, animations: { 
            self.videoContainerView.y = kScreenHeight
            self.containerView.backgroundColor = UIColor.gray.withAlphaComponent(0)
        }) { completed in
            self.removeFromSuperview()
        }
    }
}

extension MTTSmallVideoView
{
    func setupVideoRecordCapture() -> Void 
    {
        // 视频录制队列 
        self.videoQueue = DispatchQueue(label: "video_queue", qos: DispatchQoS.default, attributes: DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.never, target: nil)
        
        // 1.创建捕捉会话 
        self.captureSession = AVCaptureSession()
        // 1.1 设置分辨率 
        if self.captureSession.canSetSessionPreset(AVCaptureSessionPreset640x480)
        {
            self.captureSession.sessionPreset = AVCaptureSessionPreset640x480
        }
        
        // 2.视频的输入 
        self.captureVideoDevice = self.getCameraDeviceWithPosition(position: AVCaptureDevicePosition.back)
        
        // 2.1视频HDR(高动态范围图像)
        //self.captureVideoDevice.isVideoHDREnabled = true
        
        // 2.2 视频最大,最小帧速率 
        //self.captureVideoDevice.activeVideoMinFrameDuration = CMTime(value: 1, timescale: 60)
        
        // 2.3 视频输入源 
        let captureVideoDeviceInput = try! AVCaptureDeviceInput(device: self.captureVideoDevice)
        
        // 2.4 将视频输入源添加到会话 
        if self.captureSession.canAddInput(captureVideoDeviceInput) 
        {
            self.captureSession.addInput(captureVideoDeviceInput)
        }
        
        // 2.5 视频输出
        self.captureVideoDataOutput = AVCaptureVideoDataOutput()
        
        // 2.6 立即丢弃旧帧,节省内存 
        self.captureVideoDataOutput.alwaysDiscardsLateVideoFrames = true
        self.captureVideoDataOutput.setSampleBufferDelegate(self, queue: self.videoQueue)
        if self.captureSession.canAddOutput(self.captureVideoDataOutput) 
        {
            self.captureSession.addOutput(self.captureVideoDataOutput)
        }
        
        
        // 3.获取音频设备 
        let captureAudioDevice = AVCaptureDeviceDiscoverySession(deviceTypes: [AVCaptureDeviceType.builtInMicrophone], mediaType: AVMediaTypeAudio, position: AVCaptureDevicePosition.unspecified).devices.first
        
        
        // 3.1 创建音频输入源
        let captureAudioDeviceInput = try! AVCaptureDeviceInput(device: captureAudioDevice)
        
        // 3.2 将音频输入源添加到会话 
        if self.captureSession.canAddInput(captureAudioDeviceInput)
        {
            self.captureSession.addInput(captureAudioDeviceInput)
        }
        
        // 3.3 设置音频的输出 
        self.captureAudioDataOutput = AVCaptureAudioDataOutput()
        self.captureAudioDataOutput.setSampleBufferDelegate(self, queue: self.videoQueue)
        if self.captureSession.canAddOutput(self.captureAudioDataOutput) 
        {
            self.captureSession.addOutput(self.captureAudioDataOutput)
        }
        
        // 4. 设置视频预览层
        self.captureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        self.captureVideoPreviewLayer.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 260)
        self.captureVideoPreviewLayer.position = CGPoint(x: kScreenWidth / 2, y: 130)
        self.captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.videoRecordView.layer.addSublayer(self.captureVideoPreviewLayer)
        
        // 5. 开始采集
        self.captureSession.startRunning()
    }
    
    // 获取设备 
    func getCameraDeviceWithPosition(position:AVCaptureDevicePosition) -> AVCaptureDevice 
    {
        let captureDeviceDiscoverySession = AVCaptureDeviceDiscoverySession(deviceTypes: [AVCaptureDeviceType.builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: position)
        
        let deviceArray = captureDeviceDiscoverySession?.devices
        for device in deviceArray! {
            if device.position == position
            {
                return device
            }
        }
        return (deviceArray?.first)!
    }
}

extension MTTSmallVideoView:AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureAudioDataOutputSampleBufferDelegate
{
    // AVCaptureVideoDataOutputSampleBufferDelegate
    func captureOutput(_ output: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) 
    {
        
    }
    
    // AVCaptureVideoDataOutputSampleBufferDelegate  AVCaptureAudioDataOutputSampleBufferDelegate
    func captureOutput(_ output: AVCaptureOutput!, didDrop sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) 
    {
        // 判断AVCaptureOutput 
    }
}
