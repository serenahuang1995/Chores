//
//  ChoresImages.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/18.
//

import Foundation

enum ChoreItem: String {
    
    case washDishes = "洗碗"
    
    case washClothes = "洗衣服"
    
    case dryClothes = "晾衣服"
    
    case foldClothes = "摺衣服"
    
    case ironClothes = "燙衣服"
    
    case throwTrash = "倒垃圾"
    
    case cleanBathroom = "刷廁所"
    
    case cleanWindow = "擦窗戶"
    
    case repair = "修繕"
    
    case waterFlower = "澆花"
    
    case walkDog = "遛狗"
    
    case storage = "收納"
    
    case pickUp = "接送"
    
    case takeCareKid = "帶小孩"
    
    case cook = "煮飯"
    
    case grocery = "買菜"
    
    case broomFloor = "掃地"
    
    case mopFloor = "拖地"
    
    case vacuumCleaner = "吸地"
    
    case customChore = "其他"
}

struct ChoreImages {
    
    static let imageNames: [ChoreItem.RawValue: ImageAsset] = [
        ChoreItem.washDishes.rawValue: .WashDishes,
        ChoreItem.washClothes.rawValue: .WashClothes,
        ChoreItem.dryClothes.rawValue: .DryClothes,
        ChoreItem.foldClothes.rawValue: .FoldClothes,
        ChoreItem.ironClothes.rawValue: .IronClothes,
        ChoreItem.throwTrash.rawValue: .ThrowTrash,
        ChoreItem.cleanBathroom.rawValue: .CleanBathroom,
        ChoreItem.cleanWindow.rawValue: .CleanWindow,
        ChoreItem.repair.rawValue: .Repair,
        ChoreItem.waterFlower.rawValue: .WaterFlower,
        ChoreItem.walkDog.rawValue: .WalkDog,
        ChoreItem.storage.rawValue: .Storage,
        ChoreItem.pickUp.rawValue: .PickUp,
        ChoreItem.takeCareKid.rawValue: .TakeCareKid,
        ChoreItem.cook.rawValue: .Cook,
        ChoreItem.grocery.rawValue: .Grocery,
        ChoreItem.broomFloor.rawValue: .BroomFloor,
        ChoreItem.mopFloor.rawValue: .MopFloor,
        ChoreItem.vacuumCleaner.rawValue: .VacuumCleaner,
        ChoreItem.customChore.rawValue: .CustomChore
    ]
}
