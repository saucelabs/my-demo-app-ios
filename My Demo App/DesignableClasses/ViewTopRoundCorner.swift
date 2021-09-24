//
//  ViewTopRoundCorner.swift
//  My Demo App
//
//  Created by Mubashir on 20/09/21.
//

import UIKit

class ViewTopRoundCorner: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            layer.masksToBounds = false
        }
    }

}
