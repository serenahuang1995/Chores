//
//  Data + Extension.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/6/6.
//

//import UIKit
//
//extension Date {
//    //MARK: - 獲取日期各種值
//    //MARK: 年
//    func year() ->Int {
//        let calendar = NSCalendar.current
//        let com = calendar.dateComponents([.year,.month,.day], from: self)
//        return com.year!
//    }
//    //MARK: 月
//    func month() ->Int {
//        let calendar = NSCalendar.current
//        let com = calendar.dateComponents([.year,.month,.day], from: self)
//        return com.month!
//        
//    }
//    //MARK: 日
//    func day() ->Int {
//        let calendar = NSCalendar.current
//        let com = calendar.dateComponents([.year,.month,.day], from: self)
//        return com.day!
//
//    }
//    //MARK: 星期幾
//    func weekDay()->Int{
//        let interval = Int(self.timeIntervalSince1970)
//        let days = Int(interval/86400) // 24*60*60
//        let weekday = ((days + 4)%7+7)%7
//        return weekday == 0 ? 7 : weekday
//    }
//    //MARK: 當月天數
//    func countOfDaysInMonth() ->Int {
//        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
//        let range = (calendar as NSCalendar?)?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: self)
//        return (range?.length)!
//
//    }
//    //MARK: 當月第一天是星期幾
//    func firstWeekDay() ->Int {
//        //1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
//        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
//        let firstWeekDay = (calendar as NSCalendar?)?.ordinality(of: NSCalendar.Unit.weekday, in: NSCalendar.Unit.weekOfMonth, for: self)
//        return firstWeekDay! - 1
//        
//    }
//    //MARK: - 日期的一些比較
//    //是否是今天
//    func isToday()->Bool {
//        let calendar = NSCalendar.current
//        let com = calendar.dateComponents([.year,.month,.day], from: self)
//        let comNow = calendar.dateComponents([.year,.month,.day], from: Date())
//        return com.year == comNow.year && com.month == comNow.month && com.day == comNow.day
//    }
//    //是否是這個月
//    func isThisMonth()->Bool {
//        let calendar = NSCalendar.current
//        let com = calendar.dateComponents([.year,.month,.day], from: self)
//        let comNow = calendar.dateComponents([.year,.month,.day], from: Date())
//        return com.year == comNow.year && com.month == comNow.month
//    }
//    
//    //MARK: - 當前時間相關
//    //MARK: 今年
//    func currentYear() ->Int {
//        let calendar = NSCalendar.current
//        let com = calendar.dateComponents([.year,.month,.day], from: Date())
//        return com.year!
//    }
//    //MARK: 今月
//    func currentMonth() ->Int {
//        let calendar = NSCalendar.current
//        let com = calendar.dateComponents([.year,.month,.day], from: Date())
//        return com.month!
//
//    }
//    //MARK: 今日
//    func currentDay() ->Int {
//        let calendar = NSCalendar.current
//        let com = calendar.dateComponents([.year,.month,.day], from: Date())
//        return com.day!
//
//    }
//    //MARK: 今天星期幾
//    func currentWeekDay()->Int{
//        let interval = Int(Date().timeIntervalSince1970)
//        let days = Int(interval/86400) // 24*60*60
//        let weekday = ((days + 4)%7+7)%7
//        return weekday == 0 ? 7 : weekday
//    }
//    //MARK: 本月天數
//    func countOfDaysInCurrentMonth() ->Int {
//        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
//        let range = (calendar as NSCalendar?)?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: Date())
//        return (range?.length)!
//
//    }
//    //MARK: 當月第一天是星期幾
//    func firstWeekDayInCurrentMonth() ->Int {
//        //星期和數字一一對應 星期日：7
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM"
//        let date = dateFormatter.date(from: String(Date().year())+"-"+String(Date().month()))
//        let calender = Calendar(identifier:Calendar.Identifier.gregorian)
//        let comps = (calender as NSCalendar?)?.components(NSCalendar.Unit.weekday, from: date!)
//        var week = comps?.weekday
//        if week == 1 {
//            week = 8
//        }
//        return week! - 1
//    }
//    //MARK: - 獲取指定日期各種值
//    //根據年月得到某月天數
//    func getCountOfDaysInMonth(year:Int,month:Int) ->Int{
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM"
//        let date
//            = dateFormatter.date(from: String(year)+"-"+String(month))
//        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
//        let range = (calendar as NSCalendar?)?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: date!)
//        return (range?.length)!
//    }
//    //MARK: 根據年月得到某月第一天是周幾
//    func getfirstWeekDayInMonth(year:Int,month:Int) -> Int{
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM"
//        let date
//            = dateFormatter.date(from: String(year)+"-"+String(month))
//        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
//        let comps = (calendar as NSCalendar?)?.components(NSCalendar.Unit.weekday, from: date!)
//        let week = comps?.weekday
//        return week! - 1
//    }
//
//    //MARK: date轉日期字串
//    func dateToDateString(_ date:Date, dateFormat:String) -> String {
//        let timeZone = NSTimeZone.local
//        let formatter = DateFormatter()
//        formatter.timeZone = timeZone
//        formatter.dateFormat = dateFormat
//
//        let date = formatter.string(from: date)
//        return date
//    }
//
//    //MARK: 日期字串轉date
//    func dateStringToDate(_ dateStr:String) ->Date {
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let date
//            = dateFormatter.date(from: dateStr)
//        return date!
//    }
//    //MARK: 時間字串轉date
//    func timeStringToDate(_ dateStr:String) ->Date {
//        let dateFormatter = DateFormatter()
////        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        dateFormatter.dateFormat = "yyyy-MM-dd  HH:mm:ss"
//        let date
//            = dateFormatter.date(from: dateStr)
//        return date!
//    }
//
//    //MARK: 計算天數差
//    func dateDifference(_ dateA:Date, from dateB:Date) -> Double {
//        let interval = dateA.timeIntervalSince(dateB)
//        return interval/86400
//
//    }
//
//    //MARK: 比較時間先後
//    func compareOneDay(oneDay:Date, withAnotherDay anotherDay:Date) -> Int {
//        let dateFormatter:DateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let oneDayStr:String = dateFormatter.string(from: oneDay)
//        let anotherDayStr:String = dateFormatter.string(from: anotherDay)
//        let dateA = dateFormatter.date(from: oneDayStr)
//        let dateB = dateFormatter.date(from: anotherDayStr)
//        let result:ComparisonResult = (dateA?.compare(dateB!))!
//        //Date1  is in the future
//        if(result == ComparisonResult.orderedDescending ) {
//            return 1
//
//        }
//        //Date1 is in the past
//        else if(result == ComparisonResult.orderedAscending) {
//            return 2
//
//        }
//        //Both dates are the same
//        else {
//            return 0
//        }
//    }
//
//    //MARK: 時間與時間戳之間的轉化
//    //將時間轉換為時間戳
//    func stringToTimeStamp(_ stringTime:String)->Int {
//        let dfmatter = DateFormatter()
//        dfmatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//        dfmatter.locale = Locale.current
//
//        let date = dfmatter.date(from: stringTime)
//
//        let dateStamp:TimeInterval = date!.timeIntervalSince1970
//
//        let dateSt:Int = Int(dateStamp)
//
//        return dateSt
//    }
//    //將時間戳轉換為年月日
//    func timeStampToString(_ timeStamp:String)->String {
//        let string = NSString(string: timeStamp)
//        let timeSta:TimeInterval = string.doubleValue
//        let dfmatter = DateFormatter()
//        dfmatter.dateFormat="yyyy年MM月dd日"
//        let date = Date(timeIntervalSince1970: timeSta)
//        return dfmatter.string(from: date)
//    }
//    //將時間戳轉換為具體時間
//    func timeStampToStringDetail(_ timeStamp:String)->String {
//        let string = NSString(string: timeStamp)
//        let timeSta:TimeInterval = string.doubleValue
//        let dfmatter = DateFormatter()
//        dfmatter.dateFormat="yyyy年MM月dd日HH:mm:ss"
//        let date = Date(timeIntervalSince1970: timeSta)
//        return dfmatter.string(from: date)
//    }
//    //將時間戳轉換為時分秒
//    func timeStampToHHMMSS(_ timeStamp:String)->String {
//        let string = NSString(string: timeStamp)
//        let timeSta:TimeInterval = string.doubleValue
//        let dfmatter = DateFormatter()
//        dfmatter.dateFormat="HH:mm:ss"
//        let date = Date(timeIntervalSince1970: timeSta)
//        return dfmatter.string(from: date)
//    }
//    //獲取系統的當前時間戳
//    func getStamp()->Int{
//        //獲取當前時間戳
//        let date = Date()
//        let timeInterval:Int = Int(date.timeIntervalSince1970)
//        return timeInterval
//    }
//    //月份數字轉漢字
//    func numberToChina(monthNum:Int) -> String {
//        let ChinaArray = ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"]
//        let ChinaStr:String = ChinaArray[monthNum - 1]
//        return ChinaStr
//
//    }
//    //MARK: 數字前補0
//    static func add0BeforeNumber(_ number:Int) -> String {
//        if number >= 10 {
//            return String(number)
//        }else{
//            return "0" + String(number)
//        }
//    }
//}
