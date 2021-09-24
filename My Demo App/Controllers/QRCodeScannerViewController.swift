//
//  QRCodeScannerViewController.swift
//  My Demo App
//
//  Created by Mubashir on 17/09/21.
//

import UIKit
import AVFoundation

class QRCodeScannerViewController: UIViewController {
    
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer!
    
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
                print("Your device not aplicable for video processing")
                return
            }
            let videoInput: AVCaptureDeviceInput
            
            do{
                videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
                
            }catch{
                print("Your device cant not give video input")
                return
            }
            if (self.captureSession.canAddInput(videoInput)) {
                self.captureSession.addInput(videoInput)
            }else{
                print("Your device can not add in capture session")
                return
            }
            
            let metadataOutput = AVCaptureMetadataOutput()
            if (self.captureSession.canAddOutput(metadataOutput)){
                self.captureSession.addOutput(metadataOutput)
                
                metadataOutput.metadataObjectTypes = [.ean8,.ean13,.pdf417]
            }else{
                return
            }
            
            self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
            self.previewLayer.frame = self.barcodePreview.layer.bounds
            self.previewLayer.videoGravity = .resizeAspectFill
            self.barcodePreview.layer.addSublayer(self.previewLayer)
            self.captureSession.startRunning()
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
        }else{
            print("Not able to reade the code! Please try agian or be keep your divice on bar code")
        }
    }
}
