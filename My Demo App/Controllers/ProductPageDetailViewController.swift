//
//  ProductPageDetailViewController.swift
//  My Demo App
//
//  Created by Mubashir on 20/09/21.
//

import UIKit

class ProductPageDetailViewController: UIViewController {
    @IBOutlet weak var redBtn: UIButton!
    @IBOutlet weak var blueBtn: UIButton!
    @IBOutlet weak var blackBtn: UIButton!
    @IBOutlet weak var grayBtn: UIButton!
    @IBOutlet weak var subtractBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var addToCartBtn: ButtonRoundCorner!
    
    @IBOutlet weak var cartCountContView: UIView!
    
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
    var selectedColor = "Red"

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
        
        
        if productName == "Sauce Lab Bike Light" || productName == "Sauce Lab Onesie" {
            blueBtn.isHidden = true
            redBtn.isSelected = true
            selectedColor = "Red"
        }else if productName == "Sauce Lab Bolt T-Shirt" || productName == "Test.sllTheThings() T-Shirt" {
            blueBtn.isHidden = true
            grayBtn.isHidden = true
            redBtn.isHidden = true
            blackBtn.isSelected = true
            selectedColor = "Black"
        }else if productName == "Sauce Lab Fleece T-Shirt" {
            blueBtn.isHidden = true
            blackBtn.isHidden = true
            redBtn.isHidden = true
            grayBtn.isSelected = true
            selectedColor = "Gray"
        }else if productName == "Sauce Lab Back Packs" {
            redBtn.isSelected = true
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "TabBar", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CatalogViewController") as! CatalogViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func redButton(_ sender: UIButton) {
        selection(button: sender)
        selectedColor = "Red"
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
                                                      "ProductHighlights":productHighlights,"ProductColor":selectedColor,"ProductQuantity":productQuantity])
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
            addToCartBtn.setBackgroundImage(UIImage(named: "RedButton Icons"), for: .normal)
            
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
            addToCartBtn.setBackgroundImage(UIImage(named: "RedButton Icons"), for: .normal)
            
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
        self.redBtn.isSelected = false
        self.blueBtn.isSelected = false
        self.blackBtn.isSelected = false
        self.grayBtn.isSelected = false
        
        button.isSelected = true
    }
}
