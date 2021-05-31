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
    }
    
    func setUpLottie() {
        
        let animation = Animation.named("CreateGroup")
        
        groupView.animation = animation
        
        groupView.play()
        
        groupView.loopMode = .loop

    }
    
    func createNewGroup() {
        
        UserProvider.shared.createGroup { result in
            
            switch result {
            
            case .success(let group):
                
                print(group)
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
}
