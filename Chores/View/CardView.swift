//
//  CardView.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/12.
//

import UIKit

@IBDesignable class CardView: UIView {

  @IBInspectable var cornerRadius: CGFloat = 10

  @IBInspectable var shadowOffsetWidth: CGFloat = 3
  @IBInspectable var shadowOffsetHeight: CGFloat = 3

  @IBInspectable var shadowColor: UIColor = UIColor.blue7990CA
  @IBInspectable var shadowOpacity: CGFloat = 0.5
  @IBInspectable var shadowRadius: CGFloat = 10

  @IBInspectable var borderWidth: CGFloat = 1
  @IBInspectable var borderColor: UIColor = UIColor.clear

  override func layoutSubviews() {

    // Corner..............
    layer.cornerRadius = cornerRadius

    // Shadow...........
    layer.shadowColor = shadowColor.cgColor
    layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
    let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
    layer.shadowPath = shadowPath.cgPath
    layer.shadowOpacity = Float(shadowOpacity)
    layer.masksToBounds = false

    // Border.............
    layer.borderWidth = borderWidth
    layer.borderColor = borderColor.cgColor
  }

//  func borderStyle(width: CGFloat, height: CGFloat, space: CGFloat, cornerRadius: CGFloat, color: UIColor) {
//    let borderLayer = CAShapeLayer()
////    borderLayer.bounds = self.bounds
//    borderLayer.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
//    borderLayer.path = UIBezierPath(roundedRect: borderLayer.bounds, cornerRadius: cornerRadius).cgPath
////    borderLayer.lineWidth = width / UIScreen.main.scale
//    borderLayer.lineDashPattern = [10, 10] as [NSNumber]
////     前邊是虛線的長度，后邊是虛線之間空隙的長度
//    borderLayer.lineDashPhase = 1
//    borderLayer.fillColor = nil
//    borderLayer.strokeColor = color.cgColor
//    self.layer.addSublayer(borderLayer)
//  }
//  
////  func setUpDottedLine(strokeColor: UIColor) {
////    let borderLayer = CAShapeLayer()
////    borderLayer.strokeColor = strokeColor.cgColor
////    borderLayer.lineWidth = 1
////    let path = CGMutablePath()
////    borderLayer.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
////
////  }
}
