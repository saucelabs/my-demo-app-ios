//
//  ShadowAllSide.swift
//  My Demo App
//
//  Created by Mubashir on 15/09/21.
//

import UIKit

class ViewShadowAllSide: UIView {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    // Shadow and Radius
    self.layer.shadowColor = UIColor.lightGray.cgColor
    self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
    self.layer.shadowOpacity = 0.7
    self.layer.shadowRadius = 5
    self.layer.masksToBounds = false
    }
}
