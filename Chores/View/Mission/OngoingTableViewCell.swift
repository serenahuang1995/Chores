//
//  OngoingTableViewCell.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/14.
//

import UIKit

class OngoingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView: CardView!
    
    @IBOutlet weak var choreImage: UIImageView!
    
    @IBOutlet weak var choreItemLabel: UILabel!
    
    @IBOutlet weak var ownerLabel: UILabel!
    
    @IBOutlet weak var transferLabel: UILabel!
    
    @IBOutlet weak var finishButton: UIButton!
    
    @IBOutlet weak var transferButton: UIButton!
    
    weak var delegate: MissionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        transferButton.isHidden = true
        
        transferLabel.isHidden = true
        
        setUpCellStyle()        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func prepareForReuse() {
        
        transferLabel.isHidden = true
        
        transferButton.isHidden = true
    }
    
    @IBAction func finishChore(_ sender: Any) {
        
        if let index = getIndexPath()?.row {
            
            self.delegate?.onButtonFinish(at: index)
        }
    }

    @IBAction func transferChore(_ sender: Any) {
        
        if let index = getIndexPath()?.row {
            
            self.delegate?.onButtonTransfer(at: index)
        }
    }
    
    func setUpCellStyle() {
        
        selectionStyle = .none
        
        cardView.backgroundColor = .beigeFFF1E6
    }
    
    func layoutCell(chore: Chore) {
        
        ownerLabel.text = "挑戰者：\(UserProvider.shared.getUserNameById(id: chore.owner ?? "") ?? "")"
        
        // 如果 owner 是自己 才會出現轉交家事的按鈕
        if chore.owner == UserProvider.shared.uid {
            
            transferButton.isHidden = false
        }
        
        // 如果 transfer 欄位不是 nil 也不是空字串
        if chore.transfer?.isEmpty == false {
            
            transferLabel.isHidden = false
            
            transferLabel.text = "待轉交給 \(UserProvider.shared.getUserNameById(id: chore.transfer ?? "") ?? "")"
            
            transferLabel.textColor = .red
        }
        
        choreItemLabel.text = chore.item
        
        if let imageName = ChoreImages.imageNames[chore.item] {
            
            choreImage.image = UIImage(named: imageName)
            
        } else {
            
            choreImage.image = UIImage.asset(.CustomChore)
        }
    }
}
