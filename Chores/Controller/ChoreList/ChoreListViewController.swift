//
//  ChoreListViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/12.
//

import UIKit

class ChoreListViewController: UIViewController {
  
  var isExpended: Bool = true
  
  var expendedDict: [Int: Bool] = [:]

//  expendedDict[0] = false
//
//  let isExpended = expendedDict[indexPath.section]

  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.delegate = self
      tableView.dataSource = self
  }
}
  override func viewDidLoad() {
    super.viewDidLoad()

    setUpTableView()
    
  }

  private func setUpTableView() {

    tableView.registerHeaderWithNib(
      identifier: String(describing: SectionView.self), bundle: nil)

    tableView.registerCellWithNib(
      identifier: String(describing: UnclaimedCellView.self), bundle: nil)

  }
  
}

extension ChoreListViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 300
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
    sectionView.delegate = self
    return sectionView
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UnclaimedCellView.self), for: indexPath)
    guard let cardCell = cell as? UnclaimedCellView else { return cell }
    return cardCell
  }

}

extension ChoreListViewController: SectionViewDelegate {
  func showMoreItem(_ section: SectionView, _ isExpanded: Bool) {
    <#code#>
  }


}
