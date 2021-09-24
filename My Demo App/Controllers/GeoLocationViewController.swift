//
//  GeoLocationViewController.swift
//  My Demo App
//
//  Created by Mubashir on 17/09/21.
//

import UIKit
import CoreLocation
import SafariServices

class GeoLocationViewController: UIViewController, CLLocationManagerDelegate,SFSafariViewControllerDelegate {
    
    @IBOutlet weak var cartCountContView: UIView!
    
    @IBOutlet weak var cartCountLbl: UILabel!
    
    @IBOutlet weak var longitudeLbl: UILabel!
    @IBOutlet weak var latitudeLbl: UILabel!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartCountLbl.text = String(Engine.sharedInstance.cartCount)
        if Engine.sharedInstance.cartCount < 1 {
            cartCountContView.isHidden = true
        }
        
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        latitudeLbl.text = String(location.latitude)
        longitudeLbl.text = String(location.longitude)
        
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
    
    @IBAction func appiumButton(_ sender: Any) {
        let url = URL(string: "http://appium.io/docs/en/commands/session/geolocation/set-geolocation/")!
        let controller = SFSafariViewController(url: url)
        self.present(controller, animated: true, completion: nil)
        controller.delegate = self
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
