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
    
    // 眼睛视图 
    var eyeView:MTTEyeView!
    var focusView:MTTFocusView!
    
    
    
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
        videoContainerView = UIView(frame: CGRect(x: 0, y: kScreenHeight, width: kScreenWidth, height: kScreenHeight - 260))
        videoContainerView.backgroundColor = UIColor.black
        containerView.addSubview(videoContainerView)
        
        // 视频录制视图
        videoRecordView = UIView(frame: CGRect(x: 0, y: 20, width: kScreenWidth, height: 260))
        videoRecordView.backgroundColor = kMainBlueColor()
        videoContainerView.addSubview(videoRecordView)
        
        // 录制视频上部bar
        videoTopBarView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 20))
        videoTopBarView.backgroundColor = UIColor.orange
        videoContainerView.addSubview(videoTopBarView)
        
        videoBarImageView = UIImageView(frame: CGRect(x: (videoTopBarView.width - 20)/2, y: 2, width: 20, height: 16))
        videoBarImageView.isUserInteractionEnabled = true
        videoBarImageView.image = UIImage.imageNamed(name: "small_video_bar")
        videoTopBarView.addSubview(videoBarImageView)
        
        videoRecordingHintImageView = UIImageView(frame: CGRect(x: (videoTopBarView.width - 10)/2, y: 5, width: 10, height: 10))
        videoRecordingHintImageView.layer.cornerRadius = 5.0
        videoRecordingHintImageView.clipsToBounds = true
        videoRecordingHintImageView.image = UIImage.imageNamed(name: "small_video_dot")
        videoRecordingHintImageView.isUserInteractionEnabled = true
        videoRecordingHintImageView.isHidden = true
        videoTopBarView.addSubview(videoRecordingHintImageView)
        
        
        // 下部视图 
        videoBottomContainerView = UIView(frame: CGRect(x: 0, y: self.videoRecordView.frame.maxY, width: kScreenWidth, height: videoContainerView.height - 20 - 260))
        videoBottomContainerView.backgroundColor = UIColor.green
        videoContainerView.addSubview(videoBottomContainerView)
        
        videoRemoveButton = UIButton(frame: CGRect(x: kScreenWidth - 30 - 24, y: (videoBottomContainerView.height - 24) / 2, width: 24, height: 24))
        videoRemoveButton.setImage(UIImage.imageNamed(name: "small_video_remove"), for: UIControlState.normal)
        videoBottomContainerView.addSubview(videoRemoveButton)
        
        // 设置视频录制
        self.setupVideoRecordCapture()
        
        videoContainerView.sendSubview(toBack: videoTopBarView)
        
        
        // 眼睛视图
        eyeView = MTTEyeView(frame:self.videoRecordView.bounds)
        self.videoRecordView.addSubview(eyeView)
        print(eyeView)
        
        // 聚焦视图  
        focusView = MTTFocusView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        focusView.backgroundColor = UIColor.clear
        
        
        UIView.animate(withDuration: 0.3, 
                       delay: 0.0, 
                       options: UIViewAnimationOptions.curveEaseIn, 
                       animations: { 
            self.videoContainerView.y = 260
        }) { completed in
            self.setupEyeAnimationView()
        }

        
        let timeInterval:TimeInterval = 2.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeInterval) { 
            
        }
        
        // 设置手势 
        setupGesture()
    }
    
    // MARK: - 设置相关手势 
    func setupGesture() -> Void 
    {
        let singleTapGesture = UITapGestureRecognizer(
            target: self, 
            action: #selector(focusAction(gesture:)))
        singleTapGesture.delaysTouchesBegan = true
        self.videoRecordView.addGestureRecognizer(singleTapGesture)
        
        let doubleTapGesture = UITapGestureRecognizer(
            target: self, 
            action: #selector(zoomAction(gesture:)))
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.numberOfTouchesRequired = 1
        doubleTapGesture.delaysTouchesBegan = true
        self.videoRecordView.addGestureRecognizer(doubleTapGesture)
        // 双击失败了才会触发单击 
        singleTapGesture.require(toFail: doubleTapGesture)
        
    }
    // 单击聚焦事件 
    @objc private func focusAction(gesture:UITapGestureRecognizer) -> Void 
    {
        let date = Date(timeIntervalSinceNow: 0)
        print("录制单击聚焦\(self),时间:\(date)")
        
        let tPoint = gesture.location(in: self.videoRecordView)
        
        self.focusInPoint(point: tPoint)
        
    }
    
    private func focusInPoint(point:CGPoint) -> Void 
    {
        let cameraPoint = captureVideoPreviewLayer.captureDevicePointOfInterest(for: point)
        
        focusView.center = point
        self.videoRecordView.addSubview(focusView)
        self.videoRecordView.bringSubview(toFront: focusView)
        focusView.focusing()
        
        if (try? captureVideoDevice.lockForConfiguration()) != nil {
            
            if captureVideoDevice.isFocusPointOfInterestSupported
            {
                captureVideoDevice.focusPointOfInterest = cameraPoint
            }
            
            // 自动聚焦
            if captureVideoDevice.isFocusModeSupported(AVCaptureFocusMode.autoFocus)
            {
                captureVideoDevice.focusMode = AVCaptureFocusMode.autoFocus
            }
            
            // 自动调节曝光 
            if captureVideoDevice.isExposureModeSupported(AVCaptureExposureMode.autoExpose)
            {
                captureVideoDevice.exposureMode = AVCaptureExposureMode.autoExpose
            }
            
            // 白平衡 
            if captureVideoDevice.isWhiteBalanceModeSupported(AVCaptureWhiteBalanceMode.autoWhiteBalance)
            {
                captureVideoDevice.whiteBalanceMode = AVCaptureWhiteBalanceMode.autoWhiteBalance
            }
            
            captureVideoDevice.unlockForConfiguration()
        }
        
        
        let timeInterval:TimeInterval = 2.0
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + timeInterval, 
            execute: { 
            self.focusView.removeFromSuperview()
        })
    }
    
    // 双击缩放事件 
    @objc private func zoomAction(gesture:UITapGestureRecognizer) -> Void 
    {
        if ((try? captureVideoDevice.lockForConfiguration()) != nil) 
        {
            let zoomFactor:CGFloat = captureVideoDevice.videoZoomFactor == 2.0 ? 1.0:2.0
            captureVideoDevice.videoZoomFactor = zoomFactor
            captureVideoDevice.unlockForConfiguration()
            
        }
    }
    
    // MARK: - 设置睁眼动画 
    func setupEyeAnimationView() -> Void 
    {
        let eyeCopyView = eyeView.snapshotView(afterScreenUpdates: false)
        
        let eyeCopyViewWidth:CGFloat = self.videoRecordView.width
        let eyeCopyViewHeight:CGFloat = self.videoRecordView.height
        
        eyeView.alpha = 0.0
        
        let topView = eyeCopyView?.resizableSnapshotView(from: CGRect(x: 0, y: 0, width: eyeCopyViewWidth, height: eyeCopyViewHeight / 2.0), afterScreenUpdates: false, withCapInsets: UIEdgeInsets.zero)
        
        let bottomFrame = CGRect(x: 0, y: 130, width: eyeCopyViewWidth, height: eyeCopyViewHeight / 2.0)
        
        
        let bottomView = eyeCopyView?.resizableSnapshotView(from: bottomFrame, afterScreenUpdates: false, withCapInsets: UIEdgeInsets.zero)
        bottomView?.frame = bottomFrame
        print(topView as Any,"\n",bottomView as Any)
        self.videoRecordView.addSubview(topView!)
        self.videoRecordView.addSubview(bottomView!)
        
        UIView.animate(
            withDuration: 0.3, 
            delay: 0.0, 
            options: UIViewAnimationOptions.curveEaseIn, 
            animations: { 
                topView?.transform = CGAffineTransform(translationX: 0.0, y: -20)
                bottomView?.transform = CGAffineTransform(translationX: 0.0, y: 260)
                topView?.alpha = 0.3
                bottomView?.alpha = 0.3
        }) { completed in
            topView?.removeFromSuperview()
            bottomView?.removeFromSuperview()
            self.eyeView.removeFromSuperview()
            self.eyeView = nil
            self.focusInPoint(point: self.videoRecordView.center)
        }
        
        // 双击放大label 
        self.setupDoubleTapLabel()
        
    }
    
    // MARK: - 设置双击放大 label 
    func setupDoubleTapLabel() -> Void 
    {
        let doubleTapLabel = UILabel()
        doubleTapLabel.text = "双击当大"
        doubleTapLabel.font = UIFont.systemFont(ofSize: 14)
        doubleTapLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 20)
        doubleTapLabel.center = CGPoint(x: self.videoRecordView.center.x, y: self.videoRecordView.frame.maxY - 50)
        doubleTapLabel.textColor = UIColor.white
        doubleTapLabel.textAlignment = NSTextAlignment.center  //int 类型的枚举 
        self.videoRecordView.addSubview(doubleTapLabel)
        self.videoRecordView.bringSubview(toFront: doubleTapLabel)
        
        let timeInterval:TimeInterval = 1.5
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeInterval) { 
            doubleTapLabel.removeFromSuperview()
        }
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

