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
    
    static let imageNames: [String: String] = ["洗碗": "WashDishes",
                                               "洗衣服": "WashClothes",
                                               "晾衣服": "DryClothes",
                                               "摺衣服": "FoldClothes",
                                               "燙衣服": "IronClothes",
                                               "倒垃圾": "ThrowTrash",
                                               "刷廁所": "CleanBathroom",
                                               "擦窗戶": "CleanWindow",
                                               "修繕": "Repair",
                                               "澆花": "WaterFlower",
                                               "遛狗": "WalkDog",
                                               "收納": "Storage",
                                               "接送": "PickUp",
                                               "帶小孩": "TakeCareKid",
                                               "煮飯": "Cook",
                                               "買菜": "Grocery",
                                               "掃地": "BroomFloor",
                                               "拖地": "MopFloor",
                                               "吸地": "VacuumCleaner",
                                               "其他": "CustomChore"
    ]
    
}
