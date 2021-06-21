//
//  DetailTableViewCell.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/6/14.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: CardView! {
        
        didSet {
            
            cardView.backgroundColor = .beigeFFF1E6
        }
    }
    
    @IBOutlet weak var choreImage: UIImageView!
    
    @IBOutlet weak var choreItemLabel: UILabel!
    
    @IBOutlet weak var completedTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func layoutCell(chore: Chore) {
        
        choreItemLabel.text = chore.item
        
        if let imageName = ChoreImages.imageNames[chore.item] {
            
            choreImage.image = UIImage(named: imageName.rawValue)
            
        } else {
            
            choreImage.image = UIImage.asset(.CustomChore)
        }

        guard let date = chore.completedDate?.dateValue() else { return }
        
        let completedDate = String.convertDateFormatterToString(date: date)
        
//        let dateFormatter = DateFormatter()
//
//        dateFormatter.dateFormat = "yyyy / MM / dd"
//
//        let completedDate = dateFormatter.string(from: date)
        
        completedTimeLabel.text = "完成時間：\(completedDate)"
    }
}
