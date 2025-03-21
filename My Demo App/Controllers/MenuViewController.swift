//
//  MenuViewController.swift
//  My Demo App
//
//  Created by Mubashir on 17/09/21.
//

import UIKit
import Backtrace

class MenuViewController: UIViewController {
    
    @IBOutlet weak var loginBtnLbl: UILabel!
    @IBOutlet weak var cartCountContView: UIView!
    
    @IBOutlet weak var cartCountLbl: UILabel!
    
    enum CustomError: Error {
        case runtimeError
    }

    func throwingFunc() throws {
        throw CustomError.runtimeError
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartCountLbl.text = String(Engine.sharedInstance.cartCount)
        if Engine.sharedInstance.cartCount < 1 {
            cartCountContView.isHidden = true
        }
        
        if Engine.sharedInstance.isLogin{
            loginBtnLbl.text = "Log Out"
        }else{
            loginBtnLbl.text = "Login"
        }
    }
    
    @IBAction func crashButton(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let invalidPointer = UnsafeMutableRawPointer(bitPattern: 0x1)!
            invalidPointer.storeBytes(of: 0xDEADBEEF as UInt32, as: UInt32.self)
        }
    }

    @IBAction func webViewButton(_ sender: Any) {
        do {
            try throwingFunc()
        } catch let error as CustomError {
            switch error {
            case .runtimeError:
                let exception = NSException(
                    name: NSExceptionName(rawValue: "RuntimeError Handled Exception"),
                    reason: "Caught CustomError.runtimeError",
                    userInfo: ["error": "\(error)"]
                )
                BacktraceClient.shared?.send(exception: exception, attachmentPaths: [], completion: { (result: BacktraceResult) in
                    print("Backtrace: \(result)")
                })
            }
        } catch {
            print("Unexpected error: \(error)")
        }

        let exception = NSException(
            name: NSExceptionName.characterConversionException,
            reason: "custom reason",
            userInfo: ["testUserInfo": "tests"]
        )
        BacktraceClient.shared?.send(exception: exception, attachmentPaths: [], completion: { (result: BacktraceResult) in
            print("Test Exception: \(result)")
        })
    }
    
    @IBAction func qrCodeScannerButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Menu", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "QRCodeScannerViewController") as! QRCodeScannerViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func geoLocationButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Menu", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GeoLocationViewController") as! GeoLocationViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func drawingButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Menu", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DrawingViewController") as! DrawingViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func aboutButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Menu", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func resetAppStateButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Reset App State", message: "Are you sure you want to reset the app state", preferredStyle: .alert)
        
        let resetAppAction = UIAlertAction(title: "RESET APP", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.resetAppState()
        }
        let cancelAction = UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(resetAppAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
        if Engine.sharedInstance.cartCount < 1 {
            cartCountContView.isHidden = true
        }
    }
    
    @IBAction func faceIdButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Menu", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FaceIdViewController") as! FaceIdViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func logoutButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Authentication", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        Engine.sharedInstance.isLogin = false
        loginBtnLbl.text = "Login"
        self.navigationController?.pushViewController(vc, animated: true)
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
        
    }
    
    @IBAction func reportABug() {
        TestFairyWrapper.showFeedbackForm()
    }
    
    @IBAction func reportABugDebug() {
        let storyboard = UIStoryboard.init(name: "Menu", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ErrorReportingViewController") as! ErrorReportingViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func pushNotification() {
        let storyboard = UIStoryboard.init(name: "Menu", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PushNotificationsViewController") as! PushNotificationsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func resetAppState() {
        Engine.sharedInstance.cartList.removeAll()
        Engine.sharedInstance.cartCount = 0
        Engine.sharedInstance.totalPrice = 0.0
        
        Engine.sharedInstance.fullName = ""
        Engine.sharedInstance.addressLine1 = ""
        Engine.sharedInstance.addressLine2 = ""
        Engine.sharedInstance.city = ""
        Engine.sharedInstance.stateRegion = ""
        Engine.sharedInstance.zipCode = ""
        Engine.sharedInstance.country = ""
        
        Engine.sharedInstance.fullNameBilling = ""
        Engine.sharedInstance.addressLine1Billing = ""
        Engine.sharedInstance.addressLine2Billing = ""
        Engine.sharedInstance.cityBilling = ""
        Engine.sharedInstance.stateRegionBilling = ""
        Engine.sharedInstance.zipCodeBilling = ""
        Engine.sharedInstance.countryBilling = ""
        
        Engine.sharedInstance.fullNameCard = ""
        Engine.sharedInstance.cardNumber = ""
        Engine.sharedInstance.expirationDate = ""
        Engine.sharedInstance.securityCode = ""
        
        cartCountLbl.text = String(Engine.sharedInstance.cartCount)
        if Engine.sharedInstance.cartCount < 1 {
            cartCountContView.isHidden = true
        }
        
        Methods.showAlertMessage(title: "App State has been reset.", message: "", controller: self)
    }
}
