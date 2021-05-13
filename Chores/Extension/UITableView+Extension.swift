//
//  UITableView+Extension.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/13.
//

import UIKit

extension UITableView {

  func registerCellWithNib(identifier: String, bundle: Bundle?) {

    let nib = UINib(nibName: identifier, bundle: bundle)
  
    register(nib, forCellReuseIdentifier: identifier)
  }

  func registerHeaderWithNib(identifier: String, bundle: Bundle?) {

    let nib = UINib(nibName: identifier, bundle: bundle)

    register(nib, forHeaderFooterViewReuseIdentifier: identifier)
  }
}

extension UITableViewCell {

  static var identifier: String {

    return String(describing: self)
  }
}

extension UITableViewHeaderFooterView {

  static var identifier: String {

    return String(describing: self)
  }
}
