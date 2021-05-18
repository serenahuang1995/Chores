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
      
      setUpCollectionView()
      
      collectionView.delegate = self
      
      collectionView.dataSource = self
      
      collectionView.reloadData()
      
    }
  }
  
  @IBOutlet weak var backgroundView: UIView!
  
  @IBOutlet weak var customButton: UIButton!
  
  @IBOutlet weak var ruleButton: UIButton!
  
  @IBOutlet weak var timeTextField: UITextField! {

    didSet {

      timeTextField.delegate = self
   
    }

  }
  
  @IBOutlet weak var pointTextField: UITextField! {
    
    didSet {
      
      pointTextField.delegate = self
      
    }
    
  }
  
//  var data: Data = [:]

  override func viewDidLoad() {
    super.viewDidLoad()

  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    navigationController?.isNavigationBarHidden = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    
    navigationController?.isNavigationBarHidden = false
  }
  
  @IBAction func backToListPage(_ sender: Any) {
    
    navigationController?.popViewController(animated: true)
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
      
      selectedCell.contentView.backgroundColor = .orangeFBDAA0
      
      selectedCell.contentView.layer.borderWidth = 2

    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    
    let deSelectedCell = collectionView.cellForItem(at: indexPath)
    
    if let deSelectedCell = deSelectedCell {
    
      deSelectedCell.contentView.backgroundColor = .beigeEBDDCE
      
      deSelectedCell.contentView.layer.borderWidth = 0

    }
    
  }
  
}

extension AddChoresViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return 14
    
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
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 70, height: 70)
  }

}

extension AddChoresViewController: UITextFieldDelegate {

//  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//    pointTextField.isEditing
//    return false
//
//  }
  
  func textFieldDidChangeSelection(_ textField: UITextField) {

    pointTextField.text = timeTextField.text

  }
}
