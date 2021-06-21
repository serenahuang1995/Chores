//
//  SpendPointsViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/18.
//

import UIKit
import MIBlurPopup
import KRProgressHUD

class SpendPointsViewController: UIViewController {
    
    @IBOutlet weak var cardView: CardView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSpendPoints(_ sender: Any) {
        
        spendUserPoints()
        
        dismiss(animated: true, completion: nil)
    }
    
    // 扣點動作的function 獨立的input user
    func deductPoints (user: inout User) -> Bool {
        
        if user.points >= 300 {
            
            user.points -= 300
            
            return true
            
        } else {
            
            return false
        }
    }
    
    func spendUserPoints() {
        
        var user = UserProvider.shared.user
        
        let deduction = deductPoints(user: &user)
        
        if deduction {
            
            KRProgressHUD.showSuccess(withMessage: "成功扣除點數！")
            
            updatePoints(user: user)
            
            getMedal()
            
        } else {
            
            KRProgressHUD.showError(withMessage: "點數不足...再多做一點家事吧！")
        }

//
//        print(user)
//
//        if user.points >= 300 {
//
//            user.points -= 300
//
//            KRProgressHUD.showSuccess(withMessage: "成功扣除點數！")
//
//            updatePoints(user: user)
//
//            getMedal()
//
//        } else {
//
//            KRProgressHUD.showError(withMessage: "點數不足...再多做一點家事吧！")
//        }
    }
    
    func updatePoints(user: User) {
        
        UserProvider.shared.updateUserPoints(user: user) { result in
            
            switch result {
            
            case .success(let success):
                
                print("update points \(success)")

            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func getMedal() {
        
        UserProvider.shared.getMedal { result in
            
            switch result {
            
            case .success(let success):
                
                print("get medal \(success)")
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
}

extension SpendPointsViewController: MIBlurPopupDelegate {
    
    var popupView: UIView { cardView }
    
    var blurEffectStyle: UIBlurEffect.Style? { .dark }
    
    var initialScaleAmmount: CGFloat { 0.0 }
    
    var animationDuration: TimeInterval { 0.2 }
}
