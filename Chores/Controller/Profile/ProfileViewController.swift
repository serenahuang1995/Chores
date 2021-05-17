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
  
  @IBOutlet weak var indicatorView: UIView!
  
  @IBOutlet weak var dataContainerView: UIView!
  
  @IBOutlet weak var recordsContainerView: UIView!
  
  @IBOutlet var switchButton: [UIButton]!

  var containerViews: [UIView] {

    return [recordsContainerView, dataContainerView]

  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    updateContainerView(type: .records)
    
  }

  override func viewDidLayoutSubviews() {

    indicatorView.center.x = switchButton[0].center.x

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

    for btn in switchButton {

      btn.isSelected = false
    }

    sender.isSelected = true

    moveIndicatorView(sender: sender)

    guard let type = PageType(rawValue: sender.tag) else { return }

    updateContainerView(type: type)

  }

  private func moveIndicatorView(sender: UIButton) {

    UIView.animate(withDuration: 0.3) {
      self.indicatorView.center.x = self.switchButton[sender.tag].center.x
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
