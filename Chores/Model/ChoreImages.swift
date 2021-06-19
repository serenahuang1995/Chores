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
    
    static let imageNames: [ChoreItem: ImageAsset] = [
        .washDishes: .WashDishes,
        .washClothes: .WashClothes,
        .dryClothes: .DryClothes,
        .foldClothes: .FoldClothes,
        .ironClothes: .IronClothes,
        .throwTrash: .ThrowTrash,
        .cleanBathroom: .CleanBathroom,
        .cleanWindow: .CleanWindow,
        .repair: .Repair,
        .waterFlower: .WaterFlower,
        .walkDog: .WalkDog,
        .storage: .Storage,
        .pickUp: .PickUp,
        .takeCareKid: .TakeCareKid,
        .cook: .Cook,
        .grocery: .Grocery,
        .broomFloor: .BroomFloor,
        .mopFloor: .MopFloor,
        .vacuumCleaner: .VacuumCleaner,
        .customChore: .CustomChore
    ]
}
