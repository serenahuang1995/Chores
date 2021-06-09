//
//  ChangeNameViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/6/6.
//

import UIKit
import KRProgressHUD
import MIBlurPopup

class ChangeNameViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
        
    @IBOutlet weak var popView: CardView!
    
    weak var delegate: ProfileDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func cancel(_ sender: Any) {
        
        dismiss(animated: true) {
            
            self.delegate?.backToProfile()
        }
    }
 
    @IBAction func sureToChangeName(_ sender: Any) {
        
        guard let userName = nameTextField.text else {
            
            KRProgressHUD.showError(withMessage: "欄位不能是空白的唷！")
            
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
                
                print(success)
                
                self?.dismiss(animated: true) {
                    
                    self?.delegate?.backToProfile()
                }
                
                KRProgressHUD.showSuccess(withMessage: "更改名稱成功！")
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
}

extension ChangeNameViewController: MIBlurPopupDelegate {
    
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
