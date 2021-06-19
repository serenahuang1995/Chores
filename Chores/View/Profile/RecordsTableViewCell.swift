//
//  RecordsTableViewCell.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/17.
//

import UIKit

class RecordsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView: CardView! {
        
        didSet {
            
            cardView.backgroundColor = .beigeFFF1E6
        }
    }
    
    @IBOutlet weak var choreImage: UIImageView!
    
    @IBOutlet weak var choreItemLabel: UILabel!

    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func layoutCell(chores: [Chore]) {
        
        // chores 中的家事項目會是一樣的
        choreItemLabel.text = "總共完成 \(chores[0].item)"
        
        countLabel.text = "\(chores.count)次"
        
        if let imageName = ChoreImages.imageNames[chores[0].item] {
            
            choreImage.image = UIImage(named: imageName.rawValue)
            
        } else {
            
            choreImage.image = UIImage.asset(.CustomChore)
        }
    }
}
