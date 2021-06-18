//
//  SettingViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/26.
//

import UIKit
import Lottie

// 全部delegate回去請Profile page做事
protocol SettingDelegate: AnyObject {
    
    func onButtonRename()
    
    func onButtonLeave()
    
    func showPickerView()
}

class SettingViewController: UIViewController {
    
    @IBOutlet weak var cardView: CardView!
    
    @IBOutlet weak var renameButton: UIButton!
    
    @IBOutlet weak var changePictureButton: UIButton!
    
    @IBOutlet weak var leaveGroupButton: UIButton!
    
    weak var delegate: SettingDelegate?

    let blackView = BlackView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentingViewController?.view.addSubview(blackView)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        blackView.removeFromSuperview()

        dismiss(animated: false, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch: UITouch? = touches.first
        
        if touch?.view != cardView {
            
            blackView.removeFromSuperview()
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func rename(_ sender: Any) {
        
        blackView.removeFromSuperview()
        
        dismiss(animated: true, completion: nil)
        
        self.delegate?.onButtonRename()
    }
    
    @IBAction func changePicture(_ sender: Any) {
        
        blackView.removeFromSuperview()
        
        dismiss(animated: true, completion: nil)
        
        self.delegate?.showPickerView()
    }
    
    @IBAction func leaveGroup(_ sender: Any) {
        
        blackView.removeFromSuperview()
        
        dismiss(animated: true, completion: nil)
        
        self.delegate?.onButtonLeave()
    }
}
