//
//  AddMemberCell.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/18.
//

import UIKit
import MIBlurPopup

class AddMemberCell: UICollectionViewCell {
  
  @IBOutlet weak var addMemberButton: UIButton!
  
  weak var delegate: AddMemberCellDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  @IBAction func toAddMember(_ sender: Any) {
    
    self.delegate?.showMemberView()

  }
  
}
