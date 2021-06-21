//
//  NotificationDelegate.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/6/13.
//

import Foundation
import UIKit
import UserNotifications

@available(iOS 14.0, *)
class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        // Play sound and show alert to the user
        completionHandler([.list,.banner, .sound, .badge])
    }
}
