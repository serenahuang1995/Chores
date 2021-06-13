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
    
    @IBOutlet weak var popView: CardView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func backToProfilePage(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sureToSpendPoint(_ sender: Any) {
        
        spendUserPoints()
        
        dismiss(animated: true, completion: nil)
    }
    
    func spendUserPoints() {
        
        var user = UserProvider.shared.user
        
        print(user)
        
        if user.points >= 300 {
            
            user.points -= 300
            
            KRProgressHUD.showSuccess(withMessage: "成功扣除點數！")
            
            updatePoints(user: user)
            
            getMedal()
            
        } else {
            
            KRProgressHUD.showError(withMessage: "點數不足...再多做一點家事吧！")
        }
    }
    
    func updatePoints(user: User) {
        
        FirebaseProvider.shared.updateUserPoints(user: user) { result in
            
            switch result {
            
            case .success(let success):
                
                print(success)

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
    
    var popupView: UIView {
        
        popView
    }
    
    var blurEffectStyle: UIBlurEffect.Style? {
        
        .dark
    }
    
    var initialScaleAmmount: CGFloat {
        
        0
    }
    
    var animationDuration: TimeInterval {
        
        0.2
    }
}