// MARK: - ************************ extension ***********************
// MARK: - 按钮的相关事件 
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

// MARK: - ************************ extension ***********************
// MARK: - 拓展小视频相关录制方法 
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

// MARK: - ************************ extension ***********************
// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate协议方法
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

// MARK: - ************************ class ***********************
// MARK: - 眼睛视图 
class MTTEyeView: MTTView 
{
    override init(frame: CGRect) 
    {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupSubview() -> Void 
    {
        self.backgroundColor = UIColor(red: (21.0 / 255.0), green: (21.0 / 255.0), blue: (21.0 / 255.0), alpha: 1.0)
        let eyeImageView = UIImageView(frame: CGRect(x: (self.bounds.size.width - 100) / 2.0, y: (self.bounds.size.height - 70) / 2.0, width: 100, height: 70))
        eyeImageView.image = UIImage.imageNamed(name: "small_video_eye")
        self.addSubview(eyeImageView)
        
        
        // 容器 
        let containerView = UIView(frame: self.bounds)
        containerView.backgroundColor = UIColor.clear
        //self.addSubview(containerView)
        
        // 绘制path
        let selfCenter = CGPoint(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
        let eyeWidth:CGFloat = 64.0
        let eyeHeight:CGFloat = 40.0
        let curveCtrlHeitht:CGFloat = 44.0
        
        let transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        let strokePath = CGMutablePath()
        strokePath.move(to: CGPoint(x:selfCenter.x - eyeWidth / 2.0,y:selfCenter.y), transform: transform)
        
        strokePath.addQuadCurve(to: CGPoint(x:selfCenter.x,y:selfCenter.y - curveCtrlHeitht), control: CGPoint(x:selfCenter.x + eyeWidth / 2.0,y:selfCenter.y), transform: transform)
        strokePath.addQuadCurve(to: CGPoint(x:selfCenter.x,y:selfCenter.y + curveCtrlHeitht), control: CGPoint(x:selfCenter.x - eyeWidth / 2.0,y:selfCenter.y), transform: transform)
        let arcRadius:CGFloat = eyeHeight / 2.0 - 1.0;
        
        strokePath.move(to: CGPoint(x:selfCenter.x + arcRadius,y:selfCenter.y), transform: transform)
        strokePath.addArc(center: CGPoint(x:selfCenter.x, y:selfCenter.y), radius: arcRadius, startAngle: 0, endAngle: CGFloat(CGFloat(Double.pi) * 2.0), clockwise: false, transform: transform)
        
        let startAngle:CGFloat = 110.0
        let angle_one:CGFloat = startAngle + 30.0
        let angle_two:CGFloat = angle_one + 20.0
        let angle_three:CGFloat = angle_two + 10.0
        
        let arcRadius_two:CGFloat = arcRadius - 4.0
        let arcRadius_three:CGFloat = arcRadius_two - 7.0
        
        let fillPath = createPath(with: selfCenter, startAngle: changeAngleToRadius(with: startAngle), endAngle: changeAngleToRadius(with: angle_one), bigRadius: arcRadius_two, smallRadius: arcRadius_three, transform: transform)
        
        let fillPath_two = createPath(with: selfCenter, startAngle: changeAngleToRadius(with: angle_two), endAngle: changeAngleToRadius(with: angle_three), bigRadius: arcRadius_two, smallRadius: arcRadius_three, transform: transform)
        
        fillPath.addPath(fillPath_two, transform: transform)
        
        // 创建图层 
        let color = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.9)
        
        let shape_one = CAShapeLayer()
        shape_one.frame = self.bounds
        shape_one.strokeColor = color.cgColor
        shape_one.fillColor = UIColor.clear.cgColor
        shape_one.opacity = 1.0
        shape_one.lineCap = kCALineCapRound
        shape_one.lineWidth = 1.0
        shape_one.path = strokePath
        containerView.layer.addSublayer(shape_one)
        
        let shape_two = CAShapeLayer()
        shape_two.frame = self.bounds
        shape_two.strokeColor = color.cgColor
        shape_two.fillColor = color.cgColor
        shape_two.opacity = 1.0
        shape_two.lineCap = kCALineCapRound
        shape_two.lineWidth = 1.0
        shape_two.path = fillPath
        containerView.layer.addSublayer(shape_two)
        
    }
    
    // 创建所需路径 
    func createPath(with center:CGPoint, startAngle:CGFloat,endAngle:CGFloat,bigRadius:CGFloat,smallRadius:CGFloat,transform:CGAffineTransform) -> CGMutablePath 
    {
        let arcStartAngle:CGFloat = CGFloat(Double.pi) * 2.0 - startAngle
        let arcEndAngle:CGFloat = CGFloat(Double.pi) * 2.0 - endAngle
        
        let path = CGMutablePath()
        
        
        path.move(to: CGPoint(x:center.x + bigRadius * cos(startAngle), y: center.y - bigRadius * sin(startAngle)), transform: transform)
        
        path.addArc(center: center, radius: bigRadius, startAngle: arcStartAngle, endAngle: arcEndAngle, clockwise: true)
        
        path.addLine(to: CGPoint(x: center.x + smallRadius * cos(endAngle), y: center.y - smallRadius * sin(endAngle)), transform: transform)
        
        path.addArc(center: center, radius: smallRadius, startAngle: arcEndAngle, endAngle: arcStartAngle, clockwise: false)
        
        path.addLine(to: CGPoint(x: center.x + bigRadius * cos(startAngle), y: center.y - bigRadius * sin(startAngle)), transform: transform)
        
        return path
    }
    
    // 角度转换 
    func changeAngleToRadius(with angle:CGFloat) -> CGFloat 
    {
        let tmp:CGFloat = angle / 180.0 * CGFloat(Double.pi)
        print(tmp)
        return tmp
    }
}

// MARK: - ************************ class ***********************
// MARK: - 聚焦视图 
class MTTFocusView: MTTView {
    
