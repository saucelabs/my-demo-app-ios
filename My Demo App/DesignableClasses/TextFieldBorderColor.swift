//
//  TextFieldBorderColor.swift
//  My Demo App
//
//  Created by Mubashir on 16/09/21.
//

import UIKit

    @IBDesignable
    class TextFieldBorderColor: UITextField {
        @IBInspectable public var placeholderColor: UIColor = .lightGray {
                didSet {
                    let placeholderStr = placeholder ?? ""
                    attributedPlaceholder = NSAttributedString(string: placeholderStr, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
                }
            }

        @IBInspectable var borderColor: UIColor? {
            didSet {
                layer.borderColor = borderColor?.cgColor
            }
        }
        
        @IBInspectable var borderWidth: CGFloat = 0 {
            didSet {
                layer.borderWidth = borderWidth
            }
        }
        @IBInspectable var cornerRadius: CGFloat = 0 {
            didSet {
                layer.cornerRadius = cornerRadius
                layer.masksToBounds = cornerRadius > 0
            }
        }
    }

