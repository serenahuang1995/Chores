//
//  UnclaimedTableViewCell.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/13.
//

import UIKit

class UnclaimedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: CardView!
    
    @IBOutlet weak var choreImage: UIImageView!
    
    @IBOutlet weak var choreItemLabel: UILabel!
    
    @IBOutlet weak var expectedPointsLabel: UILabel!
    
    @IBOutlet weak var acceptTaskButton: UIButton!
    
    
    @IBOutlet weak var deleteTaskButton: UIButton!
    
    weak var delegate: MissionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpCellStyle()        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func clickToAcceptTask(_ sender: Any) {
        
        if let index = getIndexPath()?.row {
            
            self.delegate?.clickButtonToAccept(at: index)
        }
    }
    
    
    @IBAction func clickToDeleteTask(_ sender: Any) {
        
        if let index = getIndexPath()?.row {
            
            self.delegate?.clickButtonToDelete(at: index)
        }
    }
    
    func setUpCellStyle() {
        
        selectionStyle = .none
        
        cellView.backgroundColor = .beigeFFF1E6
        
        cellView.layer.borderWidth = 2
        
        cellView.layer.borderColor = UIColor.black252525.cgColor
    }
    
    func layoutCell(chore: Chore) {
        
        choreItemLabel.text = chore.item
        
        expectedPointsLabel.text = "可獲得 \(chore.points) 點"
        
        if let imageName = ChoreImages.imageNames[chore.item] {
            
            choreImage.image = UIImage(named: imageName)
            
        } else {
            
            choreImage.image = UIImage.asset(.CustomChore)
        }
    }
}