    var originalWidthHeight:CGFloat!
    
    
    override init(frame: CGRect) 
    {
        super.init(frame: frame)
        originalWidthHeight = frame.size.height
    }
    
    override func draw(_ rect: CGRect) 
    {
        super.draw(rect)
        
        // 画一个矩形 
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(kMainBlueColor().cgColor)
        context?.setLineWidth(1.0)
        
        let len:CGFloat = 4.0
        context?.move(to: CGPoint(x: 0, y: 0))
        context?.addRect(self.bounds)
        
        context?.move(to: CGPoint(x: 0, y: originalWidthHeight / 2.0))
        context?.addLine(to: CGPoint(x: len, y: originalWidthHeight / 2.0))
        context?.move(to: CGPoint(x: originalWidthHeight / 2.0, y: originalWidthHeight))
        context?.addLine(to: CGPoint(x: originalWidthHeight / 2.0, y: originalWidthHeight - len))
        
        context?.move(to: CGPoint(x: originalWidthHeight, y: originalWidthHeight / 2.0))
        context?.addLine(to: CGPoint(x: originalWidthHeight - len, y: originalWidthHeight / 2.0))
        context?.move(to: CGPoint(x: originalWidthHeight / 2.0, y: 0))
        context?.addLine(to: CGPoint(x: originalWidthHeight / 2.0, y: len))
        context?.drawPath(using: CGPathDrawingMode.stroke)
        
        
    }
    
    // 聚焦 
    func focusing() -> Void 
    {
        let oTransform = CGAffineTransform.identity
        
        UIView.animate(withDuration: 0.5, animations: { 
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
        }) { completed in
            self.transform = oTransform
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
