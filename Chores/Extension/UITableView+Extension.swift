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
  
  func getIndexPath() -> IndexPath? {

    guard let tableView = superview as? UITableView else { return nil }

    let indexPath = tableView.indexPath(for: self)

    return indexPath
    
  }
  
}

extension UITableViewHeaderFooterView {

  static var identifier: String {

    return String(describing: self)
  }
}
