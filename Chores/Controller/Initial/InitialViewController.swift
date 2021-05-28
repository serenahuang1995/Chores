//
//  InitialViewController.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/12.
//

import UIKit

protocol CreateGroupCellDelegate: AnyObject {
    
    func goToMainPage()
}

class InitialViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        
        didSet {
            
            setUpCollectionView()
        }
    }
    
    let screenSize = UIScreen.main.bounds
    
    lazy var cardLayout: FlatCardCollectionViewLayout = {
        
        let layout = FlatCardCollectionViewLayout()
        
        layout.itemSize = CGSize(width: screenSize.width * 0.62 ,
                                 height: screenSize.height * 0.52)
        
        print(UIScreen.main.bounds)
        
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        
//        navigationController?.isNavigationBarHidden = true
//    }
    
    private func setUpCollectionView() {
        
        collectionView.registerCellWithNib(
            identifier: String(describing: CreateGroupCollectionViewCell.self), bundle: nil)
        
        collectionView.registerCellWithNib(
            identifier: String(describing: InvitedCollectionViewCell.self), bundle: nil)
        
        collectionView.delegate = self
        
        collectionView.dataSource = self
        
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.collectionViewLayout = cardLayout
        
        collectionView.bouncesZoom = true
    }
    
}

extension InitialViewController: UICollectionViewDelegate {
    
}

extension InitialViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        
        case 0:
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: CreateGroupCollectionViewCell.self),
                for: indexPath)
            
            guard let createCell = cell as? CreateGroupCollectionViewCell else { return cell }
            
            createCell.delegate = self
            
            return createCell
            
        case 1:
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: InvitedCollectionViewCell.self),
                for: indexPath)
            
            guard let invitedCell = cell as? InvitedCollectionViewCell else { return cell }
            
            return invitedCell
                      
        default:
            
            return UICollectionViewCell()
        }
    }
   
}

//extension InitialViewController: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: screenSize.width * 0.58, height: screenSize.height * 0.52)
//    }
//
//}

extension InitialViewController: CreateGroupCellDelegate {
    
    func goToMainPage() {
        
        performSegue(withIdentifier: Segue.main, sender: nil)
    }
    
}