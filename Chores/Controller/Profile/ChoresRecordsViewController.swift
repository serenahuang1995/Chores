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

  var finishChores: [Chore] = []
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    fetch()

    }

  private func setUpTableView() {
    
    tableView.separatorStyle = .none

    tableView.backgroundColor = UIColor.white
    
    tableView.registerCellWithNib(
      identifier: String(describing: RecordsTableViewCell.self), bundle: nil)
    
  }
  
  func fetch() {
    FirebaseProvider.shared.listenRecords { result in
      
      switch result {
      
      case .success(let chores):
        self.finishChores = chores
      case .failure(let error):
        print(error)
      }
      
    }
        
}
}

extension ChoresRecordsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
}

extension ChoresRecordsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return finishChores.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(
      withIdentifier: String(describing: RecordsTableViewCell.self),
      for: indexPath)
    
    guard let recordsCell = cell as? RecordsTableViewCell else { return cell }
    
    
    return recordsCell
  }

}
