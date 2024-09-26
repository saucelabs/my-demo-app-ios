//
//  ProductPageDetailViewController.swift
//  My Demo App
//
//  Created by Mubashir on 20/09/21.
//

import UIKit

class ProductPageDetailViewController: UIViewController {
    @IBOutlet weak var greenBtn: UIButton!
    @IBOutlet weak var blueBtn: UIButton!
    @IBOutlet weak var blackBtn: UIButton!
    @IBOutlet weak var grayBtn: UIButton!
    @IBOutlet weak var subtractBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var addToCartBtn: ButtonRoundCorner!
    
    @IBOutlet weak var cartCountContView: UIView!
    @IBOutlet weak var ratingView: RatingController!
    
    @IBOutlet weak var productDescriptionTV: UITextView!
    @IBOutlet weak var productHighlightsTV: UITextView!
    
    @IBOutlet weak var cartCountLbl: UILabel!
    @IBOutlet weak var productCountLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    
    @IBOutlet weak var productIV: UIImageView!
    
    var productImageName = ""
    var productName = ""
    var productPrice = ""
    var productHighlights = ""
    var productId = ""
    var productRating = 1
    var selectedColor = "Green"
    var productQuantity = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Engine.sharedInstance.cartCount < 1 {
            cartCountContView.isHidden = true
        }
        
        productIV.image = UIImage(named: productImageName)
        productNameLbl.text = productName
        productPriceLbl.text = "$ " + productPrice
        productHighlightsTV.text = productHighlights
        productDescriptionTV.text = productHighlights
        cartCountLbl.text = String(Engine.sharedInstance.cartCount)
        
        
        if productName.starts(with:"Test.allTheThings() T-Shirt") || productName.starts(with:"Sauce Labs Onesie") {
            blueBtn.isHidden = true
            greenBtn.isSelected = true
            selectedColor = "Green"
        }else if productName.starts(with: "Sauce Labs Bolt T-Shirt") || productName.starts(with: "Sauce Labs Bike Light") {
            blueBtn.isHidden = true
            grayBtn.isHidden = true
            greenBtn.isHidden = true
            blackBtn.isSelected = true
            selectedColor = "Black"
        }else if productName.starts(with: "Sauce Labs Fleece T-Shirt") {
            blueBtn.isHidden = true
            blackBtn.isHidden = true
            greenBtn.isHidden = true
            grayBtn.isSelected = true
            selectedColor = "Gray"
        }else if productName.starts(with: "Sauce Labs Backpack") {
            greenBtn.isSelected = true
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "TabBar", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CatalogViewController") as! CatalogViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func ratingButton(_ sender: Any) {
        Methods.showAlertMessage(vc: self, title: "", message: "Thank you for submitting your review!")
    }
    
    @IBAction func greenButton(_ sender: UIButton) {
        selection(button: sender)
        selectedColor = "Green"
    }
    
    @IBAction func blueButton(_ sender: UIButton) {
        selection(button: sender)
        selectedColor = "Blue"
    }
    
    @IBAction func blackButton(_ sender: UIButton) {
        selection(button: sender)
        selectedColor = "Black"
    }
    
    @IBAction func grayButton(_ sender: UIButton) {
        selection(button: sender)
        selectedColor = "Gray"
    }
    
    @IBAction func addToCartButton(_ sender: Any) {
        
        Engine.sharedInstance.cartCount += productQuantity
        cartCountLbl.text = String(Engine.sharedInstance.cartCount)
        var productIndex = 0
        var  isAlready =  false
        
        for product in Engine.sharedInstance.cartList {
            let Id = product["Id"] as! String
            let color = product["ProductColor"] as! String
            
            if Id == productId && color == selectedColor {
                isAlready = true
               break
            }
            
            productIndex += 1
        }
        
        if(isAlready){
            let productFound = Engine.sharedInstance.cartList[productIndex]
            let quantity =  productFound.value(forKey: "ProductQuantity") as! Int + productQuantity
            productFound.setValue(quantity, forKey: "ProductQuantity")
        }else{
            Engine.sharedInstance.cartList.append(["Id":productId,
                                                      "ProductImageName":productImageName,
                                                      "ProductName":productName,
                                                      "ProductPrice":productPrice,
                                                      "ProductRating":"4",
                                                      "ProductDiscription":productHighlights,
                                                      "ProductHighlights":productHighlights,"ProductColor":selectedColor,"ProductQuantity":productQuantity,"ProductRating":productRating])
        }
        if Engine.sharedInstance.cartCount < 1 {
            cartCountContView.isHidden = true
        }else{
            cartCountContView.isHidden = false
        }

    }
    
    @IBAction func addButton(_ sender: Any) {
        productQuantity = productQuantity + 1
        productCountLbl.text = String(productQuantity)
        
        if productQuantity < 1 {
            subtractBtn.isUserInteractionEnabled = false
            addToCartBtn.isUserInteractionEnabled = false
            addToCartBtn.setTitleColor(.black, for: .normal)
            addToCartBtn.setBackgroundImage(UIImage(named: "GrayButton Icons"), for: .normal)
        }else{
            subtractBtn.isUserInteractionEnabled = true
            addToCartBtn.isUserInteractionEnabled = true
            addToCartBtn.setTitleColor(.white, for: .normal)
            addToCartBtn.setBackgroundImage(UIImage(named: "GreenButton Icons"), for: .normal)
            
        }
    }
    
    @IBAction func subtractButton(_ sender: Any) {
        productQuantity = productQuantity - 1
        productCountLbl.text = String(productQuantity)
        
        if productQuantity < 1 {
            subtractBtn.isUserInteractionEnabled = false
            addToCartBtn.isUserInteractionEnabled = false
            addToCartBtn.setTitleColor(.black, for: .normal)
            addToCartBtn.setBackgroundImage(UIImage(named: "GrayButton Icons"), for: .normal)
        }else{
            subtractBtn.isUserInteractionEnabled = true
            addToCartBtn.isUserInteractionEnabled = true
            addToCartBtn.setTitleColor(.white, for: .normal)
            addToCartBtn.setBackgroundImage(UIImage(named: "GreenButton Icons"), for: .normal)
            
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
    
    func selection(button:UIButton) {
        self.greenBtn.isSelected = false
        self.blueBtn.isSelected = false
        self.blackBtn.isSelected = false
        self.grayBtn.isSelected = false
        
        button.isSelected = true
    }
}
