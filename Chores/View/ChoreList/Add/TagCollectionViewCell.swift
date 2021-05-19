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
  
  // 利用 dic 的特質 取到key 就可以叫出對應的 value
  func layoutCell(tag: String) {
    
    choresLabel.text = tag
    
    if let imageName = ChoresItem.item[tag] {
      choresImage.image = UIImage(named: imageName)
    } else {
      // name會改成其他圖片
       choresImage.image = UIImage(named: "WalkDog")
    }
  }

}
