//
//  CustomChoreViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/23.
//

import UIKit
import MIBlurPopup
import KRProgressHUD
import IQKeyboardManagerSwift

class CustomChoreViewController: UIViewController {
    
    @IBOutlet weak var cardView: CardView!
    
    @IBOutlet weak var customChoreTextField: UITextField! {
        
        didSet {
            
            customChoreTextField.delegate = self            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addChoreType(_ sender: Any) {
        
        guard let choreType = customChoreTextField.text else { return }
        
        addChoreType(choreType: choreType)
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func addChoreType(choreType: String) {
        
        FirebaseProvider.shared.addChoreType(choreType: choreType) { [weak self] result in
            
            switch result {
            
            case .success(let choreType):
                
                print(choreType)
                
                self?.dismiss(animated: true, completion: nil)
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
}

extension CustomChoreViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let textLimitCount = 6
        
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= textLimitCount
    }
}

extension CustomChoreViewController: MIBlurPopupDelegate {
    
    var popupView: UIView { cardView }
    
    var blurEffectStyle: UIBlurEffect.Style? { .dark }
    
    var initialScaleAmmount: CGFloat { 0.0 }
    
    var animationDuration: TimeInterval { 0.2 }
}
