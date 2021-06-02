//
//  InvitationViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/6/1.
//

import UIKit
import MIBlurPopup

class InvitationViewController: UIViewController {

    @IBOutlet weak var invitationView: CardView!
    
    @IBOutlet weak var invitationLabel: UILabel!
    
    var invitation: Invitation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let invitation = invitation {
            
            invitationLabel.text = "\(invitation.name) 邀請你加入小屋"
        }
    }

    // user 加入 invitation 內的 group id 成功加入之後再 dismiss
    @IBAction func acceptInvitation(_ sender: Any) {
        
        accept()
        
//        performSegue(withIdentifier: Segue.main, sender: nil)

//        dismiss(animated: true, completion: nil)

    }

    // 刪除 invitation 刪除後 Success 再 dismiss
    @IBAction func rejectInvitation(_ sender: Any) {
        
        deleteInvitation()
                
        dismiss(animated: true, completion: nil)
    }
    
    func deleteInvitation() {
        
        if let invitation = invitation {
            
            UserProvider.shared.rejectInvitation(invitation: invitation) { result in
                
                switch result {
                
                case .success(let message):
                    
                    print(message)
                    
//                    self?.dismiss(animated: true, completion: nil)
                    
                case .failure(let error):
                    
                    print(error)
                }
            }
        }
    }
    
    func accept() {
        
        if let invitation = invitation {
            
            UserProvider.shared.updateGroupId(invitation: invitation) { [weak self] result in
                
                switch result {
                 
                case .success(let message):
                    
                    print(message)
                
                    self?.deleteInvitation()
                    
                    self?.performSegue(withIdentifier: Segue.main, sender: nil)

//                    self?.dismiss(animated: true, completion: nil)
                    
                case .failure(let error):
                    
                    print(error)
                }
            }
        }
    }
    
}

extension InvitationViewController: MIBlurPopupDelegate {
    
    var popupView: UIView {
        
        invitationView
    }
    
    var blurEffectStyle: UIBlurEffect.Style? {
        
        .dark
    }
    
    var initialScaleAmmount: CGFloat {
        
        0.0
    }
    
    var animationDuration: TimeInterval {
        0.2
    }
}
