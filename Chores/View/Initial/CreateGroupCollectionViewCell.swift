//
//  CreateGroupCollectionViewCell.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/27.
//

import UIKit
import Lottie

class CreateGroupCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var animationView: AnimationView!
    
    weak var delegate: CreateGroupDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        animationView.configureLottieView(name: Lottie.signin)
    }

    @IBAction func create(_ sender: Any) {
        
        self.delegate?.navigateMainPage()
        
//        createNewGroup()
    }
    
    func createNewGroup() {
        
        UserProvider.shared.createGroup { [weak self] result in
            
            switch result {
            
            case .success(let group):
                
                print(group)
                
                self?.updateGroupId(groupId: group.id)

            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func updateGroupId(groupId: String) {
        
        UserProvider.shared.updateGroupId(groupId: groupId) { [weak self] result in
            
            switch result {
            
            case .success(let success):
                
                print(success)
                
                let userDefault = UserDefaults()
                
                userDefault.setValue(groupId, forKey: "GroupID")
                
                self?.delegate?.navigateMainPage()
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
}
