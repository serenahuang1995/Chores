//
//  UIButton + Extension.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/6/17.
//

import UIKit

@IBDesignable
extension UIButton {
    
    // Border Color
    @IBInspectable var buttonBorderColor: UIColor? {
        
        get {

            guard let borderColor = layer.borderColor else {
                
                return nil
            }
            
            return UIColor(cgColor: borderColor)
        }
        set {
            
            layer.borderColor = newValue?.cgColor
        }
    }
    
    // Border Width
    @IBInspectable var buttonBorderWidth: CGFloat {
        
        get {
            
            return layer.borderWidth
        }
        set {
            
            layer.borderWidth = newValue
        }
    }
    
    // Corner Radius
    @IBInspectable var buttonCornerRadius: CGFloat {
        
        get {
            
            return layer.cornerRadius
        }
        set {
            
            layer.cornerRadius = newValue
        }
    }
}
