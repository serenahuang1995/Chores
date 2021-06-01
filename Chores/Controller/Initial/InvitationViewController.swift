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

    @IBAction func acceptInvitation(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }

    @IBAction func rejectInvitation(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)

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
