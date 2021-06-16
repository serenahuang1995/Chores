//
//  TabBarViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/12.
//

import UIKit

private enum Tab {
    
    case mission
    
    case group
    
    case profile
    
    func controller() -> UIViewController {
        
        var controller: UIViewController
        
        switch self {
        
        case .mission: controller = UIStoryboard.mission.instantiateInitialViewController()!
            
        case .group: controller = UIStoryboard.group.instantiateInitialViewController()!
            
        case .profile: controller = UIStoryboard.profile.instantiateInitialViewController()!
            
        }
        
        controller.tabBarItem = tabBarItem()
        
        controller.tabBarItem.imageInsets = UIEdgeInsets(top: 6.0, left: 0.0, bottom: -6.0, right: 0.0)
        
        return controller
    }
    
    func tabBarItem() -> UITabBarItem {
        
        switch self {
        
        case .mission:
            return UITabBarItem(
                title: nil,
                image: UIImage.asset(.Icon32px_Mission_Nornal),
                selectedImage: UIImage.asset(.Icon32px_Mission_Selected)
            )
            
        case .group:
            return UITabBarItem(
                title: nil,
                image: UIImage.asset(.Icon32px_Group_Normal),
                selectedImage: UIImage.asset(.Icon32px_Group_Selected)
            )
            
        case .profile:
            return UITabBarItem(
                title: nil,
                image: UIImage.asset(.Icon32px_Profile_Normal),
                selectedImage: UIImage.asset(.Icon32px_Profile_Selected)
            )
        }
    }
}

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    private let tabs: [Tab] = [.mission, .group, .profile]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = tabs.map({ $0.controller() })
        
        delegate = self
    }
}
