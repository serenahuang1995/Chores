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
    
    @IBOutlet weak var popView: CardView!
    
    @IBOutlet weak var customChoreTextField: UITextField! {
        
        didSet {
            
            customChoreTextField.delegate = self            
        }
    }
    
    let textLimitCount = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func sureToAdd(_ sender: Any) {
        
        guard let choreType = customChoreTextField.text else { return }
        
        addChoreType(choreType: choreType)
    }
    
    @IBAction func repentToAdd(_ sender: UIButton) {
        
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
        
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= textLimitCount
    }
    
    //
    //    //限制只能輸入10個字
    //     let characterCountLimit = 10
    //
    //     //每次輸入一個character時，原本textField中的字數長度
    //     let startingLength = textField.text?.characters.count ?? 0
    //     //每次輸入一個character時，新輸入的字數長度
    //     let lengthToAdd = string.characters.count
    //     //每次輸入一個character時，需要被替換掉的字數長度
    //     let lengthToReplace = range.length
    //
    //     //newLength每次輸入文字後的總長度
    //     let newLength = startingLength + lengthToAdd - lengthToReplace
    //
    //     if( newLength <= characterCountLimit ){
    //         textFieldTextcountLabel.text = String(newLength)
    //     }
    //     return newLength <= characterCountLimit
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
