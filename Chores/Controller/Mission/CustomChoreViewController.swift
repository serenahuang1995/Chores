//
//  CustomChoreViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/23.
//

import UIKit
import MIBlurPopup

class CustomChoreViewController: UIViewController {

  @IBOutlet weak var popView: CardView!
  
  @IBOutlet weak var customChoreTextField: UITextField! {
    
    didSet {
      
      customChoreTextField.delegate = self
      
    }
    
  }
  
  var addCutomChoreItem: ((String) -> Void)?
  
  override func viewDidLoad() {
        super.viewDidLoad()

    }

  @IBAction func sureToAdd(_ sender: Any) {
    
    if let addCutomChore = addCutomChoreItem {
      
      addCutomChore(customChoreTextField.text!)

    }
    
    dismiss(animated: true, completion: nil)

  }
  
  @IBAction func repentToAdd(_ sender: UIButton) {
    
    dismiss(animated: true, completion: nil)
    
  }
}

extension CustomChoreViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    textField.resignFirstResponder()
    
    return true
    
  }
  
//  func textField(_ textField: UITextField,
//                 shouldChangeCharactersIn range: NSRange,
//                 replacementString string: String) -> Bool {
//    
//    if let customChoreTextField = customChoreTextField {
//      
//      if customChoreTextField.text!.count > 4 {
//        
//        customChoreTextField.textColor = .red
//        
//        return false
//        
//      }
//      
//    }
//    
//    return true
//    
//  }
  
}

extension CustomChoreViewController: MIBlurPopupDelegate {
  
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
