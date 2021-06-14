//
//  MemberCollectionViewCell.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/17.
//

import UIKit

class MemberCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var memberImage: UIImageView! {
        
        didSet {
            
            memberImage.layer.cornerRadius = memberImage.frame.height / 2
        }
    }

    @IBOutlet weak var medalImage: UIImageView!
    
    @IBOutlet weak var memberNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func layoutCell(user: User) {
        
        memberImage.loadImage(user.picture, placeHolder: .asset(.user))
        
        memberNameLabel.text = user.name

        medalImage.isHidden = !(user.isSpend ?? false)
    }
}
