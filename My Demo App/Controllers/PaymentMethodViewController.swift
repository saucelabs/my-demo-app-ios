//
//  PaymentMethodViewController.swift
//  My Demo App
//
//  Created by Mubashir on 16/09/21.
//

import UIKit
import FormTextField
import EasyTipView

class PaymentMethodViewController: UIViewController, UITextFieldDelegate,EasyTipViewDelegate {
    @IBOutlet weak var billingAddresBtn: UIButton!
    @IBOutlet weak var securityCodeTipBtn: UIButton!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var billingAddressView: UIView!
    @IBOutlet weak var cartCountContView: UIView!
    
    @IBOutlet weak var cartCountLbl: UILabel!
    
    @IBOutlet weak var fullNameCardTF: TextFieldBorderColor!
    @IBOutlet weak var cardNumberTF: FormTextField!
    @IBOutlet weak var expirationDateTF: FormTextField!
    @IBOutlet weak var securityCodeTF: FormTextField!
    
    @IBOutlet weak var fullNameTF: TextFieldBorderColor!
    @IBOutlet weak var address1TF: TextFieldBorderColor!
    @IBOutlet weak var address2TF: TextFieldBorderColor!
    @IBOutlet weak var cityTF: TextFieldBorderColor!
    @IBOutlet weak var stateRegionTF: TextFieldBorderColor!
    @IBOutlet weak var zipCodeTF: TextFieldBorderColor!
    @IBOutlet weak var countryTF: TextFieldBorderColor!
    
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var billingAddressViewHeight: NSLayoutConstraint!
    
    var isBillingSame = false
    var preferences = EasyTipView.Preferences()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartCountLbl.text = String(Engine.sharedInstance.cartCount)
        
        if Engine.sharedInstance.cartCount < 1 {
            cartCountContView.isHidden = true
        }
        
        billingAddresBtn.isSelected = true
        isBillingSame = true
        
        if billingAddresBtn.isSelected == true {
            mainViewHeight.constant = 615
            billingAddressView.isHidden = true
        }else{
            mainViewHeight.constant = 1100
            billingAddressView.isHidden = false
        }
        toolTipPreferences()
        formTextFieldValidation()
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func securityCodeTipButton(_ sender: Any) {
        securityCodeTipBtn.isUserInteractionEnabled = false
        showToolTip()
    }
    
