//
//  TagCollectionViewCell.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/15.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var choreImage: UIImageView!
  
  @IBOutlet weak var choreTagLabel: UILabel!
  
  @IBOutlet weak var editButton: UIButton!
  
  weak var delegate: TagCellDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    editButton.isHidden = true

  }
  
  
  @IBAction func toEditChoreItem(_ sender: Any) {
    
    if let index = getIndexPath()?.row {
      
      self.delegate?.deleteChoreItem(at: index)
      
    }
    
    print("yayayaya你按到了")
  }
  
  // 利用 dic 的特質 取到key，就可以叫出對應的 value
  func layoutCell(tagItem: String) {
    
    choreTagLabel.text = tagItem
    
    // 如果有找到對應的 tagItem 就會將 item 的 value(圖片的名字)存進 imageName
    if let imageName = ChoreImages.imageNames[tagItem] {
      
      choreImage.image = UIImage(named: imageName)
      
      editButton.isHidden = true
      
    } else {
      // 如果沒有找到對應的 item，image 會改成你預設的圖片
      choreImage.image = UIImage.asset(.CustomChore)
      
      editButton.isHidden = false
    }
  }
  
  func initialCell() {
    
    contentView.backgroundColor = .beigeEBDDCE
    
    contentView.layer.borderWidth = 0
    
    contentView.layer.cornerRadius = 5
  }
  
  func selectedCell() {
    
    contentView.layer.borderColor = UIColor.black.cgColor

    contentView.backgroundColor = .orangeFBDAA0

    contentView.layer.borderWidth = 1

    contentView.layer.cornerRadius = 5
    
  }

}
