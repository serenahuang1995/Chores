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
        }
    }
    
    var finishedChores: [Chore] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpRecordsListener()
    }
    
    private func setUpTableView() {
        
        tableView.separatorStyle = .none
        
        tableView.backgroundColor = UIColor.white
        
        tableView.registerCellWithNib(
            identifier: String(describing: RecordsTableViewCell.self), bundle: nil)
        
        tableView.delegate = self
        
        tableView.dataSource = self      
    }
    
    func setUpRecordsListener() {
        
        FirebaseProvider.shared.listenRecords { result in
            
            switch result {
            
            case .success(let chores):
                
                self.finishedChores = chores
                
                self.tableView.reloadData()
                
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
        
        return finishedChores.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: RecordsTableViewCell.self),
            for: indexPath)
        
        guard let recordsCell = cell as? RecordsTableViewCell else { return cell }
        
        recordsCell.layoutCell(chore: finishedChores[index])
        
        return recordsCell
    }
    
}
