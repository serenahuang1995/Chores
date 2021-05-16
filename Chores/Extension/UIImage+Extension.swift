//
//  UIImage+Extension.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/12.
//

import UIKit

// swiftlint:disable identifier_name

enum ImageAsset: String {
  
  // Tab Bar Item
  case Icon40px_ChoresList_Selected
  case Icon40px_ChoresList_Normal
  case Icon40px_Group_Normal
  case Icon40px_Group_Selected
  case Icon40px_Profile_Normal
  case Icon40px_Profile_Selected
  
  case cleaner
}

// swiftlint:enable identifier_name

extension UIImage {
  
  static func asset(_ asset: ImageAsset) -> UIImage? {
    
    return UIImage(named: asset.rawValue)
  }
}
