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
        /* Bags Variants */
        Engine.sharedInstance.productList.append(["Id": "bag-black",
                                                  "ProductImageName":"BagBlack Image",
                                                  "ProductName":NSLocalizedString("BackPackNameBlack", comment: ""),
                                                  "ProductPrice":"29.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("BackPackDescription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("BackPackHighlights", comment: "")])
        Engine.sharedInstance.productList.append(["Id": "bag-green",
                                                  "ProductImageName":"BagGreen Image",
                                                  "ProductName":NSLocalizedString("BackPackNameGreen", comment: ""),
                                                  "ProductPrice":"29.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("BackPackDescription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("BackPackHighlights", comment: "")])
        Engine.sharedInstance.productList.append(["Id": "bag-orange",
                                                  "ProductImageName":"BagOrange Image",
                                                  "ProductName":NSLocalizedString("BackPackNameOrange", comment: ""),
                                                  "ProductPrice":"29.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("BackPackDescription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("BackPackHighlights", comment: "")])
        Engine.sharedInstance.productList.append(["Id": "bag-red",
                                                  "ProductImageName":"BagRed Image",
                                                  "ProductName":NSLocalizedString("BackPackNameRed", comment: ""),
                                                  "ProductPrice":"29.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("BackPackDescription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("BackPackHighlights", comment: "")])
        Engine.sharedInstance.productList.append(["Id": "bag-violet",
                                                  "ProductImageName":"BagViolet Image",
                                                  "ProductName":NSLocalizedString("BackPackNameViolet", comment: ""),
                                                  "ProductPrice":"29.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("BackPackDescription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("BackPackHighlights", comment: "")])
        Engine.sharedInstance.productList.append(["Id": "bag-yellow",
                                                  "ProductImageName":"BagYellow Image",
                                                  "ProductName":NSLocalizedString("BackPackNameYellow", comment: ""),
                                                  "ProductPrice":"29.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("BackPackDescription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("BackPackHighlights", comment: "")])

        
        /* Bike Light */
        Engine.sharedInstance.productList.append(["Id": "bike-light",
                                                  "ProductImageName":"BikeLight Image",
                                                  "ProductName":NSLocalizedString("LightName", comment: ""),
                                                  "ProductPrice":"9.99",
                                                  "ProductRating":"4",
                                                  "ProductDescription":NSLocalizedString("LightDescription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("LightHighlights", comment: "")])
        
        /* TShirt */
        Engine.sharedInstance.productList.append(["Id": "tshirt-black",
                                                  "ProductImageName":"TShirtBlack Image",
                                                  "ProductName":NSLocalizedString("TShirtNameBlack", comment: ""),
                                                  "ProductPrice":"15.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("TShirtDescription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("TShirtHighlights", comment: "")])
        Engine.sharedInstance.productList.append(["Id": "tshirt-blue",
                                                  "ProductImageName":"TShirtBlue Image",
                                                  "ProductName":NSLocalizedString("TShirtNameBlue", comment: ""),
                                                  "ProductPrice":"15.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("TShirtDescription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("TShirtHighlights", comment: "")])
        Engine.sharedInstance.productList.append(["Id": "tshirt-green",
                                                  "ProductImageName":"TShirtGreen Image",
                                                  "ProductName":NSLocalizedString("TShirtNameGreen", comment: ""),
                                                  "ProductPrice":"15.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("TShirtDescription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("TShirtHighlights", comment: "")])
        Engine.sharedInstance.productList.append(["Id": "tshirt-red",
                                                  "ProductImageName":"TShirtRed Image",
                                                  "ProductName":NSLocalizedString("TShirtNameRed", comment: ""),
                                                  "ProductPrice":"15.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("TShirtDescription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("TShirtHighlights", comment: "")])
        Engine.sharedInstance.productList.append(["Id": "tshirt-yellow",
                                                  "ProductImageName":"TShirtYellow Image",
                                                  "ProductName":NSLocalizedString("TShirtNameYellow", comment: ""),
                                                  "ProductPrice":"15.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("TShirtDescription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("TShirtHighlights", comment: "")])
        
        /* Jacket */
        Engine.sharedInstance.productList.append(["Id":"jacket-grey",
                                                  "ProductImageName":"JacketGray Image",
                                                  "ProductName":NSLocalizedString("JacketNameGrey", comment: ""),
                                                  "ProductPrice":"49.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("JacketDescription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("JacketHighlights", comment: "")])
        Engine.sharedInstance.productList.append(["Id":"jacket-blue",
                                                  "ProductImageName":"JacketBlue Image",
                                                  "ProductName":NSLocalizedString("JacketNameBlue", comment: ""),
                                                  "ProductPrice":"49.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("JacketDescription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("JacketHighlights", comment: "")])
        Engine.sharedInstance.productList.append(["Id":"jacket-brown",
                                                  "ProductImageName":"JacketBrown Image",
                                                  "ProductName":NSLocalizedString("JacketNameBrown", comment: ""),
                                                  "ProductPrice":"49.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("JacketDescription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("JacketHighlights", comment: "")])
        Engine.sharedInstance.productList.append(["Id":"jacket-green",
                                                  "ProductImageName":"JacketGreen Image",
                                                  "ProductName":NSLocalizedString("JacketNameGreen", comment: ""),
                                                  "ProductPrice":"49.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("JacketDescription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("JacketHighlights", comment: "")])
        Engine.sharedInstance.productList.append(["Id":"jacket-pink",
                                                  "ProductImageName":"JacketPink Image",
                                                  "ProductName":NSLocalizedString("JacketNamePink", comment: ""),
                                                  "ProductPrice":"49.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("JacketDescription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("JacketHighlights", comment: "")])
        Engine.sharedInstance.productList.append(["Id":"jacket-red",
                                                  "ProductImageName":"JacketRed Image",
                                                  "ProductName":NSLocalizedString("JacketNameRed", comment: ""),
                                                  "ProductPrice":"49.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("JacketDescription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("JacketHighlights", comment: "")])
        
        /* Onesie */
        Engine.sharedInstance.productList.append(["Id": "onesie",
                                                  "ProductImageName":"ShirtRedOnesie Image",
                                                  "ProductName":NSLocalizedString("OnesieName", comment: ""),
                                                  "ProductPrice":"7.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("OnesieDescription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("OnesieHightlights", comment: "")])
        
        /* Shirt */
        Engine.sharedInstance.productList.append(["Id": "shirt-red",
                                                  "ProductImageName":"ShirtRed Image",
                                                  "ProductName":NSLocalizedString("ShirtNameRed", comment: ""),
                                                  "ProductPrice":"15.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("ShirtDescription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("ShirtHighlights", comment: "")])
        Engine.sharedInstance.productList.append(["Id": "shirt-orange",
                                                  "ProductImageName":"ShirtOrange Image",
                                                  "ProductName":NSLocalizedString("ShirtNameOrange", comment: ""),
                                                  "ProductPrice":"15.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("ShirtDescription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("ShirtHighlights", comment: "")])
        Engine.sharedInstance.productList.append(["Id": "shirt-pink",
                                                  "ProductImageName":"ShirtPink Image",
                                                  "ProductName":NSLocalizedString("ShirtNamePink", comment: ""),
                                                  "ProductPrice":"15.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("ShirtDescription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("ShirtHighlights", comment: "")])
        Engine.sharedInstance.productList.append(["Id": "shirt-purple",
                                                  "ProductImageName":"ShirtPurple Image",
                                                  "ProductName":NSLocalizedString("ShirtNamePurple", comment: ""),
                                                  "ProductPrice":"15.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("ShirtDescription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("ShirtHighlights", comment: "")])
        Engine.sharedInstance.productList.append(["Id": "shirt-turquoise",
                                                  "ProductImageName":"ShirtTurquoise Image",
                                                  "ProductName":NSLocalizedString("ShirtNameTurquoise", comment: ""),
                                                  "ProductPrice":"15.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("ShirtDescription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("ShirtHighlights", comment: "")])
        Engine.sharedInstance.productList.append(["Id": "shirt-yellow",
                                                  "ProductImageName":"ShirtYellow Image",
                                                  "ProductName":NSLocalizedString("ShirtNameYellow", comment: ""),
                                                  "ProductPrice":"15.99",
                                                  "ProductRating":"4",
                                                  "ProductDiscription":NSLocalizedString("ShirtDescription", comment: ""),
                                                  "ProductHighlights":NSLocalizedString("ShirtHighlights", comment: "")])
    }
    
}
