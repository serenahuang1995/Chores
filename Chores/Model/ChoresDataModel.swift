//
//  ChoresDataModel.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/19.
//

import Foundation

struct Group: Codable {
  
  var groupID: String
  
  var chores: Chore
  
  var choresItem: [String]
  
}

struct Chore: Codable {
  
  var id: String
  
  var item: String
  
  var points: Int
  
  var hours: Int
  
  var owner: String?
  
  var status: Int
  
//  var dictTransfor: [String: Any] {
//    
//    return [
//      "id": id as Any,
//      "item": item as Any,
//      "points": points as Any,
//      "hours": hours as Any,
//      "owner": owner?.dictTransfor,
//      "status": status as Any
//    ]
//  }
  
}

struct User: Codable {
  
  var id: String
  
  var name: String
  
  var picture: String
  
  var points: Int
  
  var weekHours: Int
  
  var totalHours: Int
  
  var groupId: String
  
  var dictTransfor: [String: Any] {
    return [
      "id": id as Any,
      "name": name as Any,
      "picture": picture as Any,
      "points": points as Any,
      "weekHours": weekHours as Any,
      "totalHours": totalHours as Any,
      "groupId": groupId as Any
    ]
  }

}
