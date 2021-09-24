//
//  CheckoutViewController.swift
//  My Demo App
//
//  Created by Mubashir on 16/09/21.
//

import UIKit

class ShippingAddressViewController: UIViewController {
    
    @IBOutlet weak var cartCountContView: UIView!
    
    @IBOutlet weak var cartCountLbl: UILabel!
    
    @IBOutlet weak var fullNameTF: TextFieldBorderColor!
    @IBOutlet weak var address1TF: TextFieldBorderColor!
    @IBOutlet weak var address2TF: TextFieldBorderColor!
    @IBOutlet weak var cityTF: TextFieldBorderColor!
    @IBOutlet weak var stateRegionTF: TextFieldBorderColor!
    @IBOutlet weak var zipCodeTF: TextFieldBorderColor!
    @IBOutlet weak var countryTF: TextFieldBorderColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartCountLbl.text = String(Engine.sharedInstance.cartCount)
        if Engine.sharedInstance.cartCount < 1 {
            cartCountContView.isHidden = true
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func toPaymentButton(_ sender: Any) {
        
        if(!fullNameTF.hasText){
            Methods.showAlertMessage(vc: self, title: "Validation Error!", message: "Please provide your full name.")
        }
        else if(!address1TF.hasText){
            Methods.showAlertMessage(vc: self, title: "Validation Error!", message: "Please provide your address.")
        }
        else if (!cityTF.hasText){
            Methods.showAlertMessage(vc: self, title: "Validation Error!", message: "Please provide your city.")
        }
        else if (!zipCodeTF.hasText){
            Methods.showAlertMessage(vc: self, title: "Validation Error!", message: "Please provide your zip.")
        }
        else if (!countryTF.hasText){
            Methods.showAlertMessage(vc: self, title: "Validation Error!", message: "Please provide your country.")
        }else{
            Engine.sharedInstance.fullName = fullNameTF.text ?? ""
            Engine.sharedInstance.addressLine1 = address1TF.text ?? ""
            Engine.sharedInstance.addressLine2 = address2TF.text ?? ""
            Engine.sharedInstance.city = cityTF.text ?? ""
            Engine.sharedInstance.stateRegion = stateRegionTF.text ?? ""
            Engine.sharedInstance.zipCode = zipCodeTF.text ?? ""
            Engine.sharedInstance.country = countryTF.text ?? ""
            
            let storyboard = UIStoryboard.init(name: "TabBar", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PaymentMethodViewController") as! PaymentMethodViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func catalogButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "TabBar", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabBar") as! CatalogViewController
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
