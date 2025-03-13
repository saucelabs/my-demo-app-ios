//
//  QRCodeScannerViewController.swift
//  My Demo App
//
//  Created by Mubashir on 17/09/21.
//

import UIKit
import AVFoundation
import SafariServices

class QRCodeScannerViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var barcodePreview: UIView!
    @IBOutlet weak var cartCountContView: UIView!
    @IBOutlet weak var cartCountLbl: UILabel!
    
    // MARK: - Properties
    
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    private var isCaptureSessionConfigured = false
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cartCountLbl.text = String(Engine.sharedInstance.cartCount)
        cartCountContView.isHidden = (Engine.sharedInstance.cartCount < 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Check camera permission
        checkCameraPermission()
    }
    
    // MARK: - Session Configuration
    
    private func setupCaptureSessionIfNeeded() {
        // Configure capture session once
        guard !isCaptureSessionConfigured else { return }
        isCaptureSessionConfigured = true
        // Background queue to avoid UI blocking/unresponsiveness warnings
        DispatchQueue.global(qos: .userInitiated).async {
            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
                print("Camera not available on this device.")
                return
            }
            
            do {
                let videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
                if self.captureSession.canAddInput(videoInput) {
                    self.captureSession.addInput(videoInput)
                } else {
                    print("Failed to add camera input to capture session.")
                    return
                }
            } catch {
                print("Error creating camera input: \(error.localizedDescription)")
                return
            }
            
            // Add metadata output to capture session
            let metadataOutput = AVCaptureMetadataOutput()
            if self.captureSession.canAddOutput(metadataOutput) {
                self.captureSession.addOutput(metadataOutput)
                // Update on main thread
                DispatchQueue.main.async {
                    // Set AVCaptureMetadataOutputObjects delegate
                    metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                    // Filter AVMetadataObject
                    metadataOutput.metadataObjectTypes = [.qr, .ean8, .ean13, .pdf417]
                }
            } else {
                print("Failed to add metadata output to capture session.")
                return
            }
            
            // Start capture session in background
            self.captureSession.startRunning()
            
            // Setup previewLayer UI on the main thread
            DispatchQueue.main.async {
                self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
                self.previewLayer.videoGravity = .resizeAspectFill
                self.previewLayer.frame = self.barcodePreview.bounds
                self.barcodePreview.layer.addSublayer(self.previewLayer)
            }
        }
    }
    
    // MARK: - Camera Permission
    
    private func checkCameraPermission() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            // Already authorized
            setupCaptureSessionIfNeeded()
        case .notDetermined:
            // Prompt User for permission
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if granted {
                        // User granted permission
                        self.setupCaptureSessionIfNeeded()
                    } else {
                        // User denied permission
                        self.showPermissionDeniedAlert()
                    }
                }
            }
            // Previously denied and/or restricted
        case .denied, .restricted:
            showPermissionDeniedAlert()
        @unknown default:
            showPermissionDeniedAlert()
        }
    }
    
    private func showPermissionDeniedAlert() {
        let alert = UIAlertController(
            title: "Camera Access Denied",
            message: "Enable camera access in Settings to scan QR codes.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - Button Actions
    
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

// MARK: - AVCaptureMetadataOutputObjectsDelegate

extension QRCodeScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard
            let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
            let metadataStringValue = metadataObject.stringValue,
            let url = URL(string: metadataStringValue)
        else {
            print("No valid QR code detected.")
            return
        }
        
        presentBrowserOptions(for: url)
    }
    
    /// Presents options to let user pick between in-app Safari (SFSafariViewController) or external browser (Safari).
    private func presentBrowserOptions(for url: URL) {
        let alert = UIAlertController(
            title: "Open Link",
            message: url.absoluteString,
            preferredStyle: .actionSheet
        )
        
        // Option 1: In-App SFSafariViewController
        let openInAppAction = UIAlertAction(title: "Open In-App", style: .default) { [weak self] _ in
            guard let self = self else { return }
            let safariVC = SFSafariViewController(url: url)
            safariVC.dismissButtonStyle = .close
            self.present(safariVC, animated: true)
        }
        
        // Option 2: Default external browser (Safari)
        let openInBrowserAction = UIAlertAction(title: "Open in Browser", style: .default) { _ in
            UIApplication.shared.open(url, options: [:]) { success in
                if !success {
                    print("Failed to open URL: \(url.absoluteString)")
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(openInAppAction)
        alert.addAction(openInBrowserAction)
        alert.addAction(cancelAction)
        // Anchor View
        if let popover = alert.popoverPresentationController {
            popover.sourceView = self.view
            popover.sourceRect = CGRect(x: self.view.bounds.midX,
                                        y: self.view.bounds.midY,
                                        width: 0, height: 0)
            popover.permittedArrowDirections = []
        }
        
        present(alert, animated: true)
    }
}
