//
//  UserNotifications.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/6/18.
//

import UIKit
import UserNotifications

enum NotificationIdentifier: String {
    
    case morning = "Morning"
    
    case night = "Night"
}

class NotificationUtils {
    
    func setChoresReminder() {
        
        setUpNotfication(identifier: .morning)
        
        setUpNotfication(identifier: .night)
    }
    
    func getNotificationContent(title: String, body: String) -> UNMutableNotificationContent {

        let content = UNMutableNotificationContent()
        
        content.title = title
        
        content.body = body
        
        content.sound = .default
        
        return content
    }
    
    func getTriggerDaily(hour: Int, minute: Int, second: Int) -> UNCalendarNotificationTrigger {

        let triggerDaily = DateComponents(calendar: Calendar.current,hour: hour, minute: minute, second: second)

        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: false)

        return trigger
    }
    
    func setUpNotfication(identifier: NotificationIdentifier) {
        
        var content: UNMutableNotificationContent
        
        var trigger: UNCalendarNotificationTrigger
        
        switch identifier {
        
        case .morning:
            
            content = getNotificationContent(title: "早安", body: "今天也要努力的做家事唷❤️")
            
            trigger = getTriggerDaily(hour: 9, minute: 0, second: 0)
            
        case .night:
            
            content = getNotificationContent(title: "晚安", body: "辛苦一整天了，家事都做完了嗎💪🏻")
            
            trigger = getTriggerDaily(hour: 21, minute: 45, second: 0)
        }
        
        
        let request = UNNotificationRequest(identifier: identifier.rawValue, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in

            if let error = error {

                print(error)
                
            } else {

                print("Success")
            }
        }
    }
}
