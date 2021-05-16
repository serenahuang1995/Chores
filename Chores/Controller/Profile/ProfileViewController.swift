//
//  ProfileViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/12.
//

import UIKit

class ProfileViewController: UIViewController {
  
  let indicatorView = UIView()

  @IBOutlet weak var dataButton: UIButton!
  @IBOutlet weak var recordsButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .orangeFBDAA0
    setUpIndicatorView()
  }
  
  override func viewDidLayoutSubviews() {
    indicatorView.center.x = recordsButton.center.x
  }
  
  @IBAction func clickRecordsButton(_ sender: UIButton) {
    UIView.animate(withDuration: 0.3) {
      self.indicatorView.center.x = self.recordsButton.center.x
    }
  }
  
  @IBAction func clickDataButton(_ sender: UIButton) {
    UIView.animate(withDuration: 0.3) {
      self.indicatorView.center.x = self.dataButton.center.x
    }
  }
  
  func setUpIndicatorView() {
    
    indicatorView.backgroundColor = .whiteF6F7F9
    
    indicatorView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(indicatorView)
    
    NSLayoutConstraint.activate([
      indicatorView.topAnchor.constraint(equalTo: recordsButton.bottomAnchor, constant: 0),
      indicatorView.heightAnchor.constraint(equalToConstant: 5),
      indicatorView.widthAnchor.constraint(equalToConstant: recordsButton.frame.width / 2)
    ])
  }

}
