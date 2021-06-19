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
    
    static var main: UIStoryboard { return storyboard(name: StoryboardCategory.main) }
    
    static var mission: UIStoryboard { return storyboard(name: StoryboardCategory.mission) }
    
    static var group: UIStoryboard { return storyboard(name: StoryboardCategory.group) }
    
    static var profile: UIStoryboard { return storyboard(name: StoryboardCategory.profile) }
    
    static var initial: UIStoryboard { return storyboard(name: StoryboardCategory.initial) }
    
    static var signin: UIStoryboard { return storyboard(name: StoryboardCategory.signin) }
    
    private static func storyboard(name: String) -> UIStoryboard {
        
        return UIStoryboard(name: name, bundle: nil)
    }
}
