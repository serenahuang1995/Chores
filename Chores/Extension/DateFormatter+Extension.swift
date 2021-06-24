//
//  DateFormatter+Extension.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/6/22.
//

import UIKit

enum DateFormat: String {
    
    case week = "EEEE"
    
    case simple = "yyyy / MM / dd"
    
    case general = "yyyy年MM月dd日"
    
    case detail = "yyyy年MM月dd日 HH時mm分ss秒"
}

extension DateFormatter {
    
    func convertDateToString(date: Date, type: DateFormat) -> String {
        
        let dateFormatter = self
        
        dateFormatter.dateFormat = type.rawValue
        
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }    
}
