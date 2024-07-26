//
//  Constants.swift
//  ClockingApp
//
//  Created by Muaaz Ahmad on 17/03/2021.
//

import Foundation

class Engine: NSObject {
    static var sharedInstance = Engine()

    var productList = [NSMutableDictionary]()
    var cartList = [NSMutableDictionary]()
    var cartCount = 0
    var totalPrice = 0.0
    
    var fullName = ""
    var addressLine1 = ""
    var addressLine2 = ""
    var city = ""
    var stateRegion = ""
    var zipCode = ""
    var country = ""
    
    var fullNameBilling = ""
    var addressLine1Billing = ""
    var addressLine2Billing = ""
    var cityBilling = ""
    var stateRegionBilling = ""
    var zipCodeBilling = ""
    var countryBilling = ""
    
    var fullNameCard = ""
    var cardNumber = ""
    var expirationDate = ""
    var securityCode = ""
    
    var isLogin = false
    var isFaceLogin = false
    var isFaceSupported = false
    var userName = ""
}


