//
//  ViewController.swift
//  My Demo App
//
//  Created by Mubashir on 15/09/21.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTF: TextFieldBorderColor!
    @IBOutlet weak var passwordTF: TextFieldBorderColor!
    
    @IBOutlet weak var myCartLbl: UILabel!
    @IBOutlet weak var cartCountLbl: UILabel!
    
    @IBOutlet weak var backBtnContVew: UIView!
    @IBOutlet weak var cartCountContView: UIView!
    @IBOutlet weak var faceLoginContView: UIView!
    
    var isFromProcessCheckout = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartCountLbl.text = String(Engine.sharedInstance.cartCount)
        
        if Engine.sharedInstance.cartCount < 1 {
            cartCountContView.isHidden = true
        }
        
        if !isFromProcessCheckout{
            backBtnContVew.isHidden = true
            myCartLbl.isHidden = true
        }
        if Engine.sharedInstance.isFaceSupported && Engine.sharedInstance.isFaceLogin{
            faceLoginContView.isHidden = false
        }else{
            faceLoginContView.isHidden = true
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func faceLoginButton(_ sender: Any) {
        FaceIdlocalAuthentication()
    }
    
    @IBAction func emailButton(_ sender: UIButton) {
        userNameTF.text = sender.titleLabel?.text
        passwordTF.text = "10203040"
    }
    
    @IBAction func LoginButton(_ sender: Any) {
        if(!userNameTF.hasText){
            Methods.showAlertMessage(vc: self, title: "Validation Error!", message: "Username is required")
        }
        else if (!passwordTF.hasText) {
            Methods.showAlertMessage(vc: self, title: "Validation Error!", message: "Password is required")
        }
        else {
            if isFromProcessCheckout{
                let storyboard = UIStoryboard.init(name: "TabBar", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ShippingAddressViewController") as! ShippingAddressViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else{
                let storyboard = UIStoryboard.init(name: "TabBar", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "CatalogViewController") as! CatalogViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            Engine.sharedInstance.isLogin = true
            Engine.sharedInstance.userName = userNameTF.text ?? ""
        }
        Engine.sharedInstance.productList.removeAll();
        Utils.setProductList();
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
    
 func FaceIdlocalAuthentication() -> Void {
        let laContext = LAContext()
        var error: NSError?
        let biometricsPolicy = LAPolicy.deviceOwnerAuthenticationWithBiometrics
        
        if (laContext.canEvaluatePolicy(biometricsPolicy, error: &error)) {
            
            if let laError = error {
                print("laError - \(laError)")
                return
            }
            
            var localizedReason = "Unlock device"
            if #available(iOS 11.0, *) {
                if (laContext.biometryType == LABiometryType.faceID) {
                    localizedReason = "Unlock using Face ID"
                    print("FaceId support")
                } else {
                    print("No FaceId support")
                }
            } else {
                // Fallback on earlier versions
            }
            
            
            laContext.evaluatePolicy(biometricsPolicy, localizedReason: localizedReason, reply: { (isSuccess, error) in
                
                DispatchQueue.main.async(execute: {
                    
                    if let laError = error {
                        print("laError - \(laError)")
                    } else {
                        if isSuccess {
                            Engine.sharedInstance.isLogin = true
                            let storyboard = UIStoryboard.init(name: "TabBar", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "ShippingAddressViewController") as! ShippingAddressViewController
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                    
                })
            })
        }
        
        
    }
}

