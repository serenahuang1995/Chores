//
//  CreateGroupCollectionViewCell.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/27.
//

import UIKit
import Lottie

class CreateGroupCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var groupView: AnimationView!
    
    weak var delegate: CreateGroupCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpLottie()
    }

    @IBAction func create(_ sender: Any) {
        
        self.delegate?.goToMainPage()
        
//        createNewGroup()
    }
    
    func setUpLottie() {
        
        let animation = Animation.named("House")
        
        groupView.animation = animation
        
        groupView.play()
        
        groupView.loopMode = .loop
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
                
                self?.delegate?.goToMainPage()
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
}
