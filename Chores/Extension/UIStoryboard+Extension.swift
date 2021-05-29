//
//  UIStoryboard+Extension.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/12.
//

import UIKit

private struct StoryboardCategory {
    
    static let main = "Main"
    
    static let mission = "Mission"
    
    static let group = "Group"
    
    static let profile = "Profile"
    
    static let initial = "Initial"
    
    static let signin = "Signin"
    
}

extension UIStoryboard {
    
    static var main: UIStoryboard { return stStoryboard(name: StoryboardCategory.main) }
    
    static var mission: UIStoryboard { return stStoryboard(name: StoryboardCategory.mission) }
    
    static var group: UIStoryboard { return stStoryboard(name: StoryboardCategory.group) }
    
    static var profile: UIStoryboard { return stStoryboard(name: StoryboardCategory.profile) }
    
    static var initial: UIStoryboard { return stStoryboard(name: StoryboardCategory.initial) }
    
    static var signin: UIStoryboard { return stStoryboard(name: StoryboardCategory.signin) }
    
    private static func stStoryboard(name: String) -> UIStoryboard {
        
        return UIStoryboard(name: name, bundle: nil)
    }

}
