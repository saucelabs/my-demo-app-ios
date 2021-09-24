//
//  Utils.swift
//  Utils
//
//  Created by MacUser on 04/09/2021.
//

import UIKit
import Foundation

class Utils {
    
    public static func setProductList()
    {
        Engine.sharedInstance.productList.append(["Id":"1",
                                                  "ProductImageName":"BagBlack Image",
                                                  "ProductName":"Sauce Lab Back Packs",
                                                  "ProductPrice":"29.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":"carry.allTheThings() with the sleek, streamlined Sly that melds uncompromising style with unequaled laptop and tablet protection.",
                                                  "ProductHighlights":"carry.allTheThings() with the sleek, streamlined Sly that melds uncompromising style with unequaled laptop and tablet protection."])
        
        Engine.sharedInstance.productList.append(["Id":"2",
                                                  "ProductImageName":"BikeLight Image",
                                                  "ProductName":"Sauce Lab Bike Light",
                                                  "ProductPrice":"9.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":"A red light isn't the desire state in testing but it sure helps when riding your bike at night.",
                                                  "ProductHighlights":"A red light isn't the desire state in testing but it sure helps when riding your bike at night."])
        
        Engine.sharedInstance.productList.append(["Id":"3",
                                                  "ProductImageName":"ShirtBlack Image",
                                                  "ProductName":"Sauce Lab Bolt T-Shirt",
                                                  "ProductPrice":"15.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":"Get your testing superhero on with the sauce Labs bolt T-Shirt. From American Apparel, 100% ringspun combed cotton gray red bolt.",
                                                  "ProductHighlights":"Get your testing superhero on with the sauce Labs bolt T-Shirt. From American Apparel, 100% ringspun combed cotton gray red bolt."])
        
        Engine.sharedInstance.productList.append(["Id":"4",
                                                  "ProductImageName":"ShirtGray Image",
                                                  "ProductName":"Sauce Lab Fleece T-Shirt",
                                                  "ProductPrice":"49.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":"Its not everyday that you come across a midweight quarter-zip fleec jacket capable of handling everything from a relaxing day outdoors to a busy day at the office.",
                                                  "ProductHighlights":"Its not everyday that you come across a midweight quarter-zip fleec jacket capable of handling everything from a relaxing day outdoors to a busy day at the office."])
        
        Engine.sharedInstance.productList.append(["Id":"5",
                                                  "ProductImageName":"ShirtRedOnesie Image",
                                                  "ProductName":"Sauce Lab Onesie",
                                                  "ProductPrice":"7.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":"The Sauce Labs Backpack is the best of all worlds infinite capacity and endless style. Fit in comfortably a laptop up to 15 inch. Never leave a thing behind and forget you have your world on your shoulders.",
                                                  "ProductHighlights":"The Sauce Labs Backpack is the best of all worlds infinite capacity and endless style. Fit in comfortably a laptop up to 15 inch. Never leave a thing behind and forget you have your world on your shoulders."])
        
        Engine.sharedInstance.productList.append(["Id":"6",
                                                  "ProductImageName":"ShirtRed Image",
                                                  "ProductName":"Test.sllTheThings() T-Shirt",
                                                  "ProductPrice":"15.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":"The classic Sauce Labs t-shirts is perfect to wear when cozying up to your keboard to automate a few tests. Super-soft and comfly ringspun combed cotton.",
                                                  "ProductHighlights":"The classic Sauce Labs t-shirts is perfect to wear when cozying up to your keboard to automate a few tests. Super-soft and comfly ringspun combed cotton."])
    }
    
}
