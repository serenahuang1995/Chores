//
//  TransferChoreCollectionViewCell.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/6/3.
//

import UIKit

class TransferChoreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var memberImage: UIImageView! {
        
        didSet {
            
            memberImage.layer.cornerRadius = memberImage.frame.height / 2
        }
    }
    
    @IBOutlet weak var memberNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func layoutCell(user: User) {
        
        memberImage.loadImage(user.picture, placeHolder: .asset(.user))
        
        memberNameLabel.text = user.name
    }
    
    func configureCellStyle(isSelected: Bool) {
        
        if isSelected {
            
            memberImage.layer.borderWidth = 2
            
            memberImage.layer.borderColor = UIColor.black252525.cgColor
            
        } else {
            
            memberImage.layer.borderWidth = 0
            
            memberImage.layer.borderColor = UIColor.clear.cgColor
        }
    }
}
