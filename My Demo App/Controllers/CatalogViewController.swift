//
//  CatalogViewController.swift
//  My Demo App
//
//  Created by Mubashir on 20/09/21.
//

import UIKit

class CatalogViewController: UIViewController {
    
    @IBOutlet weak var productsCV: UICollectionView!
    
    @IBOutlet var sortPopUpView: UIView!
    @IBOutlet weak var cartCountContView: UIView!
    
    @IBOutlet weak var cartCountLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var nameAscendingBtn: UIButton!
    @IBOutlet weak var nameDescendingBtn: UIButton!
    @IBOutlet weak var priceAscendingBtn: UIButton!
    @IBOutlet weak var priceDecendingButton: UIButton!
    @IBOutlet weak var sortBtn: UIButton!
    
    var mySortedDic = [NSMutableDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.productsCV.dataSource = self
        self.productsCV.delegate = self
        
        if Engine.sharedInstance.cartCount < 1 {
            cartCountContView.isHidden = true
        }
                
        if Engine.sharedInstance.userName == "visual@example.com" {
            self.titleLbl.textAlignment = .center
        }
        
        nameAscendingBtn.isSelected = true
        
        let productDic = Engine.sharedInstance.productList
        Engine.sharedInstance.productList = productDic.sorted(by: {(str1, str2)  -> Bool in
            return ((str1 as NSDictionary).value(forKey: "ProductName") as! String) < ((str2 as NSDictionary).value(forKey: "ProductName") as! String)
          })
        productsCV.reloadData()
        
        guard let collectionView = productsCV, let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        flowLayout.minimumInteritemSpacing = 16
        
        flowLayout.minimumLineSpacing = 5
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 5, right: 16)
        
        cartCountLbl.text = String(Engine.sharedInstance.cartCount)
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        productsCV.collectionViewLayout.invalidateLayout()
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
    
    @IBAction func sortButton(_ sender: Any) {
        let screenSize = UIScreen.main.bounds.size
        
        self.sortPopUpView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        
        self.view.addSubview(sortPopUpView)
    }
    
    @IBAction func nameAscendingButton(_ sender: UIButton) {
        selection(button: sender)
        
        let iconImage:UIImage? = UIImage(named: "SortNameAscending Icons")
        sortBtn.setImage(iconImage, for: UIControl.State.normal)
        
        let productDic = Engine.sharedInstance.productList
        Engine.sharedInstance.productList = productDic.sorted(by: {(str1, str2)  -> Bool in
            return ((str1 as NSDictionary).value(forKey: "ProductName") as! String) < ((str2 as NSDictionary).value(forKey: "ProductName") as! String)
          })
        productsCV.reloadData()
        sortPopUpView.removeFromSuperview()
    }
    
    @IBAction func nameDescendingButton(_ sender: UIButton) {
        selection(button: sender)
        
        let iconImage:UIImage? = UIImage(named: "SortNameDescending Icons")
        sortBtn.setImage(iconImage, for: UIControl.State.normal)
        
        let productDic = Engine.sharedInstance.productList
        Engine.sharedInstance.productList = productDic.sorted(by: {(str1, str2)  -> Bool in
            return ((str1 as NSDictionary).value(forKey: "ProductName") as! String) > ((str2 as NSDictionary).value(forKey: "ProductName") as! String)
          })
        productsCV.reloadData()
        
        sortPopUpView.removeFromSuperview()
    }
    
    @IBAction func priceAscendingButton(_ sender: UIButton) {
        selection(button: sender)
        
        let iconImage:UIImage? = UIImage(named: "SortPriceAscending Icons")
        sortBtn.setImage(iconImage, for: UIControl.State.normal)
        
        let productDic = Engine.sharedInstance.productList
        Engine.sharedInstance.productList = productDic.sorted(by: {(str1, str2)  -> Bool in
            return ((str1 as NSDictionary).value(forKey: "ProductPrice") as! String) < ((str2 as NSDictionary).value(forKey: "ProductPrice") as! String)
          })
        
        productsCV.reloadData()
        
        sortPopUpView.removeFromSuperview()
    }
    
