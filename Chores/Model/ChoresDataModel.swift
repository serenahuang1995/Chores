//
//  ChoresDataModel.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/19.
//

import Foundation

struct Group: Codable {
  
  var groupID: String
  
  var chores: Chores
  
  var choresItem: [String]
  
}

struct Chores: Codable {
  
  var id: String?
  
  var item: String
  
  var point: Int
  
  var hour: Int
  
  var owner: User?
  
  var status: Int
  
  var dictTransfor: [String: Any] {
    
    return [
      "id": id as Any,
      "item": item as Any,
      "point": point as Any,
      "hour": hour as Any,
      "owner": owner?.dictTransfor,
      "status": status as Any
    ]
  }
  
}

struct User: Codable {
  
  var id: String
  
  var name: String
  
  var picture: String
  
  var point: Int
  
  var weekHours: Int
  
  var totalHours: Int
  
  var groupID: String
  
  var dictTransfor: [String: Any] {
    return [
      "id": id as Any,
      "name": name as Any,
      "picture": picture as Any,
      "point": point as Any,
      "weekHours": weekHours as Any,
      "totalHours": totalHours as Any,
      "groupID": groupID as Any
    ]
  }

}
