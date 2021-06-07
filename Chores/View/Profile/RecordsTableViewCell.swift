//
//  RecordsTableViewCell.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/17.
//

import UIKit

class RecordsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recordView: CardView!
    
    @IBOutlet weak var choreImage: UIImageView!
    
    @IBOutlet weak var choreItem: UILabel!

    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        recordView.backgroundColor = .beigeFFF1E6
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func layoutCell(chores: [Chore]) {
        
        // chores 中的家事項目會是一樣的
        choreItem.text = "總共完成 \(chores[0].item)"
        
        countLabel.text = "\(chores.count) 次"
        
        if let imageName = ChoreImages.imageNames[chores[0].item] {
            
            choreImage.image = UIImage(named: imageName)
            
        } else {
            
            choreImage.image = UIImage.asset(.CustomChore)
        }
    }
    
}
