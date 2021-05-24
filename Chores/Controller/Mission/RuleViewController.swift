//
//  RuleViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/18.
//

import UIKit
import MIBlurPopup

class RuleViewController: UIViewController {
  
  @IBOutlet weak var popView: CardView!
  
//  let blackView = UIView(frame: UIScreen.main.bounds)

  override func viewDidLoad() {
    super.viewDidLoad()

//    showBlackView()

  }
  
  @IBAction func backToAddChoresPage(_ sender: Any) {
    
    dismiss(animated: true, completion: nil)
//    blackView.removeFromSuperview()
    
  }
  
//  private func showBlackView() {
//
//    blackView.backgroundColor = .black
//    blackView.alpha = 0.7
//    presentingViewController?.view.addSubview(blackView)
//  }
  
}

extension RuleViewController: MIBlurPopupDelegate {
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
