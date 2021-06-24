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
        
        let weekDay = DateFormatter().convertDateToString(date: date, type: .week)
        
        return weekDay
    }
    
    // 當前月份開始日期
    func startOfCurrentMonth() -> Date {
        
        let date = self
        
        let calendar = Calendar.current
        
        let components = calendar.dateComponents(Set<Calendar.Component>([.year, .month]),
                                                 from: date)
        
        let startOfMonth = calendar.date(from: components)!
        
        return startOfMonth
    }
    
    // 當前月份結束日期
    func endOfCurrentMonth(returnDetailTime: Bool = false) -> Date {
        
        var components = DateComponents()
        
        components.month = 1
        
        if returnDetailTime {
            
            components.second = -1
            
        } else {
            
            components.day = -1
        }
         
        let endOfMonth =  Calendar.current.date(byAdding: components, to: startOfCurrentMonth())!
        
        return endOfMonth
    }
    
    func getFirstDayDateInWeek() -> Date? {
        
        let todayDate = self
        
        let dateFormatter = DateFormatter()

        // 計算本週第n天
        let day = Calendar.current.ordinality(of: .day, in: .weekOfMonth, for: todayDate)
        
        let firstDay = todayDate - Double(((day ?? 1) - 1) * Date.secondsOfDay)
        
        print("第一天\(firstDay)")
        
        let firstDayValue = dateFormatter.convertDateToString(date: firstDay, type: .detail)
        
        print("日期：\(firstDayValue)")
        
        guard let firstDate = dateFormatter.date(from: firstDayValue) else { return nil }
        
        print("firstDate：\(firstDate)")

        return firstDate
    }
    
    func getLastDayDateInWeek() -> Date? {
        
        let todayDate = self
        
        let dateFormatter = DateFormatter()

        // 計算本週第n天
        let day = Calendar.current.ordinality(of: .day, in: .weekOfMonth, for: todayDate)
        
        print("本週第\(day!)天")
        
        let lastDay = todayDate + Double((7 - (day ?? 1)) * Date.secondsOfDay)
        
        print("最後一天\(lastDay)")
        
        let lastDayValue = dateFormatter.convertDateToString(date: lastDay, type: .detail)
        
        print("日期：\(lastDayValue)")
        
        guard let lastDate = dateFormatter.date(from: lastDayValue) else { return nil }
        
        print("lastDate：\(lastDate + Double(Date.secondsOfDay - 1))")

        return lastDate + Double(Date.secondsOfDay - 1)
    }
}
