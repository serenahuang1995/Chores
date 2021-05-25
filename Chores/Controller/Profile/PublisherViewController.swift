//
//  PublisherViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/18.
//

import UIKit
import MIBlurPopup

class PublisherViewController: UIViewController {
  
  @IBOutlet weak var popView: CardView!
  
//  let blackView = UIView(frame: UIScreen.main.bounds)
  
  override func viewDidLoad() {
    super.viewDidLoad()

//    showBlackView()
    
  }
  
  @IBAction func backToProfilePage(_ sender: Any) {
    dismiss(animated: true, completion: nil)
//    blackView.removeFromSuperview()
  }
  
  @IBAction func sureToSpendPoint(_ sender: Any) {
    
//    spendPoints(user: User)
    
    dismiss(animated: true, completion: nil)

  }
  
//  func spendPoints(user: User) {
//
//    if user.points >= 300 {
//      
//    } else {
//      
//    }
//    
//    
//    
//    
//  }
//  
//  func updatePoints(user: User) {
//    
//    FirebaseProvider.shared.updateUserPoints(user: user) { result in
//      
//      switch result {
//      
//      case .success(let success):
//        print(success)
//      
//      case .failure(let error):
//        print(error)
//      
//      }
//         
//    }
//  }
  
  
  
//  private func showBlackView() {
//    blackView.backgroundColor = .black
//    blackView.alpha = 0.7
//    presentingViewController?.view.addSubview(blackView)
//  }
  
}

extension PublisherViewController: MIBlurPopupDelegate {
  
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

// extension PublisherViewController: UIViewControllerAnimatedTransitioning {
//  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//    <#code#>
//  }
//  
//  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//    <#code#>
//  }
//  
//  
// }
