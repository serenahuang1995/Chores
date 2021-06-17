//
//  RenameViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/6/6.
//

import UIKit
import MIBlurPopup
import KRProgressHUD
import IQKeyboardManagerSwift

class RenameViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField! {
        
        didSet {
            
            nameTextField.delegate = self
        }
    }
        
    @IBOutlet weak var cardView: CardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidDisappear(_ animated: Bool) {

        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
 
    @IBAction func sureToChangeName(_ sender: Any) {
        
        guard let userName = nameTextField.text else {
            
            KRProgressHUD.showSuccess(withMessage: "欄位不能是空白的唷！")
            
            return
        }
        
        if userName.isEmpty {
           
            KRProgressHUD.showError(withMessage: "欄位不能是空白的唷！")

            return
        }
        
        changeUserName(name: userName)
    }
    
    func changeUserName(name: String) {
        
        UserProvider.shared.changeUserName(name: name) { [weak self] result in
            
            switch result {
            
            case .success(let success):
                
                print("rename \(success)")
                
                self?.dismiss(animated: true, completion: nil)
                
                KRProgressHUD.showSuccess(withMessage: "更改名稱成功！")
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
}

extension RenameViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let textLimitCounts = 7

        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= textLimitCounts
    }
}

extension RenameViewController: MIBlurPopupDelegate {
    
    var popupView: UIView { cardView }
    
    var blurEffectStyle: UIBlurEffect.Style? { .dark }
    
    var initialScaleAmmount: CGFloat { 0.0 }
    
    var animationDuration: TimeInterval { 0.2 }
}
