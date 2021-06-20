//
//  UnclaimedTableViewCell.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/13.
//

import UIKit

class UnclaimedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView: CardView!
    
    @IBOutlet weak var choreImage: UIImageView!
    
    @IBOutlet weak var choreItemLabel: UILabel!
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    @IBOutlet weak var acceptButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    weak var delegate: MissionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCellStyle()        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func acceptChore(_ sender: Any) {
        
        if let index = getIndexPath()?.row {
            
            self.delegate?.onButtonAccept(at: index)
        }
    }
    
    
    @IBAction func deleteChore(_ sender: Any) {
        
        if let index = getIndexPath()?.row {
            
            self.delegate?.onButtonDelete(at: index)
        }
    }
    
    func configureCellStyle() {
        
        selectionStyle = .none
        
        cardView.backgroundColor = .beigeFFF1E6
    }
    
    func layoutCell(chore: Chore) {
        
        choreItemLabel.text = chore.item
        
        pointsLabel.text = "可獲得 \(chore.points) 點"
        
        if let imageName = ChoreImages.imageNames[ChoreItem(rawValue: chore.item) ?? .customChore] {
            
            choreImage.image = UIImage(named: imageName.rawValue)
            
        } else {
            
            choreImage.image = UIImage.asset(.CustomChore)
        }
    }
}
