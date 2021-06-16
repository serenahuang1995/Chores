//
//  TransferChoreViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/6/3.
//

import UIKit
import MIBlurPopup
import KRProgressHUD

class TransferChoreViewController: UIViewController {
      
    @IBOutlet weak var collectionView: UICollectionView! {
        
        didSet {
            
            setUpCollectionView()
        }
    }
    
    @IBOutlet weak var popView: CardView!
    
    var selectedIndex: Int?
    
    var transferChore: Chore?
    
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchGroupMember()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        dismiss(animated: false, completion: nil)
    }

    @IBAction func sureToForwardChore(_ sender: Any) {
        
        guard let selectedIndex = selectedIndex,
              let forwardChore = transferChore else {
            
            KRProgressHUD.showError(withMessage: "請選擇你想轉交的對象")
            
            return
        }
        
        if UserProvider.shared.user.points < 15 {
            
            KRProgressHUD.showError(withMessage: "點數不足無法轉交家事")
            
            return
        }
        
        transferChoreToGroupMember(user: users[selectedIndex], chore: forwardChore)
        
    }
    
    @IBAction func backToMissionPage(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    private func setUpCollectionView() {

        collectionView.registerCellWithNib(
            identifier: String(describing: TransferChoreCollectionViewCell.self),
            bundle: nil)
        
        collectionView.delegate = self
        
        collectionView.dataSource = self
        
        collectionView.showsHorizontalScrollIndicator = false
    }

    func fetchGroupMember() {
        
        UserProvider.shared.fetchGroupMember { result in
            
            switch result {
            
            case .success(let users):
                
                print(users)
                
                // 轉交對象不會有自已 所以要把自己排除
                self.users = users.filter { UserProvider.shared.uid != $0.id }
                
                self.collectionView.reloadData()
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func transferChoreToGroupMember(user: User, chore: Chore) {
        
        FirebaseProvider.shared.updateTransferUser(user: user, selectedChore: chore) { [weak self] result in
            
            switch result {
            
            case .success(let success):
                
                print(success)
                
                self?.dismiss(animated: true, completion: nil)
                
                KRProgressHUD.showSuccess(withMessage: "轉讓請求已送出，靜候佳音")
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
}

extension TransferChoreViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

        selectedIndex = indexPath.row
        
        collectionView.reloadData()
    }
}

extension TransferChoreViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: TransferChoreCollectionViewCell.self),
            for: indexPath)
        
        guard let forwardCell = cell as? TransferChoreCollectionViewCell else { return cell }
        
        forwardCell.layoutCell(user: users[index])
        
        if index == selectedIndex {
            
            forwardCell.configureCellStyle(borderWidth: 2.0, borderColor: UIColor.black252525.cgColor)
            
        } else {
            
            forwardCell.configureCellStyle(borderWidth: 0.0, borderColor: UIColor.clear.cgColor)
        }
        
        return forwardCell
    }
}

extension TransferChoreViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        let fullSize = UIScreen.main.bounds
//        
//        return CGSize(width: fullSize.width * 0.16, height: fullSize.height * 0.1)

        return CGSize(width: 70.0, height: 90.0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10.0
    }
}

extension TransferChoreViewController: MIBlurPopupDelegate {
    
    var popupView: UIView {
        
        popView
    }
    
    var blurEffectStyle: UIBlurEffect.Style? {
        
        .dark
    }
    
    var initialScaleAmmount: CGFloat {
        
        0.0
    }
    
    var animationDuration: TimeInterval {
        
        0.2
    }    
}
