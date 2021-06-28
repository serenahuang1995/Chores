//
//  CardView.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/12.
//

import UIKit

@IBDesignable
class CardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 15
    
    @IBInspectable var borderWidth: CGFloat = 1
    
    @IBInspectable var borderColor: UIColor = UIColor.clear

    override func layoutSubviews() {
        
        // Corner..............
        layer.cornerRadius = cornerRadius
        
        // Shadow...........
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.shadowPath = shadowPath.cgPath

        layer.masksToBounds = false
        
        // Border.............
        layer.borderWidth = borderWidth
        
        layer.borderColor = borderColor.cgColor
    }
}
