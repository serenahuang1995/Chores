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
        
        memberImage.loadImage(user.picture)
        
        memberNameLabel.text = user.name
    }
    
    func selectedCell() {
        
        memberImage.layer.borderWidth = 2
        
        memberImage.layer.borderColor = UIColor.black252525.cgColor
        
//        memberImage.frame = memberImage.frame.insetBy(dx: -2, dy: -2)
        
//        memberImage.layer.borderColor = UIColor(red: 39 / 255,
//                                                green: 125 / 255,
//                                                blue: 161 / 255,
//                                                alpha: 1.0).cgColor
    }
    
    func initialCell() {
        
        memberImage.layer.borderWidth = 0

        memberImage.layer.borderColor = UIColor.clear.cgColor
    }
}
