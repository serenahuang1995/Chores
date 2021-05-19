//
//  TagCollectionViewCell.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/15.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var choresImage: UIImageView!
  
  @IBOutlet weak var choresLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    contentView.backgroundColor = .beigeEBDDCE
    
    contentView.layer.cornerRadius = 5
    
  }
  
  // 利用 dic 的特質 取到key，就可以叫出對應的 value
  func layoutCell(tagItem: String) {
    
    choresLabel.text = tagItem
    
    // 如果有找到對應的 tagItem 就會將 item 的 value(圖片的名字)存進 imageName
    if let imageName = Chores.item[tagItem] {
      
      choresImage.image = UIImage(named: imageName)
      
    } else {
      // 如果沒有找到對應的 item，image 會改成你預設的圖片
       choresImage.image = UIImage(named: "WalkDog")
    }
  }

}
