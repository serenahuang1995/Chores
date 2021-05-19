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
  
  // 到時候每個家庭一進去 發現家事是空的 就會幫它寫進去14個
  var tags: [String] = ["洗碗",
                        "洗衣服",
                        "晾衣服",
                        "摺衣服",
                        "燙衣服",
                        "倒垃圾",
                        "刷廁所",
                        "澆花",
                        "遛狗",
                        "收納",
                        "接送",
                        "帶小孩",
                        "煮飯",
                        "買菜",
                        "掃地",
                        "拖地",
                        "吸地",
                        "吃飯",
                        ">///<"]
  
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
    
    return tags.count
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: String(describing: TagCollectionViewCell.self),
      for: indexPath)
    
    guard let tagCell = cell as? TagCollectionViewCell else { return cell }
    
    tagCell.layoutCell(tag: tags[indexPath.row])
    
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
