//
//  UIView+Extension.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/12.
//

import UIKit

@IBDesignable
extension UIView {
    
    // Border Color
    @IBInspectable var objectBorderColor: UIColor? {
        
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
    @IBInspectable var objectBorderWidth: CGFloat {
        
        get {
            
            return layer.borderWidth
        }
        set {
            
            layer.borderWidth = newValue
        }
    }
    
    // Corner Radius
    @IBInspectable var objectCornerRadius: CGFloat {
        
        get {
            
            return layer.cornerRadius
        }
        set {
            
            layer.cornerRadius = newValue
        }
    }
    
}
