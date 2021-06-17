//
//  KRProgressHUD.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/6/17.
//

import Foundation
//import KRProgressHUD
//
//enum HUDType {
//    
//    case success(String)
//    
//    case failure(String)
//}
//
//class KRProgressHUD {
//    
//    static let shared = KRProgressHUD()
//    
//    private init() { }
//    
//    let hub = KRProgressHUDAppearance
//
//    static func show(type: HUDType) {
//        
//        switch type {
//        
//        case .success(let text):
//            
//            showSuccess(text: text)
//            
//        case .failure(let text):
//            
//            showError(text: text)
//        }
//    }
//    
//    static func showSuccess(text: String = "success") {
//        
//        if !Thread.isMainThread {
//            
//            DispatchQueue.main.async {
//                showSuccess(text: text)
//            }
//            
//            return
//        }
        
        

//        shared.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
//
//        shared.hud.show(in: shared.view)
//
//        shared.hud.dismiss(afterDelay: 1.5)
//    }
//
//    static func showError(text: String = "Failure") {
//
//        if !Thread.isMainThread {
//
//            DispatchQueue.main.async {
//                showError(text: text)
//            }
//
//            return
//        }
//    }
//}
