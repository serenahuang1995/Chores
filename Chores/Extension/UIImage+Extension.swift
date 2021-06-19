//
//  UIImage+Extension.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/12.
//

import UIKit

// swiftlint:disable identifier_name

enum ImageAsset: String {
    
    // tab bar
    case Icon32px_Mission_Nornal
    case Icon32px_Mission_Selected
    case Icon32px_Group_Normal
    case Icon32px_Group_Selected
    case Icon32px_Profile_Normal
    case Icon32px_Profile_Selected
    
    // chore item image
    case WashDishes
    case WashClothes
    case DryClothes
    case FoldClothes
    case IronClothes
    case ThrowTrash
    case CleanBathroom
    case CleanWindow
    case Repair
    case WaterFlower
    case WalkDog
    case Storage
    case PickUp
    case TakeCareKid
    case Cook
    case Grocery
    case BroomFloor
    case MopFloor
    case VacuumCleaner
    case CustomChore
    
    case Icon32px_AddChores
    case Icon16px_Plus
    case Icon24px_Plus
    case Icon32px_Plus
//    case CustomChore
    case user
    
}

// swiftlint:enable identifier_name

extension UIImage {
    
    static func asset(_ asset: ImageAsset) -> UIImage? {
        
        return UIImage(named: asset.rawValue)
    }
}
