//
//  CardView.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/12.
//

import UIKit

@IBDesignable
class CardView: UIView {

  @IBInspectable var cornerRadius: CGFloat = 10

//  @IBInspectable var shadowOffsetWidth: CGFloat = 3
//  @IBInspectable var shadowOffsetHeight: CGFloat = 3

  // 控制陰影
//  @IBInspectable var shadowColor: UIColor = UIColor.gray
//  @IBInspectable var shadowOpacity: CGFloat = 0.5
  @IBInspectable var shadowRadius: CGFloat = 10

  @IBInspectable var borderWidth: CGFloat = 1
  @IBInspectable var borderColor: UIColor = UIColor.clear

  override func layoutSubviews() {

    // Corner..............
    layer.cornerRadius = cornerRadius

    // Shadow...........
//    layer.shadowColor = shadowColor.cgColor
//    layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
    let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
    layer.shadowPath = shadowPath.cgPath
    // 控制陰影
//    layer.shadowOpacity = Float(shadowOpacity)
    layer.masksToBounds = false

    // Border.............
    layer.borderWidth = borderWidth
    layer.borderColor = borderColor.cgColor
  }

}
