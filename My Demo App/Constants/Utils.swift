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
                                                  "ProductName":NSLocalizedString("ProductOneName", comment: ""),
                                                  "ProductPrice":"29.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("ProductOneDiscription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("ProductOneHighlights", comment: "")])
        
        Engine.sharedInstance.productList.append(["Id":"2",
                                                  "ProductImageName":"BikeLight Image",
                                                  "ProductName":NSLocalizedString("ProductTwoName", comment: ""),
                                                  "ProductPrice":"9.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("ProductTwoName", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("ProductTwoName", comment: "")])
        
        Engine.sharedInstance.productList.append(["Id":"3",
                                                  "ProductImageName":"ShirtBlack Image",
                                                  "ProductName":NSLocalizedString("ProductThreeName", comment: ""),
                                                  "ProductPrice":"15.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("ProductThreeName", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("ProductThreeName", comment: "")])
        
        Engine.sharedInstance.productList.append(["Id":"4",
                                                  "ProductImageName":"ShirtGray Image",
                                                  "ProductName":NSLocalizedString("ProductFourName", comment: ""),
                                                  "ProductPrice":"49.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("ProductFourName", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("ProductFourName", comment: "")])
        
        Engine.sharedInstance.productList.append(["Id":"5",
                                                  "ProductImageName":"ShirtRedOnesie Image",
                                                  "ProductName":NSLocalizedString("ProductFiveName", comment: ""),
                                                  "ProductPrice":"7.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("ProductFiveName", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("ProductFiveName", comment: "")])
        
        Engine.sharedInstance.productList.append(["Id":"6",
                                                  "ProductImageName":"ShirtRed Image",
                                                  "ProductName":NSLocalizedString("ProductSixName", comment: ""),
                                                  "ProductPrice":"15.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("ProductSixName", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("ProductSixName", comment: "")])
    }
    
}
