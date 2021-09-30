//
//  MyCartViewController.swift
//  My Demo App
//
//  Created by Mubashir on 19/09/21.
//

import UIKit

class MyCartViewController: UIViewController {
    
    @IBOutlet weak var tvContView: UIView!
    @IBOutlet weak var emptyCardContView: UIView!
    @IBOutlet weak var cartCountContView: UIView!
    @IBOutlet weak var proceedToCheckoutContView: UIView!
    @IBOutlet weak var shadowContView: ViewShadowTop!
    
    @IBOutlet weak var cartCountLbl: UILabel!
    @IBOutlet weak var totalItemLbl: UILabel!
    @IBOutlet weak var totalPriceLbl: UILabel!
    
    @IBOutlet weak var productTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productTV.delegate = self
        productTV.dataSource = self
        
        cartCountLbl.text = String(Engine.sharedInstance.cartCount)
        if Engine.sharedInstance.cartCount < 1 {
            cartCountContView.isHidden = true
        }
        
        if Engine.sharedInstance.cartList.count == 0 {
            tvContView.isHidden = true
            shadowContView.isHidden = true
            proceedToCheckoutContView.isHidden = true
        }
        
        calculateTotalPrice ()
        
        totalItemLbl.text = String(Engine.sharedInstance.cartCount) + " Items"
       
    }
    
    @IBAction func goToShoppingButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "TabBar", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CatalogViewController") as! CatalogViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func twitterButton(_ sender: Any) {
        print("twitter pressed")
    }
    
    @IBAction func facebookButton(_ sender: Any) {
        print("facebook pressed")
    }
    
    @IBAction func linkedInButton(_ sender: Any) {
        print("linkedin pressed")
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
    
    @IBAction func preccedToCheckoutButton(_ sender: Any) {
        if Engine.sharedInstance.isLogin{
            let storyboard = UIStoryboard.init(name: "TabBar", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ShippingAddressViewController") as! ShippingAddressViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let storyboard = UIStoryboard.init(name: "Authentication", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            vc.isFromProcessCheckout = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

extension MyCartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Engine.sharedInstance.cartList.count == 0 {
            tvContView.isHidden = true
            shadowContView.isHidden = true
            proceedToCheckoutContView.isHidden = true
        }
        if Engine.sharedInstance.cartCount < 1 {
            cartCountContView.isHidden = true
        }
        
        return Engine.sharedInstance.cartList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        let productDataDic = Engine.sharedInstance.cartList[indexPath.row]
        let imageName = productDataDic.value(forKey: "ProductImageName") as! String
        let productName = productDataDic.value(forKey: "ProductName") as! String
        let productPrice = productDataDic.value(forKey: "ProductPrice") as! String
        let productColor = productDataDic.value(forKey: "ProductColor") as! String
        let productQuantity = productDataDic.value(forKey: "ProductQuantity") as? Int
        
        if productQuantity! < 1 {
            cell.subtractButton.isUserInteractionEnabled = false
        }
        
        cell.productIV.image = UIImage(named: imageName)
        cell.productNameLbl.text = productName
        cell.productPriceLbl.text = "$ " + productPrice
        cell.productColorLbl.text = productColor
        cell.productCountLbl.text = "\(productQuantity ?? 0)"
        
        cell.removeButton.tag = indexPath.row
        cell.removeButton.addTarget(self, action: #selector(deleteProduct(_:)), for: .touchUpInside)
        
        cell.addButton.tag = indexPath.row
        cell.addButton.addTarget(self, action: #selector(addButton(_:)), for: .touchUpInside)
        
        cell.subtractButton.tag = indexPath.row
        cell.subtractButton.addTarget(self, action: #selector(subtractButton(_:)), for: .touchUpInside)
        
        
        return cell
        
    }
    
    @objc func deleteProduct(_ sender: UIButton) {
        let productFound = Engine.sharedInstance.cartList[sender.tag]
        let quantity =  productFound.value(forKey: "ProductQuantity") as! Int
        Engine.sharedInstance.cartCount -= quantity
        totalItemLbl.text = String(Engine.sharedInstance.cartCount) + " Items"
        cartCountLbl.text = String(Engine.sharedInstance.cartCount)
        Engine.sharedInstance.cartList.remove(at: sender.tag)
        calculateTotalPrice ()
        self.productTV.reloadData()
    }
    
    @objc func addButton(_ sender: UIButton) {
        let productFound = Engine.sharedInstance.cartList[sender.tag]
        let quantity =  productFound.value(forKey: "ProductQuantity") as! Int + 1
        productFound.setValue(quantity, forKey: "ProductQuantity")
        Engine.sharedInstance.cartCount += 1
        totalItemLbl.text = String(Engine.sharedInstance.cartCount) + " Items"
        cartCountLbl.text = String(Engine.sharedInstance.cartCount)
        calculateTotalPrice ()
        self.productTV.reloadData()
    }
    
    @objc func subtractButton(_ sender: UIButton) {
        let productFound = Engine.sharedInstance.cartList[sender.tag]
        let quantity =  productFound.value(forKey: "ProductQuantity") as! Int - 1
        
        if quantity < 1 {
            Engine.sharedInstance.cartList.remove(at: sender.tag)
        }
        
        productFound.setValue(quantity, forKey: "ProductQuantity")
        Engine.sharedInstance.cartCount -= 1
        totalItemLbl.text = String(Engine.sharedInstance.cartCount) + " Items"
        cartCountLbl.text = String(Engine.sharedInstance.cartCount)
        calculateTotalPrice ()
        self.productTV.reloadData()
    }
    
    func calculateTotalPrice () {
        Engine.sharedInstance.totalPrice = 0.0
        for price in 0..<Engine.sharedInstance.cartList.count {
            let productFound = Engine.sharedInstance.cartList[price]
            let productQuantity =  productFound.value(forKey: "ProductQuantity") as! Int
            let productPrice = productFound.value(forKey: "ProductPrice") as! String
            let totalPrice = Double(productPrice)! * Double(productQuantity)
            Engine.sharedInstance.totalPrice += totalPrice
        }
        totalPriceLbl.text = "$" + String(format: "%.2f", Engine.sharedInstance.totalPrice)
    }
}

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var productIV: UIImageView!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var productColorLbl: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var subtractButton: UIButton!
    @IBOutlet weak var productCountLbl: UILabel!
    @IBOutlet weak var star1Btn: UIButton!
    @IBOutlet weak var star2Btn: UIButton!
    @IBOutlet weak var star3Btn: UIButton!
    @IBOutlet weak var star4Btn: UIButton!
    @IBOutlet weak var star5Btn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        star1Btn.isSelected = true
        star2Btn.isSelected = true
        star3Btn.isSelected = true
        star4Btn.isSelected = true
    }
    
}
