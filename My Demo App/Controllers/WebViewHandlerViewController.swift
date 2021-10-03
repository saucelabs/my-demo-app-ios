//
//  WebViewHandlerViewController.swift
//  My Demo App
//
//  Created by Mubashir on 27/09/21.
//

import UIKit
import WebKit

class WebViewHandlerViewController: UIViewController {

    @IBOutlet var lodingIndicatorView: UIView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadingView: UIView!
    
    
    var urlString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURLString = urlString
        let url = URL(string: myURLString)
        let request = URLRequest(url: url!)
        webView.navigationDelegate = self
        webView.load(request)
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
extension WebViewHandlerViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        loadingView.rotate()
        let screenSize = UIScreen.main.bounds.size
        
        self.lodingIndicatorView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        
        self.view.addSubview(lodingIndicatorView)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        lodingIndicatorView.removeFromSuperview()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        lodingIndicatorView.removeFromSuperview()
    }
}

extension UIView{
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 0.7
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}