    @IBAction func billingAddressButton(_ sender: UIButton) {
        if billingAddresBtn.isSelected {
            billingAddresBtn.isSelected = false
            mainViewHeight.constant = 1100
            billingAddressView.isHidden = false
            isBillingSame = false
        }else{
            billingAddresBtn.isSelected = true
            mainViewHeight.constant = 615
            billingAddressView.isHidden = true
            isBillingSame = true
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
    
    @IBAction func reviewOrderButton(_ sender: Any) {
        
        if(!fullNameCardTF.hasText){
            Methods.showAlertMessage(vc: self, title: "Validation Error!", message: "Value looks invalid.")
        }
        if(!cardNumberTF.hasText){
            Methods.showAlertMessage(vc: self, title: "Validation Error!", message: "Value looks invalid.")
        }
        if (!expirationDateTF.hasText){
            Methods.showAlertMessage(vc: self, title: "Validation Error!", message: "Value looks invalid.")
        }
        if billingAddresBtn.isSelected == false {
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
            }
        }
        Engine.sharedInstance.fullNameBilling = fullNameTF.text ?? ""
        Engine.sharedInstance.addressLine1Billing = address1TF.text ?? ""
        Engine.sharedInstance.addressLine2Billing = address2TF.text ?? ""
        Engine.sharedInstance.cityBilling = cityTF.text ?? ""
        Engine.sharedInstance.stateRegionBilling = stateRegionTF.text ?? ""
        Engine.sharedInstance.zipCodeBilling = zipCodeTF.text ?? ""
        Engine.sharedInstance.countryBilling = countryTF.text ?? ""
        
        Engine.sharedInstance.fullNameCard = fullNameCardTF.text ?? ""
        Engine.sharedInstance.cardNumber = cardNumberTF.text ?? ""
        Engine.sharedInstance.expirationDate = expirationDateTF.text ?? ""
            
        let storyboard = UIStoryboard.init(name: "TabBar", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ReviewYourOrderViewController") as! ReviewYourOrderViewController
        vc.isBillingSame = isBillingSame
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension PaymentMethodViewController {
    func toolTipPreferences() {
        preferences.drawing.font = UIFont(name: "ProximaNova-Medium", size: 15)!
        preferences.drawing.foregroundColor = UIColor.white
        preferences.drawing.backgroundColor = UIColor.black
        preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.bottom
    }
    
    func formTextFieldValidation() {
        let cardNumberPlaceholderText = NSAttributedString(string: "3258 1265 7568 7896",
                                                           attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 0.4274509804, green: 0.4588235294, blue: 0.5176470588, alpha: 1))])
        let expirationDatePlaceholderText = NSAttributedString(string: "03/25",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 0.4274509804, green: 0.4588235294, blue: 0.5176470588, alpha: 1))])
        let securityCodePlaceholderText = NSAttributedString(string: "123",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 0.4274509804, green: 0.4588235294, blue: 0.5176470588, alpha: 1))])
        
        cardNumberTF.borderWidth = 0.7
        cardNumberTF.layer.cornerRadius = 5
        cardNumberTF.layer.borderColor = #colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.6980392157, alpha: 1)
        cardNumberTF.attributedPlaceholder = cardNumberPlaceholderText
        
        expirationDateTF.borderWidth = 0.7
        expirationDateTF.layer.cornerRadius = 5
        expirationDateTF.layer.borderColor = #colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.6980392157, alpha: 1)
        expirationDateTF.attributedPlaceholder = expirationDatePlaceholderText
        
        securityCodeTF.borderWidth = 0.7
        securityCodeTF.layer.cornerRadius = 5
        securityCodeTF.layer.borderColor = #colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.6980392157, alpha: 1)
        securityCodeTF.attributedPlaceholder = securityCodePlaceholderText
        
        cardNumberTF.inputType = .integer
        cardNumberTF.formatter = CardNumberFormatter()
        var validation = Validation()
        validation.minimumLength = "1234 5678 1234 5678".count
        validation.maximumLength = "1234 5678 1234 5678".count
        let characterSet = NSMutableCharacterSet.decimalDigit()
        characterSet.addCharacters(in: " ")
        validation.characterSet = characterSet as CharacterSet
        var inputValidator = InputValidator(validation: validation)
        cardNumberTF.inputValidator = inputValidator
        
        expirationDateTF.inputType = .integer
        expirationDateTF.formatter = CardExpirationDateFormatter()
        validation = Validation()
        validation.minimumLength = 1
        let inputValidatorExpiry = CardExpirationDateInputValidator(validation: validation)
        expirationDateTF.inputValidator = inputValidatorExpiry
        
        securityCodeTF.inputType = .integer
        validation = Validation()
        validation.maximumLength = "CVC".count
        validation.minimumLength = "CVC".count
        validation.characterSet = CharacterSet.decimalDigits
        inputValidator = InputValidator(validation: validation)
        securityCodeTF.inputValidator = inputValidator
    }
    
    func easyTipViewDidTap(_ tipView: EasyTipView) {
        print("\(tipView) did tap!")
        securityCodeTipBtn.isUserInteractionEnabled = true
    }
    
    func easyTipViewDidDismiss(_ tipView: EasyTipView) {
        print("\(tipView) did dismiss!")
        securityCodeTipBtn.isUserInteractionEnabled = true
    }
    
    func showToolTip() {
        EasyTipView.show(forView: self.securityCodeTipBtn, withinSuperview : self.mainView , text: "CVV is the last three digits on the back of your credit card.",preferences:self.preferences,delegate: self)
    }
}
