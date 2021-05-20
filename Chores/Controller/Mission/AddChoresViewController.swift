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
      
    }
  }
  
  @IBOutlet weak var backgroundView: UIView!
  
  @IBOutlet weak var customButton: UIButton!
  
  @IBOutlet weak var ruleButton: UIButton!
  
  @IBOutlet weak var addChoreButton: UIButton!
  
  @IBOutlet weak var timeTextField: UITextField! {
    
    didSet {
            
      timeTextField.delegate = self
      
    }
    
  }

  @IBOutlet weak var pointResult: UITextField! {
    didSet {
          
      pointResult.delegate = self
      
    }
  }

  // 到時候每個家庭一進去 發現家事是空的 就會幫它寫進去14個
  var tagItemList: [String] = [
    "洗碗", "洗衣服", "晾衣服", "摺衣服", "燙衣服", "倒垃圾", "刷廁所", "澆花", "遛狗",
    "收納", "接送", "帶小孩", "煮飯", "買菜", "掃地", "拖地", "吸地", "吃飯"] {
    didSet {
      
      collectionView.reloadData()
      
    }
    
  }

  var owner: User? = nil
  
  var status: Int = 0
  
  var selectedIndex: Int?
  
  var time: String? = ""

  var point: String? = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()

  }
  

  
  override func viewWillAppear(_ animated: Bool) {
    
    navigationController?.isNavigationBarHidden = true
    
    tabBarController?.tabBar.isHidden = true
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    
    navigationController?.isNavigationBarHidden = false
    
    tabBarController?.tabBar.isHidden = false

  }
  
  @IBAction func backToListPage(_ sender: Any) {
    
    navigationController?.popViewController(animated: true)
    
  }
  
  @IBAction func toAddChoreItems(_ sender: Any) {
    
    guard let time = time, let point = point, let selectedIndex = selectedIndex else { return }

    var data = Chores(
      id: nil,
      item: tagItemList[selectedIndex],
      point: Int(point) ?? 0,
      hour: Int(time) ?? 0,
      owner: owner,
      status: status)
  
    FirebaseProvider.shared.addChores(data: &data) { result in
      
      switch result {
      
      case .success(let data):
      print(data)
      
      case .failure(let error):
        print(error)
      
      }
      
    }
    
  }
  
  private func setUpCollectionView() {
    
    collectionView.registerCellWithNib(
      identifier: String(describing: TagCollectionViewCell.self), bundle: nil)
    
  }

}

extension AddChoresViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
      let cell = collectionView.cellForItem(at: indexPath)
      
      guard let selectedCell = cell as? TagCollectionViewCell else { return }
      
      selectedCell.contentView.layer.borderColor = UIColor.black.cgColor
      
      selectedCell.contentView.backgroundColor = .orangeFBDAA0
      
      selectedCell.contentView.layer.borderWidth = 1
    
      selectedCell.contentView.layer.cornerRadius = 5

      selectedIndex = indexPath.row

  }

  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    
    let cell = collectionView.cellForItem(at: indexPath)
    
    guard let deSelectedCell = cell as? TagCollectionViewCell else { return }
    
    deSelectedCell.initialCell()
    
  }
  
}

extension AddChoresViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return tagItemList.count
    
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: String(describing: TagCollectionViewCell.self),
      for: indexPath)
    
    guard let tagCell = cell as? TagCollectionViewCell else { return cell }
    
    tagCell.layoutCell(tagItem: tagItemList[indexPath.row])
    
    return tagCell
  }
  
}

extension AddChoresViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    
    return 10.0

  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: 80, height: 90)
    
  }

}

extension AddChoresViewController: UITextFieldDelegate {

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
      textField.resignFirstResponder()
    
      return true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    
    time = timeTextField.text
  
    point = pointResult.text
    
  }
  func textFieldDidChangeSelection(_ textField: UITextField) {

    pointResult.text = timeTextField.text

  }
}
