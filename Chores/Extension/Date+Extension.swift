//
//  Date+Extension.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/6/6.
//

import UIKit

extension Date {
    
    static let secondsOfDay = 86400
    
    func currentWeekDay() -> String {
        
        let date = self
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "EEEE"
        
        let weekDay = dateFormatter.string(from: date)
        
        return weekDay
    }
    
    // 當前月份開始日期
    func startOfCurrentMonth() -> Date {
        
        let date = self
        
        let calendar = Calendar.current
        
        let components = calendar.dateComponents(
            Set<Calendar.Component>([.year, .month]),
            from: date)
        
        let startOfMonth = calendar.date(from: components)!
        
        return startOfMonth
    }
    
    // 當前月份結束日期
    func endOfCurrentMonth(returnDetailTime: Bool = false) -> Date {
        
        let calendar = Calendar.current
        
        var components = DateComponents()
        
        components.month = 1
        
        if returnDetailTime {
            
            components.second = -1
            
        } else {
            
            components.day = -1
        }
         
        let endOfMonth =  calendar.date(byAdding: components, to: startOfCurrentMonth())!
        
        return endOfMonth
    }
    
    // 計算當天為本週的第幾天
    func getFirstDayDateInWeek() -> Date? {
        
        let todayDate = self
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy年MM月dd日 HH時mm分ss秒"
        
        // 計算本週第n天
        let day = Calendar.current.ordinality(of: .day, in: .weekOfMonth, for: todayDate)
        print("本週第\(day!)天")
        
        let firstDay = todayDate - Double(((day ?? 1) - 1) * Date.secondsOfDay)
        
        print("第一天\(firstDay) , ？？？日期 \(dateFormatter.string(from: firstDay))")

        let newDateFormatter = DateFormatter()
        
        newDateFormatter.dateFormat = "yyyy年MM月dd日"
        
        let firstDayValue = newDateFormatter.string(from: firstDay)
        
        print("firstDayValue：\(firstDayValue)")
        
        let firstDate = newDateFormatter.date(from: firstDayValue)
        
        print("firstDate：\(firstDate)")

        return firstDate
    }
    
    func getLastDayDateInWeek() -> Date? {
        
        let todayDate = self
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy年MM月dd日 HH時mm分ss秒"
        
        // 計算本週第n天
        let day = Calendar.current.ordinality(of: .day, in: .weekOfMonth, for: todayDate)
        print("本週第\(day!)天")
        
        let lastDay = todayDate + Double((7 - (day ?? 1)) * Date.secondsOfDay)
        
        print("最後一天\(lastDay), 日期 \(dateFormatter.string(from: lastDay))")

        let newDateFormatter = DateFormatter()
        
        newDateFormatter.dateFormat = "yyyy年MM月dd日"
        
        let lastDayValue = newDateFormatter.string(from: lastDay)
        
        print("lastDayValue：\(lastDayValue)")
        
        guard let lastDate = newDateFormatter.date(from: lastDayValue) else { return nil }
        
        print("lastDate：\(lastDate + Double(Date.secondsOfDay - 1))")

        return lastDate + Double(Date.secondsOfDay - 1)
    }
}
