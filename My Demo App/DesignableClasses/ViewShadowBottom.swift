//
//  ShadowBottom.swift
//  My Demo App
//
//  Created by Mubashir on 15/09/21.
//

import UIKit

class ViewShadowBottom: UIView {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!

        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.5)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 1.0
       
    }
}
