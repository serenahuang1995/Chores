//
//  StringInfo.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/27.
//

import Foundation

struct Segue {
    
    static let initial = "SegueInitialPage"
    
    static let invitation = "SegueInvitation"
    
    static let main = "SegueMainPage"
    
    static let profile = "SegueProfile"
    
    static let transfer = "SegueTransfer"
    
    static let dialog = "SegueTransferDialog"

    static let addChore = "SegueAddChore"
    
    static let addMember = "SegueAddMember"
    
    static let scanner = "SegueScanner"
    
    static let week = "SegueWeek"
    
    static let month = "SegueMonth"
    
    static let total = "SegueTotal"
    
    static let records = "SegueRecords"
    
    static let data = "SegueData"
    
    static let setting = "SegueSetting"
    
    static let rename = "SegueRename"
    
    static let leaveGroup = "SegueLeaveGroup"
    
    static let points = "SegueSpendPoints"
    
    static let detail = "SegueDetail"
}

struct Lottie {
    
    static let signin = "Signin"
    
    static let loading = "Loading"
    
    static let washing = "Washing"
    
    static let house = "House"
}

// About FirebaseManager and UserManager
struct Collection {
    
    static let groups = "groups"
    
    static let users = "users"
    
    static let chores = "chores"
    
    static let invitations = "invitations"
}

struct GroupField {
    
    static let id = "id"
    
    static let choreTypes = "choreTypes"
}

struct ChoreField {
    
    static let id = "id"
    
    static let status = "status"
    
    static let points = "points"
    
    static let hours = "hours"
    
    static let owner = "owner"
    
    static let transfer = "transfer"
    
    static let completedDate = "completedDate"
}

struct UserField {
    
    static let id = "id"
    
    static let weekHours = "weekHours"
    
    static let totalHours = "totalHours"
    
    static let points = "points"
    
    static let groupId = "groupId"
    
    static let name = "name"
    
    static let picture = "picture"
    
    static let isSpent = "isSpent"
}
