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
    case Icon32px_Mission_Nornal
    case Icon32px_Mission_Selected
    case Icon32px_Group_Normal
    case Icon32px_Group_Selected
    case Icon32px_Profile_Normal
    case Icon32px_Profile_Selected
    
    case Icon32px_AddChores
    case Icon16px_Plus
    case Icon24px_Plus
    case Icon32px_Plus
    case CustomChore
    case user
    
}

// swiftlint:enable identifier_name

extension UIImage {
    
    static func asset(_ asset: ImageAsset) -> UIImage? {
        
        return UIImage(named: asset.rawValue)
    }
}
