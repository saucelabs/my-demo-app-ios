//
//  ViewShadowTop.swift
//  My Demo App
//
//  Created by Mubashir on 16/09/21.
//

import UIKit

class ViewShadowTop: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            layer.masksToBounds = false
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        let shadowSize : CGFloat = 5.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.frame.size.width + shadowSize,
                                                   height: self.frame.size.height + shadowSize))
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.32
        self.layer.shadowPath = shadowPath.cgPath
        
    }
}
