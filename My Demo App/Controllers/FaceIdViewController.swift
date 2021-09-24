//
//  FaceIdViewController.swift
//  My Demo App
//
//  Created by Mubashir on 17/09/21.
//

import UIKit

class FaceIdViewController: UIViewController {
    
    @IBOutlet weak var allowLoginFaceBtn: UIButton!
    @IBOutlet weak var faceLoginMainBtn: UIButton!
    
    @IBOutlet weak var cartCountContView: UIView!
    
    @IBOutlet weak var cartCountLbl: UILabel!
    @IBOutlet weak var allowFaceIdLbl: UILabel!
    @IBOutlet weak var useFaceLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Engine.sharedInstance.cartCount < 1 {
            cartCountContView.isHidden = true
        }
        
        if !Engine.sharedInstance.isFaceSupported {
            allowLoginFaceBtn.isUserInteractionEnabled = false
            faceLoginMainBtn.isUserInteractionEnabled = false
            allowFaceIdLbl.textColor = .gray
            useFaceLbl.textColor = .gray
        }
        
        cartCountLbl.text = String(Engine.sharedInstance.cartCount)
        allowLoginFaceBtn.isSelected = false
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func allowLoginFaceButton(_ sender: UIButton) {
        if allowLoginFaceBtn.isSelected {
            allowLoginFaceBtn.isSelected = false
            Engine.sharedInstance.isFaceLogin = false
        }else{
            allowLoginFaceBtn.isSelected = true
            Engine.sharedInstance.isFaceLogin = true
        }
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
