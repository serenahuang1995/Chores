//
//  TabBarViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/12.
//

import UIKit

private enum Tab {

    case choreList

    case group

    case profile

    func controller() -> UIViewController {

        var controller: UIViewController

        switch self {

        case .choreList: controller = UIStoryboard.choreList.instantiateInitialViewController()!

        case .group: controller = UIStoryboard.group.instantiateInitialViewController()!

        case .profile: controller = UIStoryboard.profile.instantiateInitialViewController()!

        }

        controller.tabBarItem = tabBarItem()

        controller.tabBarItem.imageInsets = UIEdgeInsets(top: 6.0, left: 0.0, bottom: -6.0, right: 0.0)

        return controller
    }

    func tabBarItem() -> UITabBarItem {

        switch self {

        case .choreList:
            return UITabBarItem(
                title: nil,
                image: UIImage.asset(.cleaner),
                selectedImage: UIImage.asset(.cleaner)
            )

        case .group:
            return UITabBarItem(
                title: nil,
                image: UIImage.asset(.cleaner),
                selectedImage: UIImage.asset(.cleaner)
            )

        case .profile:
            return UITabBarItem(
                title: nil,
                image: UIImage.asset(.cleaner),
                selectedImage: UIImage.asset(.cleaner)
            )
        }
    }
}

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    private let tabs: [Tab] = [.choreList, .group, .profile]
//    var trolleyTabBarItem: UITabBarItem!
//    var orderObserver: NSKeyValueObservation!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = tabs.map({ $0.controller() })

//        trolleyTabBarItem = viewControllers?[2].tabBarItem
//
//        trolleyTabBarItem.badgeColor = .brown
//
//        orderObserver = StorageManager.shared.observe(
//            \StorageManager.orders,
//            options: .new,
//            changeHandler: { [weak self] _, change in
//
//                guard let newValue = change.newValue else { return }
//
//                if newValue.count > 0 {
//
//                    self?.trolleyTabBarItem.badgeValue = String(newValue.count)
//
//                } else {
//
//                    self?.trolleyTabBarItem.badgeValue = nil
//                }
//            }
//        )
//
//        StorageManager.shared.fetchOrders()
        delegate = self
    }

    // MARK: - UITabBarControllerDelegate

//    func tabBarController(
//        _ tabBarController: UITabBarController,
//        shouldSelect viewController: UIViewController
//    ) -> Bool {
//
//        guard let navVC = viewController as? UINavigationController,
//              navVC.viewControllers.first is ProfileViewController
//        else { return true }
//
//        guard KeyChainManager.shared.token != nil else {
//
//            if let authVC = UIStoryboard.auth.instantiateInitialViewController() {
//
//                authVC.modalPresentationStyle = .overCurrentContext
//
//                present(authVC, animated: false, completion: nil)
//            }
//
//            return false
//        }
//
//        return true
//    }
}
