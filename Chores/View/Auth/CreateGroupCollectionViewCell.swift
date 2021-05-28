//
//  CreateGroupCollectionViewCell.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/27.
//

import UIKit

class CreateGroupCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: CreateGroupCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func create(_ sender: Any) {
        
        self.delegate?.goToMainPage()
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
