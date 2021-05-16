//
//  AddChoresViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/14.
//

import UIKit

class AddChoresViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView! {
    didSet {
      collectionView.delegate = self
      collectionView.dataSource = self
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .orangeFBDAA0
    
    setUpCollectionView()
  }
  
  private func setUpCollectionView() {
    collectionView.registerCellWithNib(
      identifier: String(describing: TagCollectionViewCell.self), bundle: nil)
  }

}

extension AddChoresViewController: UICollectionViewDelegate {
  
}

extension AddChoresViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 30
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: String(describing: TagCollectionViewCell.self),
      for: indexPath)
    guard let tagCell = cell as? TagCollectionViewCell else { return cell }
    return tagCell
  }
  
}

extension AddChoresViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 10
  }
  
}
