//
//  ChoresRecordsViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/17.
//

import UIKit



class ChoresRecordsViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView! {
    didSet {
      setUpTableView()
      tableView.delegate = self
      tableView.dataSource = self
    }
  }

  override func viewDidLoad() {
        super.viewDidLoad()

    }

  private func setUpTableView() {
    
    tableView.separatorStyle = .none

    tableView.backgroundColor = UIColor.white
    
    tableView.registerCellWithNib(
      identifier: String(describing: RecordsTableViewCell.self), bundle: nil)
    
  }
  
}

extension ChoresRecordsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
}

extension ChoresRecordsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: String(describing: RecordsTableViewCell.self),
      for: indexPath)
    guard let recordsCell = cell as? RecordsTableViewCell else { return cell }
    return recordsCell
  }
  

}
