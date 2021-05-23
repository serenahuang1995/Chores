//
//  MissionViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/12.
//

import UIKit

protocol MissionCellDelegate: AnyObject {
  
  func clickButtonToAccept(at index: Int)
  
  func clickButtonToFinish(at index: Int)
  
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

  var allChores: [Chore] = []
  
  var unclaimedChores: [Chore] = []
  
  var ongoingChores: [Chore] = []

  override func viewDidLoad() {

    super.viewDidLoad()
    
    resetNavigationBarButton()
    
//    reload()
    listenImmediately()

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
      identifier: String(describing: UnclaimedTableViewCell.self), bundle: nil)
    
    tableView.registerCellWithNib(
      identifier: String(describing: OngoingTableViewCell.self), bundle: nil)
    
  }
  
//  func reload() {
//    FirebaseProvider.shared.fetchChoresData { result in
//
//      switch result {
//
//      case .success(let chores):
//
//        self.allChoreList = chores
//
//        self.undoList = self.allChoreList.filter { $0.owner == nil }
//
//        self.doingList = self.allChoreList.filter { $0.owner != nil }
//
//        self.tableView.reloadData()
//
//      case .failure(let error):
//
//        print(error)
//
//      }
//
//    }
//  }
  
  func listenImmediately() {
    
    FirebaseProvider.shared.listenChores { result in
      
      switch result {
      
      case .success(let chores):
        
        self.allChores = chores
        
        self.unclaimedChores = self.allChores.filter { $0.owner == nil }
        
        self.ongoingChores = self.allChores.filter { $0.owner != nil }
        
        self.tableView.reloadData()
        
      case .failure(let error):
        
        print(error)
        
      }
    }
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
      
    } else {
      
      sectionView.layoutOngoingSection()
      
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
        
        return unclaimedChores.count
        
      } else {
        
        return ongoingChores.count
        
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
        withIdentifier: String(describing: UnclaimedTableViewCell.self),
        for: indexPath)
      
      guard let unclaimedCell = cell as? UnclaimedTableViewCell else { return cell }
      
      unclaimedCell.delegate = self
      
      unclaimedCell.setUpCellStyle()
      
      unclaimedCell.layoutCell(chore: unclaimedChores[index])
      
      return unclaimedCell
      
    case 1:
      let cell = tableView.dequeueReusableCell(
        withIdentifier: String(describing: OngoingTableViewCell.self),
        for: indexPath)
      
      guard let ongoingCell = cell as? OngoingTableViewCell else { return cell }
      
      ongoingCell.delegate = self
      
      ongoingCell.setUpCellStyle()
      
      ongoingCell.layoutCell(chore: ongoingChores[index])
      
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

extension MissionViewController: MissionCellDelegate {

  func clickButtonToAccept(at index: Int) {
    
    FirebaseProvider.shared.updateOwner(selectedChore: unclaimedChores[index]) { result in
      
      switch result {
      
      case .success(let success):
        print(success)
      //        self.reload()
      
      case .failure(let error):
        print(error)
        
      }
      
    }
    
  }
  
  func clickButtonToFinish(at index: Int) {
    
    FirebaseProvider.shared.updateStatus(selectedChore: ongoingChores[index]) { result in
      
      switch result {
      
      case .success(let success):
        print(success)
      
      case .failure(let error):
        print(error)
        
      }
      
    }
  }
  
}
