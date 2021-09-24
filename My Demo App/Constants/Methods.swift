//
//  Engine.swift
//  Proven
//
//  Created by Mubashir on 28/07/2021.
//

import UIKit
import Foundation

class Methods: NSObject {
    
    class func showAlertMessage(vc: UIViewController, title: NSString, message: NSString) {
        let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        vc.present(alert, animated: true)
    }
    
    class func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    class func isValidPhone(phone:String) -> Bool {
        let phoneRegEx = "^[0-9]{10,11}$"
        
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: phone)
    
    }
    
    class func showAlertMessage(title: String, message: String, controller: UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
            
        }))
        controller.present(alert, animated: true, completion: {
            print("completion block")
        })
        
    }
    
    class func showAlertMessageAndBringToBack(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action: UIAlertAction!) in
            vc.navigationController?.popViewController(animated: true)
            let defaults = UserDefaults.standard
            defaults.set(false, forKey: "abnSelected")
            defaults.set(false, forKey: "gstSelected")
            defaults.set(false, forKey: "fuelSelected")
        }))
        
        vc.present(alert, animated: true)
    }
}
