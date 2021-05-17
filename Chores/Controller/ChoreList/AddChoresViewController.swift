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
  
  @IBOutlet weak var backgroundView: UIView!
  
  @IBOutlet weak var customButton: UIButton!
  
  @IBOutlet weak var ruleButton: UIButton!
  
  @IBOutlet weak var timeTextField: UITextField!
  
  @IBOutlet weak var pointTextField: UITextField! {
    didSet {
      self.pointTextField.isEditing == true
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
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedCell = collectionView.cellForItem(at: indexPath)
    
    if let selectedCell = selectedCell {
      
    selectedCell.contentView.layer.borderColor = UIColor.black.cgColor
      
    selectedCell.contentView.layer.borderWidth = 2

    }
    
//    backgroundView.layer.borderWidth = 2
//
//    backgroundView.layer.borderColor = UIColor.black.cgColor
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    
//    backgroundView.layer.borderWidth = 0
//
//    backgroundView.layer.borderColor = UIColor.clear.cgColor
  }
  
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
  
//  func collectionView(_ collectionView: UICollectionView,
//                      layout collectionViewLayout: UICollectionViewLayout,
//                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//    return 10
//    
//  }
  
}

extension AddChoresViewController: UITextFieldDelegate {
  func textFieldDidChangeSelection(_ textField: UITextField) {
    pointTextField.text = timeTextField.text
  }
}
