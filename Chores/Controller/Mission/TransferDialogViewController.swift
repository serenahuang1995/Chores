//
//  TransferDialogViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/6/4.
//

import UIKit
import MIBlurPopup

class TransferDialogViewController: UIViewController {
    
    @IBOutlet weak var cardView: CardView!
    
    @IBOutlet weak var transferLabel: UILabel!
    
    var chore: Chore?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let chore = chore {
           
            transferLabel.text = "\(UserProvider.shared.getUserNameById(id: chore.owner ?? "") ?? "") 企圖將「\(chore.item)」轉交給你"
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        dismiss(animated: false, completion: nil)
    }

    @IBAction func acceptChore(_ sender: Any) {
        
        if let chore = chore {
            
            acceptChore(chore: chore)
        }
    }
    
    @IBAction func rejectChore(_ sender: Any) {
        
        if let chore = chore {
            
            resetTransferChore(chore: chore)
        }
    }
    
    func acceptChore(chore: Chore) {
        
        FirebaseProvider.shared.assignNewChoreOwner(selectedChore: chore) { [weak self] result in
            
            switch result {
            
            case .success(let success):
                
                print(success)
                
                self?.updatePointsForTransferChore(chore: chore)
                                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    // 更新轉交家事的人的 points
    func updatePointsForTransferChore(chore: Chore) {
        
        guard let userId = chore.owner else { return }
        
        UserProvider.shared.fetchOwner(userId: userId) { [weak self] result in
            
            switch result {
            
            case .success(var user):
                
                print(user)
                    
                user.points -= 15
                
                // 更新對方的 points
                self?.updatePoints(user: user)
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    // update 對方的 points
    func updatePoints(user: User) {
        
        UserProvider.shared.updateUserPoints(user: user) { [weak self] result in
            
            switch result {
            
            case .success(let success):
                
                print("update user points \(success)")
                
                UserProvider.shared.user.points += 15
                
                // 更新自己的points
                self?.updateSelfPoints()
                
            case .failure(let error):
                
                print(error)
                
            }
        }
    }
    
    func updateSelfPoints() {
        
        UserProvider.shared.updateUserPoints(user: UserProvider.shared.user) { [weak self] result in
            
            switch result {
            
            case .success(let success):
                
                print("update points \(success)")
                
                self?.dismiss(animated: true, completion: nil)
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func resetTransferChore(chore: Chore) {
        
        FirebaseProvider.shared.resetTransferOwner(selectedChore: chore) { [weak self] result in
            
            switch result {
            
            case .success(let success):
                
                print("reset transfer \(success)")
                
                self?.dismiss(animated: true, completion: nil)
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
}

extension TransferDialogViewController: MIBlurPopupDelegate {
    
    var popupView: UIView { cardView }
    
    var blurEffectStyle: UIBlurEffect.Style? { .dark }
    
    var initialScaleAmmount: CGFloat { 0.0 }
    
    var animationDuration: TimeInterval { 0.2 }
}
