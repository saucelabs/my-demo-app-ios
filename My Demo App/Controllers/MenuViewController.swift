//
//  MenuViewController.swift
//  My Demo App
//
//  Created by Mubashir on 17/09/21.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var loginBtnLbl: UILabel!
    @IBOutlet weak var cartCountContView: UIView!
    
    @IBOutlet weak var cartCountLbl: UILabel!
    
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
    
    @IBAction func webViewButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Menu", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        self.navigationController?.pushViewController(vc, animated: true)
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
        
    }
    
    @IBAction func faceIdButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Menu", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FaceIdViewController") as! FaceIdViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func logoutButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Authentication", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.isLogout = true
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
}
