//
//  AddChoresViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/14.
//

import UIKit
import KRProgressHUD

protocol TagCellDelegate: AnyObject {
    
    func deleteChoreItem(at index: Int)
}

class AddChoresViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        
        didSet {
            
            setUpCollectionView()
        }
    }
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var customButton: UIButton!
    
    @IBOutlet weak var ruleButton: UIButton!
    
    @IBOutlet weak var addChoreButton: UIButton! {
        
        didSet {
            
            addChoreButton.layer.cornerRadius = 12
        }
    }
    
    @IBOutlet weak var timeTextField: UITextField! {
        
        didSet {
            
            timeTextField.delegate = self
        }
    }
    
    @IBOutlet weak var pointResultTextField: UITextField! {
        
        didSet {
            
            pointResultTextField.delegate = self
        }
    }
    
    // 到時候每個家庭一進去 發現家事是空的 就會幫它寫進去14個
    var choreTypes: [String] = [] {
        
        didSet {
            
            collectionView.reloadData()
        }
    }
    
    var status: Int = 0
    
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setChoreTypesListener()
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
    
    @IBAction func onAddChore(_ sender: Any) {
        
        guard let time = timeTextField.text,
              let point = pointResultTextField.text,
              let selectedIndex = selectedIndex else {
            
            KRProgressHUD.showError(withMessage: "資料不能是空的喲！")
            
            return
        }
        
        // 預設的 textField 不打字也會有空字串
        if time.isEmpty || point.isEmpty {
            
            KRProgressHUD.showError(withMessage: "資料不能是空的喲！")
            
            return
        }
        
        var data = Chore(
            id: "",
            item: choreTypes[selectedIndex],
            points: Int(point) ?? 0,
            hours: Int(time) ?? 0,
            owner: nil,
            status: 0,
            transfer: nil)
        
        FirebaseProvider.shared.addToDoChoreData(chore: &data) { [weak self] result in
            
            switch result {
            
            case .success(let data):
                
                print(data)
                
                KRProgressHUD.showSuccess(withMessage: "家事新增成功")
                
                self?.navigationController?.popViewController(animated: true)
                
            case .failure(let error):
                
                print(error)
                
            }
        }
    }
    
    private func setUpCollectionView() {
        
        collectionView.registerCellWithNib(
            identifier: String(describing: TagCollectionViewCell.self), bundle: nil)
        
        collectionView.delegate = self
        
        collectionView.dataSource = self
    }
    
    func setChoreTypesListener() {
        
        FirebaseProvider.shared.fetchChoreTypes { result in
            
            switch result {
            
            case .success(let choreTypes):
                
                self.choreTypes = choreTypes
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    // for future
    //  func addDefaultChoreTypes() {
    //
    //    let defaultTypes = [
    //      "洗碗", "洗衣服", "晾衣服", "摺衣服", "燙衣服", "煮飯", "買菜", "掃地", "拖地",
    //      "吸地", "倒垃圾", "刷廁所", "擦窗戶", "修繕", "澆花", "遛狗", "收納", "接送", "帶小孩"
    //    ]
    //
    //    for choreType in defaultTypes {
    //
    //      FirebaseProvider.shared.addChoreType(choreType: choreType) { result in
    //
    //        switch result {
    //
    //        case .success(let choreType):
    //          print(choreType)
    //
    //        case .failure(let error):
    //          print(error)
    //        }
    //
    //      }
    //
    //    }
    //  }
    
}

extension AddChoresViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        // 只會單純紀錄當下點到哪一個cell
        selectedIndex = indexPath.row
        
        collectionView.reloadData()
    }
}

extension AddChoresViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return choreTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = indexPath.row
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: TagCollectionViewCell.self),
            for: indexPath)
        
        guard let tagCell = cell as? TagCollectionViewCell else { return cell }
        
        tagCell.layoutCell(tagItem: choreTypes[index])
        
        // 真正儲存你點到的cell 然後去對他做事
        if index == selectedIndex {
            
            tagCell.selectedCell()
            
        } else {
            
            tagCell.initialCell()
        }
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
        
        let fullSize = UIScreen.main.bounds
        
       return CGSize(width: 80, height: 90)
        
//        return CGSize(width: fullSize.width * 0.19,
//                      height: fullSize.height * 0.1)
    }
}

extension AddChoresViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        pointResultTextField.text = timeTextField.text
    }
}
