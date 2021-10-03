//
//  ReviewYourOrderViewController.swift
//  My Demo App
//
//  Created by Mubashir on 17/09/21.
//

import UIKit

class ReviewYourOrderViewController: UIViewController {
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var reviewYourOrderTV: UITableView!
    
    @IBOutlet weak var cartCountContView: UIView!
    
    @IBOutlet weak var fullnameBillingLbl: UILabel!
    @IBOutlet weak var addressBillingLbl: UILabel!
    @IBOutlet weak var cityStateBillingLbl: UILabel!
    @IBOutlet weak var zipCountryBillingLbl: UILabel!
    @IBOutlet weak var cartCountLbl: UILabel!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var deliveryAddressLbl: UILabel!
    @IBOutlet weak var cityStateRegionLbl: UILabel!
    @IBOutlet weak var countryZipCodeLbl: UILabel!
    @IBOutlet weak var fullNameCardLbl: UILabel!
    @IBOutlet weak var cardNumberLbl: UILabel!
    @IBOutlet weak var expirationDateLbl: UILabel!
    @IBOutlet weak var billingAddressLbl: UILabel!
    @IBOutlet weak var estimateToArriveLbl: UILabel!
    
    @IBOutlet weak var dhlStandardDeliveryPriceLbl: UILabel!
    @IBOutlet weak var totalItemLbl: UILabel!
    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var billingAddressHeadingLbl: UILabel!
    
    var isBillingSame = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewYourOrderTV.delegate = self
        reviewYourOrderTV.dataSource = self
        
        cartCountLbl.text = String(Engine.sharedInstance.cartCount)
        
        if Engine.sharedInstance.cartCount < 1 {
            cartCountContView.isHidden = true
        }
        
        let noOfImages = Engine.sharedInstance.cartList.count
        let calculatedSize = noOfImages * 195
        
        if isBillingSame{
            mainViewHeight.constant = CGFloat(700 + calculatedSize)
            
            fullnameBillingLbl.textColor = .white
            addressBillingLbl.textColor = .white
            cityStateBillingLbl.textColor = .white
            zipCountryBillingLbl.textColor = .white
            billingAddressHeadingLbl.textColor = .white
            
        }else{
            mainViewHeight.constant = CGFloat(750 + calculatedSize)
            billingAddressLbl.isHidden = true
        }
        setOrderDetail()
    }
    
    func setOrderDetail() {
        fullNameLbl.text = Engine.sharedInstance.fullName
        deliveryAddressLbl.text = Engine.sharedInstance.addressLine1
        cityStateRegionLbl.text = Engine.sharedInstance.city + "," + Engine.sharedInstance.stateRegion
        countryZipCodeLbl.text = Engine.sharedInstance.country + "," + Engine.sharedInstance.zipCode
        
        fullNameCardLbl.text = Engine.sharedInstance.fullNameCard
        cardNumberLbl.text = Engine.sharedInstance.cardNumber
        expirationDateLbl.text = Engine.sharedInstance.expirationDate
        
        fullnameBillingLbl.text = Engine.sharedInstance.fullNameBilling
        addressBillingLbl.text = Engine.sharedInstance.addressLine1Billing + "," + Engine.sharedInstance.addressLine2Billing
        cityStateBillingLbl.text = Engine.sharedInstance.cityBilling + "," + Engine.sharedInstance.countryBilling
        zipCountryBillingLbl.text = Engine.sharedInstance.zipCodeBilling + "," + Engine.sharedInstance.countryBilling
        totalItemLbl.text = String(Engine.sharedInstance.cartCount) + "item"
        totalPriceLbl.text = "$" + String(format: "%.2f", Engine.sharedInstance.totalPrice + 5.99)
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func twitterButton(_ sender: Any) {
        
    }
    
    @IBAction func facebookButton(_ sender: Any) {
        
    }
    
    @IBAction func linkedInButton(_ sender: Any) {
        
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
    
    @IBAction func placeOrderButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "TabBar", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CheckoutCompleteViewController") as! CheckoutCompleteViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ReviewYourOrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Engine.sharedInstance.cartList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewYourOrderCell", for: indexPath) as! ReviewYourOrderCell
        
        let productDataDic = Engine.sharedInstance.cartList[indexPath.row]
        let imageName = productDataDic.value(forKey: "ProductImageName") as! String
        let productName = productDataDic.value(forKey: "ProductName") as! String
        let productPrice = productDataDic.value(forKey: "ProductPrice") as! String
        let productColor = productDataDic.value(forKey: "ProductColor") as! String
    
        cell.productIV.image = UIImage(named: imageName)
        cell.productNameLbl.text = productName
        cell.productPriceLbl.text = "$ " + productPrice
        cell.productColorLbl.text = productColor
        
        return cell
        
    }
    
    }

class ReviewYourOrderCell: UITableViewCell {
    
    @IBOutlet weak var productIV: UIImageView!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var productColorLbl: UILabel!
    
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
