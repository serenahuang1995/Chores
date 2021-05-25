//
//  File.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/23.
//
//

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
////    static let shared = KRProgressHUD()
//
//    private init() { }
////
////  let hud = KRProgressHUD
//
//    var view: UIView {
//      
//      let appdelegate = UIApplication.shared.delegate as? AppDelegate
//
//      return appdelegate!.window!.rootViewController!.view
//
//    }
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
//            showFailure(text: text)
//        }
//    }
//
//    static func showSuccess(text: String = "新增家事成功") {
//      
//      KRProgressHUD.showSuccess(text: text)
//      
//      
//      
//
////        if !Thread.isMainThread {
////
////            DispatchQueue.main.async {
////                showSuccess(text: text)
////            }
////
////            return
////        }
//
////        shared.hud.textLabel.text = text
////
////        shared.hud.indicatorView = KRProgressHUDSuccessIndicatorView()
////
////        shared.hud.show(in: shared.view)
////
////        shared.hud.dismiss(afterDelay: 1.5)
//    }
//
//    static func showFailure(text: String = "Failure") {
//      
//      KRProgressHUD.showFailure(text: text)
//
//        if !Thread.isMainThread {
//
//            DispatchQueue.main.async {
//                showFailure(text: text)
//            }
//
//            return
//        }
//
//        shared.hud.textLabel.text = text
//
//        shared.hud.indicatorView = JGProgressHUDErrorIndicatorView()
//
//        shared.hud.show(in: shared.view)
//
//        shared.hud.dismiss(afterDelay: 1.5)
//    }
//
//    static func dismiss() {
//
//        if !Thread.isMainThread {
//
//            DispatchQueue.main.async {
//                dismiss()
//            }
//
//            return
//        }
//
//        shared.hud.dismiss()
//    }
//}
