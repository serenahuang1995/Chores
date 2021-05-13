//
//  UIStoryboard+Extension.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/12.
//

import UIKit

private struct StoryboardCategory {

  static let main = "Main"

  static let choreList = "ChoreList"

  static let group = "Group"

  static let profile = "Profile"

  static let auth = "Auth"
}

extension UIStoryboard {

  static var main: UIStoryboard { return stStoryboard(name: StoryboardCategory.main) }

  static var choreList: UIStoryboard { return stStoryboard(name: StoryboardCategory.choreList) }

  static var group: UIStoryboard { return stStoryboard(name: StoryboardCategory.group) }

  static var profile: UIStoryboard { return stStoryboard(name: StoryboardCategory.profile) }

  static var auth: UIStoryboard { return stStoryboard(name: StoryboardCategory.auth) }

  private static func stStoryboard(name: String) -> UIStoryboard {

    return UIStoryboard(name: name, bundle: nil)
  }
}
