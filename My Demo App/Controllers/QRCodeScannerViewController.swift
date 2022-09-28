//
//  QRCodeScannerViewController.swift
//  My Demo App
//
//  Created by Mubashir on 17/09/21.
//

import UIKit
import AVFoundation
import OSLog

class QRCodeScannerViewController: UIViewController {
    
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer!
    var qrCodeFrameView:UIView?

    private let sessionQueue = DispatchQueue(label: "session queue")
    
    @IBOutlet weak var barcodePreview: UIView!
    
    @IBOutlet weak var cartCountContView: UIView!
    
    @IBOutlet weak var cartCountLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartCountLbl.text = String(Engine.sharedInstance.cartCount)
        if Engine.sharedInstance.cartCount < 1 {
            cartCountContView.isHidden = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
                os_log("Your device not aplicable for video processing")
                return
            }
            let videoInput: AVCaptureDeviceInput
            
            do{
                videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
                
            }catch{
                os_log("Your device cant not give video input")
                return
            }
            if (self.captureSession.canAddInput(videoInput)) {
                self.captureSession.addInput(videoInput)
            }else{
                os_log("Your device can not add in capture session")
                return
            }
            
            let metadataOutput = AVCaptureMetadataOutput()
            if (self.captureSession.canAddOutput(metadataOutput)){
                self.captureSession.addOutput(metadataOutput)
                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = [.qr]
            }else{
                return
            }
            
            self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
            self.previewLayer.frame = self.barcodePreview.layer.bounds
            self.previewLayer.videoGravity = .resizeAspectFill
            self.barcodePreview.layer.addSublayer(self.previewLayer)

            self.sessionQueue.async {
                self.captureSession.startRunning()
            }
        }
      
        
    }
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func catalogButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "TabBar", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CatalogViewController") as! CatalogViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func cartButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "TabBar", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MyCartViewController") as! MyCartViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func moreButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Menu", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension QRCodeScannerViewController: AVCaptureMetadataOutputObjectsDelegate {

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {

        if let first = metadataObjects.first{
            guard let readableObject = first as? AVMetadataMachineReadableCodeObject else {
                return
            }
            guard let stringValue = readableObject.stringValue else {
                return
            }
            if stringValue.hasPrefix("http") || stringValue.hasPrefix("http") {

                if let url = URL(string: "\(stringValue)"), !url.absoluteString.isEmpty {
                    if UIApplication.shared.canOpenURL(url) {
                        os_log("App can open URL")
                        UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                            os_log("Open url : \(success)")
                       })

                    } else {
                        os_log("App cannot open URL.")
                    }
                }
            } else {
                os_log("String value received: \(stringValue) is not a URL")
            }
            os_log("Got value of: \(stringValue)")
        }else{
            os_log("Not able to read the code! Please try again or be keep your device on barcode")
        }
    }
}
