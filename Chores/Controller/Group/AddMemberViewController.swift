//
//  AddMemberViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/24.
//

import UIKit
import MIBlurPopup

class AddMemberViewController: UIViewController {
    
    @IBOutlet weak var popView: UIView!
    
    @IBOutlet weak var addMemberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backToGroupPage(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}

extension AddMemberViewController: MIBlurPopupDelegate {
    
    var popupView: UIView {
        
        popView
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
