//
//  BTViewController.swift
//  My Demo App
//
//  Created by Melek R on 2025-03-21.
//

import UIKit

class ErrorReportingViewController: UIViewController {

    
    var urlString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
