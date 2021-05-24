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
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
