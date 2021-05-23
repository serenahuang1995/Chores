//
//  UserProvider.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/23.
//

import Foundation

class UserProvider {
    
    static let shared = UserProvider()
    
    var user: User = User(
      id: "54Serena",
      name: "Serena",
      picture: "",
      points: 66666666666,
      weekHours: 666,
      totalHours: 66666666666,
      groupId: "XW1OPQRPZig550EXPDQG")
    
}
