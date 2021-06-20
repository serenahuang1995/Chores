//
//  TagCollectionViewCell.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/15.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var cardView: CardView!
    
    @IBOutlet weak var choreImage: UIImageView!
    
    @IBOutlet weak var choreTagLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    weak var delegate: TagCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func deleteChoreItem(_ sender: Any) {
        
        guard let choreType = choreTagLabel.text else { return }
        
        deleteChoreType(choreType: choreType)
    }
    
    // 利用 dic 的特質 取到key，就可以叫出對應的 value
    func layoutCell(tagItem: String) {
        
        choreTagLabel.text = tagItem
        
        // 如果有找到對應的 tagItem 就會將 item 的 value(圖片的名字)存進 imageName
        if let imageName = ChoreImages.imageNames[tagItem] {
            
            choreImage.image = UIImage(named: imageName.rawValue)
            
            editButton.isHidden = true
            
        } else {
            // 如果沒有找到對應的 item，image 會改成你預設的圖片
            choreImage.image = UIImage.asset(.CustomChore)
            
            editButton.isHidden = false
        }
    }
    
    func configureCellStyle(isSelected: Bool) {
        
        if isSelected {
            
            cardView.layer.borderColor = UIColor.black252525.cgColor
            
            cardView.backgroundColor = .beigeFFEDD9
            
            cardView.layer.borderWidth = 2

        } else {
            
            cardView.backgroundColor = .grayF2F2F2
            
            cardView.layer.borderWidth = 0
        }        
    }
    
    func deleteChoreType(choreType: String) {
        
        FirebaseProvider.shared.deleteChoreType(selectedChoreType: choreType) { result in
            
            switch result {
            
            case .success(let choreType):
                
                print(choreType)
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
}
