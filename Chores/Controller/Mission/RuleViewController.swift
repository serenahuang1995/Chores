//
//  RuleViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/18.
//

import UIKit
import MIBlurPopup

class RuleViewController: UIViewController {
    
    @IBOutlet weak var cardView: CardView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func navigateAddChoresPage(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}

extension RuleViewController: MIBlurPopupDelegate {
    
    var popupView: UIView { cardView }
    
    var blurEffectStyle: UIBlurEffect.Style? { .dark }
    
    var initialScaleAmmount: CGFloat { 0.0  }
    
    var animationDuration: TimeInterval { 0.2 }
}
