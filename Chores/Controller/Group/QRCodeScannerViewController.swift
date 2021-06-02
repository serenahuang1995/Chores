//
//  QRCodeScannerViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/6/1.
//

import UIKit
import AVFoundation

class QRCodeScannerViewController: UIViewController {
    
    var captureSession = AVCaptureSession()
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var qrCodeFrameView: UIView?
    
    var canCatch: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpCamera()
    }
    
    func setUpCamera() {
        
        // 取得後置鏡頭來擷取影片
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                for: .video,
                position: .back) else {
            
            print("Failed to get the camera device")
            
            return
        }

        do {
            // 使用前一個裝置物件來取得 AVCaptureDeviceInput 類別的實例
            let input = try AVCaptureDeviceInput(device: captureDevice)

            // 在擷取 session 設定輸入裝置
            captureSession.addInput(input)
            
            // 初始化一個AVCaptureMetadataOutput物件並將其設定作為擷取session的輸出裝置
            let captureMetadataOutput = AVCaptureMetadataOutput()
            
            captureSession.addOutput(captureMetadataOutput)
            
            // 初始化影片預覽層，並將其作為子層加入 viewPreview 視圖的圖層中
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            
            view.layer.addSublayer(videoPreviewLayer!)
            
            setUpQRCodeView()
            // Start video capture.
            captureSession.startRunning()
            
            // Move the message label and top bar to the front
//            view.bringSubviewToFront(contentLabel)
//            view.bringSubviewToFront(topbarView)

            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]

        } catch {
            // 假如有錯誤產生、單純輸出其狀況不再繼續執行
            print(error)
            
            return
        }
    }
    
    // Initialize QR Code Frame to highlight the QR code
    func setUpQRCodeView() {
        
        qrCodeFrameView = UIView()
        
        if let qrCodeFrameView = qrCodeFrameView {
            
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            
            qrCodeFrameView.layer.borderWidth = 2
            
            view.addSubview(qrCodeFrameView)
            
            view.bringSubviewToFront(qrCodeFrameView)
        }
    }
    
    // 去找被掃到的人是不是一個存在的 user
    func fetchUser(userId: String) {
        
        UserProvider.shared.fetchOwner(userId: userId) { [weak self] result in
            
            switch result {
            
            case .success(let user):
                
                print(user)
                
                self?.sendInvitation(user: user)
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    // 對誰發送邀請
    func sendInvitation(user: User) {
        
        let invitation = Invitation(
            group: UserProvider.shared.user.groupId ?? "",
            name: UserProvider.shared.user.name,
            id: "")
        
        UserProvider.shared.sendInviation(invitation: invitation,
                                          userId: user.id) { result in
            
            switch result {
            
            case .success(let message):
                
                print(message)
                
            case .failure(let error):
                
                print(error)
            }
        }
    }

}

extension QRCodeScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        // 檢查  metadataObjects 陣列為非空值，它至少需包含一個物件
        if metadataObjects.count == 0 {
            
            qrCodeFrameView?.frame = CGRect.zero
//            messageLabel.text = "No QR code is detected"
            return
        }

        // 取得元資料（metadata）物件
        guard let metadataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else { return }

        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            // 倘若發現的元資料與 QR code 元資料相同，便更新狀態標籤的文字並設定邊界
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            // 拿到掃到的 QRCode 字串
            if let userId = metadataObj.stringValue {
                
                // 如果有抓到 第一次才去fetch 後面就不要在fetch
                if canCatch {
                    
                    print(userId)
                    
                    fetchUser(userId: userId)
                    
                    canCatch = false
                }
                //                self.userId = metadataObj.stringValue
                
                //                messageLabel.text = metadataObj.stringValue
            }
        }
    }

}
