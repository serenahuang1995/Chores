//
//  ChoreListViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/12.
//

import UIKit

class ChoreListViewController: UIViewController {
  
  // 記錄每個 Section 的狀態，預設false
  var isExpandedList: [Bool] = [false, false]
  
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      
      tableView.delegate = self
      
      tableView.dataSource = self
      
      setUpTableView()
      
    }
  }
  
  @IBOutlet weak var addChoresButton: UIButton!
  
  override func viewDidLoad() {

    super.viewDidLoad()

  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    _ = segue.destination as? AddChoresViewController
  }

  @IBAction func clickToAddChores(_ sender: Any) {
    
    performSegue(withIdentifier: "AddChores", sender: nil)
    
  }
  
  private func setUpTableView() {
    
    tableView.separatorStyle = .none
  
    tableView.registerHeaderWithNib(
      identifier: String(describing: SectionView.self), bundle: nil)
    
    tableView.registerCellWithNib(
      identifier: String(describing: UnclaimedCellView.self), bundle: nil)
    
    tableView.registerCellWithNib(
      identifier: String(describing: OngoingTableViewCell.self), bundle: nil)
    
  }
  
//  private func resetNavigationBarButton() {
//    let backButton = UIButton.set
//    
//    self.navigationItem.leftBarButtonItem = backButton
//  }

}

extension ChoreListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if section == 0 {
      return 300
    }
    return 160
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 110
  }
  
}

extension ChoreListViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeueReusableHeaderFooterView(
      withIdentifier: String(describing: SectionView.self)
    )
    guard let sectionView = header as? SectionView else { return header }
    
    sectionView.isExpanded = self.isExpandedList[section]
    sectionView.buttonTag = section
    sectionView.delegate = self
    
    // 調整section 0 的top constraint 跟 height
    if section == 0 {
      sectionView.cardView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        sectionView.cardView.topAnchor.constraint(equalTo: sectionView.topAnchor, constant: 150)
      ])
      
    } else {
      sectionView.cardView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        sectionView.cardView.topAnchor.constraint(equalTo: sectionView.topAnchor, constant: 10)
      ])
      
    }
    return sectionView
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return isExpandedList.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // true 的時候會依照不同 Section 去抓要顯示幾個 Row
    if self.isExpandedList[section] {
      
      return 5
    }
    
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      let cell = tableView.dequeueReusableCell(
        withIdentifier: String(describing: UnclaimedCellView.self),
        for: indexPath)
      guard let unclaimedCell = cell as? UnclaimedCellView else { return cell }
      unclaimedCell.setUpCellStyle()
      return unclaimedCell
      
    case 1:
      let cell = tableView.dequeueReusableCell(
        withIdentifier: String(describing: OngoingTableViewCell.self),
        for: indexPath)
      guard let ongoingCell = cell as? OngoingTableViewCell else { return cell }
      ongoingCell.setUpCellStyle()
      return ongoingCell
      
    default:
      return UITableViewCell()
    }
    
  }
  
}

extension ChoreListViewController: SectionViewDelegate {
  func showMoreItem(_ section: SectionView, _ didPressTag: Int, _ isExpanded: Bool) {
    isExpandedList[didPressTag] = !isExpanded
    tableView.reloadSections(IndexSet(integer: didPressTag), with: .automatic)
    
  }
  
}
