//
//  Utils.swift
//  Utils
//
//  Created by MacUser on 04/09/2021.
//

import UIKit
import Foundation

class Utils {
    
    public static func setProductList(includeIdInName: Bool = false)
    {
        let makeName = if includeIdInName {
            {name in String(format: "[%4d] %@", Engine.sharedInstance.productList.count, name) }
        } else {
            {name -> String in name }
        }
        
        Engine.sharedInstance.productList.append(["Id": String(Engine.sharedInstance.productList.count),
                                                  "ProductImageName":"BagBlack Image",
                                                  "ProductName":makeName(NSLocalizedString("ProductOneName", comment: "")),
                                                  "ProductPrice":"29.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("ProductOneDiscription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("ProductOneHighlights", comment: "")])
        
        Engine.sharedInstance.productList.append(["Id": String(Engine.sharedInstance.productList.count),
                                                  "ProductImageName":"BikeLight Image",
                                                  "ProductName":makeName(NSLocalizedString("ProductTwoName", comment: "")),
                                                  "ProductPrice":"9.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("ProductTwoName", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("ProductTwoName", comment: "")])
        
        Engine.sharedInstance.productList.append(["Id": String(Engine.sharedInstance.productList.count),
                                                  "ProductImageName":"ShirtBlack Image",
                                                  "ProductName":makeName(NSLocalizedString("ProductThreeName", comment: "")),
                                                  "ProductPrice":"15.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("ProductThreeName", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("ProductThreeName", comment: "")])
        
        Engine.sharedInstance.productList.append(["Id": String(Engine.sharedInstance.productList.count),
                                                  "ProductImageName":"ShirtGray Image",
                                                  "ProductName":makeName(NSLocalizedString("ProductFourName", comment: "")),
                                                  "ProductPrice":"49.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("ProductFourName", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("ProductFourName", comment: "")])
        
        Engine.sharedInstance.productList.append(["Id": String(Engine.sharedInstance.productList.count),
                                                  "ProductImageName":"ShirtRedOnesie Image",
                                                  "ProductName":makeName(NSLocalizedString("ProductFiveName", comment: "")),
                                                  "ProductPrice":"7.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("ProductFiveName", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("ProductFiveName", comment: "")])
        
        Engine.sharedInstance.productList.append(["Id": String(Engine.sharedInstance.productList.count),
                                                  "ProductImageName":"ShirtRed Image",
                                                  "ProductName":makeName(NSLocalizedString("ProductSixName", comment: "")),
                                                  "ProductPrice":"15.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("ProductSixName", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("ProductSixName", comment: "")])
    }
    
}