    @IBAction func priceDescendingButton(_ sender: UIButton) {
        selection(button: sender)
        
        let iconImage:UIImage? = UIImage(named: "SortPriceDescending Icons")
        sortBtn.setImage(iconImage, for: UIControl.State.normal)
        
        let productDic = Engine.sharedInstance.productList
        Engine.sharedInstance.productList = productDic.sorted(by: {(str1, str2)  -> Bool in
            return ((str1 as NSDictionary).value(forKey: "ProductPrice") as! String) > ((str2 as NSDictionary).value(forKey: "ProductPrice") as! String)
          })
        productsCV.reloadData()
        
        sortPopUpView.removeFromSuperview()
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
        self.nameAscendingBtn.isSelected = false
        self.nameDescendingBtn.isSelected = false
        self.priceAscendingBtn.isSelected = false
        self.priceDecendingButton.isSelected = false
        
        button.isSelected = true
    }
    
}

extension CatalogViewController: UICollectionViewDataSource, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return Engine.sharedInstance.productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCell", for: indexPath)  as!ProductsCell
        
        let productDataDic = Engine.sharedInstance.productList[indexPath.row]
        var imageName = productDataDic.value(forKey: "ProductImageName") as! String
        let productName = productDataDic.value(forKey: "ProductName") as! String
        
        let productPrice = if Engine.sharedInstance.userName == "visual@example.com" {
            String(format: "%.2f", Double.random(in: 1...99))
        } else {
            productDataDic.value(forKey: "ProductPrice") as! String
        }
        
        if Engine.sharedInstance.userName == "visual@example.com" {
            if imageName == "BagBlack Image" {imageName = "ShirtRedOnesie Image"}
            if imageName == "BagGreen Image" {imageName = "ShirtRedOnesie Image"}
        }
        
        cell.productIV.image = UIImage(named: imageName)
        cell.productNameLbl.text = productName
        cell.productNameLbl.accessibilityLabel = productName
        cell.productPriceLbl.text = "$ " + productPrice

        cell.star1Btn.tag = indexPath.row
        cell.star1Btn.addTarget(self, action: #selector(showAlert(sender:)), for: .touchUpInside)
        cell.star2Btn.tag = indexPath.row
        cell.star2Btn.addTarget(self, action: #selector(showAlert(sender:)), for: .touchUpInside)
        cell.star3Btn.tag = indexPath.row
        cell.star3Btn.addTarget(self, action: #selector(showAlert(sender:)), for: .touchUpInside)
        cell.star4Btn.tag = indexPath.row
        cell.star4Btn.addTarget(self, action: #selector(showAlert(sender:)), for: .touchUpInside)
        cell.star5Btn.tag = indexPath.row
        cell.star5Btn.addTarget(self, action: #selector(showAlert(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let productDataDic = Engine.sharedInstance.productList[indexPath.row]
        
        let imageName = productDataDic.value(forKey: "ProductImageName") as! String
        let productName = productDataDic.value(forKey: "ProductName") as! String
        let productPrice = productDataDic.value(forKey: "ProductPrice") as! String
        let productHighlights = productDataDic.value(forKey: "ProductHighlights") as! String
        let productId = productDataDic.value(forKey: "Id") as! String
        
        let storyboard = UIStoryboard.init(name: "TabBar", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductPageDetailViewController") as! ProductPageDetailViewController
        
        vc.productImageName = imageName
        vc.productName = productName
        vc.productPrice = productPrice
        vc.productHighlights = productHighlights
        vc.productId = productId
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = self.view.bounds.width > self.view.bounds.height ? 3 : 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size + 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionFooter) {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)
            // Customize footerView here
            return footerView
        } else if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
            // Customize headerView here
            return headerView
        }
        fatalError()
    }
    
    @objc func showAlert(sender:UIButton!)
    {
        let alert = UIAlertController(title: "", message: "Thank you for submitting your review!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

class ProductsCell: UICollectionViewCell {

    @IBOutlet weak var productIV: UIImageView!
    
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    
    @IBOutlet weak var star1Btn: UIButton!
    @IBOutlet weak var star2Btn: UIButton!
    @IBOutlet weak var star3Btn: UIButton!
    @IBOutlet weak var star4Btn: UIButton!
    @IBOutlet weak var star5Btn: UIButton!
}
