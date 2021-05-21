//
//  ProfileViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/12.
//

import UIKit

class ProfileViewController: UIViewController {
  
  private enum PageType: Int {
    
    case records = 0
    
    case data = 1
    
  }
  
  private struct Segue {
    
    static let records = "SegueRecords"
    
    static let data = "SegueData"
    
  }
  
  @IBOutlet weak var userNameLabel: UILabel!
  
  @IBOutlet weak var totalPointsLabel: UILabel!
  
  @IBOutlet weak var weekHoursLabel: UILabel!
  
  @IBOutlet weak var indicatorView: UIView! {

    didSet {

      indicatorView.backgroundColor = .orangeE89E21

    }

  }
  
  @IBOutlet weak var dataContainerView: UIView!
  
  @IBOutlet weak var recordsContainerView: UIView!
  
  @IBOutlet var switchButtons: [UIButton]!

  var containerViews: [UIView] {

    return [recordsContainerView, dataContainerView]

  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    updateContainerView(type: .records)
    
    FirebaseProvider.shared.fetchUserData { result in

      switch result {

      case .success(let user):
        print(user)

        self.userNameLabel.text = user.name
        self.totalPointsLabel.text = "累積點數：\(user.points)"
        self.weekHoursLabel.text = "本週時數：\(user.weekHours) / 50"

      case .failure(let error):

        print(error)

      }

    }

  }

  override func viewDidLayoutSubviews() {

    indicatorView.center.x = switchButtons[0].center.x

  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    let identifier = segue.identifier

    switch identifier {

    case Segue.records:
      _ = segue.destination as? ChoresRecordsViewController

    case Segue.data:
      _ = segue.destination as? ChoresDataViewController

    default:
      return
      
    }
    
  }

  @IBAction func clickSwitchButton(_ sender: UIButton) {

    for btn in switchButtons {

      btn.isSelected = false
      
    }

    sender.isSelected = true

    moveIndicatorView(sender: sender)

    guard let type = PageType(rawValue: sender.tag) else { return }

    updateContainerView(type: type)

  }

  private func moveIndicatorView(sender: UIButton) {

    UIView.animate(withDuration: 0.3) {
      self.indicatorView.center.x = self.switchButtons[sender.tag].center.x
      
    }
  }

  private func updateContainerView(type: PageType) {

    containerViews.forEach({ $0.isHidden = true })

    switch type {

    case .records:
      recordsContainerView.isHidden = false

    case .data:
      dataContainerView.isHidden = false

    }
  }
  
}
