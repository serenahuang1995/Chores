//
//  OngoingTableViewCell.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/14.
//

import UIKit

class OngoingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ongoingCell: CardView!
    
    @IBOutlet weak var choreImage: UIImageView!
    
    @IBOutlet weak var choreItemLabel: UILabel!
    
    @IBOutlet weak var ownerLabel: UILabel!
    
    @IBOutlet weak var finishTaskButton: UIButton!
    
    @IBOutlet weak var changeOwnerButton: UIButton!
    
    weak var delegate: MissionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ongoingCell.backgroundColor = .beigeEBDDCE
        
        setUpCellStyle()        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func clickToFinishChore(_ sender: Any) {
        
        if let index = getIndexPath()?.row {
            
            self.delegate?.clickButtonToFinish(at: index)
        }
    }
    
    
    @IBAction func clickToForwardChore(_ sender: Any) {
        
        if let index = getIndexPath()?.row {
            
            self.delegate?.clickButtonToForward(at: index)
        }
    }
    
    func setUpCellStyle() {
        
        selectionStyle = .none
        
        ongoingCell.backgroundColor = .beigeEBDDCE
    }
    
    func layoutCell(chore: Chore) {
        
        ownerLabel.text = chore.owner
        
        choreItemLabel.text = chore.item
        
        if let imageName = ChoreImages.imageNames[chore.item] {
            
            choreImage.image = UIImage(named: imageName)
            
        } else {
            
            choreImage.image = UIImage.asset(.CustomChore)
        }
    }
    
}
