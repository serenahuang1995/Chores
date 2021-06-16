//
//  ChoresDataModel.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/19.
//

import Foundation
import Firebase

struct Group: Codable {
    
    var id: String
    
    var choreTypes: [String]
    
}

struct Chore: Codable {
    
    var id: String
    
    var item: String
    
    var points: Int
    
    var hours: Int
    
    var owner: String?
    
    var status: Int
    
    var completedDate: Timestamp?
    
    var transfer: String?
}

struct User: Codable {
    
    var id: String
    
    var name: String
    
    var picture: String
    
    var points: Int
    
    var weekHours: Int
    
    var totalHours: Int
    
    var groupId: String?
    
    var isSpent: Bool? = false
}

struct Invitation: Codable {
    
    var group: String
    
    var name: String
    
    var id: String
}
