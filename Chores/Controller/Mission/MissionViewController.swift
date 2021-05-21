//
//  MissionViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/12.
//

import UIKit

protocol MissionCellDelegate: AnyObject {
  
  func clickButtonInCell(get index: Int)
  
}

class MissionViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView! {
    
    didSet {
      
      tableView.delegate = self
      
      tableView.dataSource = self
      
      setUpTableView()
      
    }
    
  }
  
  // 記錄每個 Section 的狀態，預設false
  var isExpandedList: [Bool] = [false, false]

  var allChoreList: [Chores] = []
  
  var undoList: [Chores] = []
  
  var doingList: [Chores] = []

  override func viewDidLoad() {

    super.viewDidLoad()
    
    resetNavigationBarButton()
    
    FirebaseProvider.shared.fetchChoresData { result in
      
      switch result {
      
      case .success(let chores):

        self.allChoreList = chores
        
        self.undoList = self.allChoreList.filter { $0.owner == nil }
        
        self.doingList = self.allChoreList.filter { $0.owner != nil }
        
      case .failure(let error):
        print(error)
        
      }
      
    }

  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    _ = segue.destination as? AddChoresViewController
    
  }

  private func resetNavigationBarButton() {
    
    let backButton = UIBarButtonItem(
      image: UIImage.asset(.Icon32px_AddChores),
      style: .plain,
      target: self,
      action: #selector(tapAddButton))
    
    self.navigationItem.rightBarButtonItem = backButton
    
  }
  
  @objc func tapAddButton() {
    
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

}

extension MissionViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView,
                 heightForHeaderInSection section: Int) -> CGFloat {
    
    if section == 0 {
      
      return 300
      
    }
    
    return 160
    
  }
  
  func tableView(_ tableView: UITableView,
                 heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 110
  }
  
}

extension MissionViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView,
                 viewForHeaderInSection section: Int) -> UIView? {
    
    let header = tableView.dequeueReusableHeaderFooterView(
      withIdentifier: String(describing: SectionView.self)
    )
    
    guard let sectionView = header as? SectionView else { return header }
    
    sectionView.isExpanded = self.isExpandedList[section]
    
    sectionView.buttonTag = section
    
    sectionView.delegate = self
    
    // 調整section 0 的top constraint 跟 height
    if section == 0 {
      
      sectionView.layoutUnclaimedSection()
      
//      sectionView.sectionTitle.text = SectionTitle.unclaimed.rawValue
//
//      sectionView.cardView.translatesAutoresizingMaskIntoConstraints = false
//
//      NSLayoutConstraint.activate([
//        sectionView.cardView.topAnchor.constraint(equalTo: sectionView.topAnchor, constant: 150)
//      ])
      
    } else {
      
      sectionView.layoutOngoingSection()
      
//      sectionView.sectionTitle.text = SectionTitle.ongoing.rawValue
//
//      sectionView.cardView.translatesAutoresizingMaskIntoConstraints = false
//      
//      NSLayoutConstraint.activate([
//        sectionView.cardView.topAnchor.constraint(equalTo: sectionView.topAnchor, constant: 10)
//      ])
      
    }
    
    return sectionView
    
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    
    return isExpandedList.count
    
  }
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    
    // true 的時候會依照不同 Section 去抓要顯示幾個 Row
    if self.isExpandedList[section] {
      
      if section == 0 {
        
        return undoList.count
        
      } else {
        
        return doingList.count
        
      }

    }
    
    return 0
    
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let index = indexPath.row
    
    switch indexPath.section {
    
    case 0:
      let cell = tableView.dequeueReusableCell(
        withIdentifier: String(describing: UnclaimedCellView.self),
        for: indexPath)
      
      guard let unclaimedCell = cell as? UnclaimedCellView else { return cell }
      
      unclaimedCell.setUpCellStyle()
      
      unclaimedCell.layoutCell(chores: undoList[index])
      
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

extension MissionViewController: SectionViewDelegate {
  
  func showMoreItem(_ section: SectionView, _ didPressTag: Int, _ isExpanded: Bool) {
    
    isExpandedList[didPressTag] = !isExpanded
    
    tableView.reloadSections(IndexSet(integer: didPressTag), with: .automatic)
    
  }
  
}
