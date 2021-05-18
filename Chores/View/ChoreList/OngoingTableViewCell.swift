//
//  OngoingTableViewCell.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/14.
//

import UIKit

class OngoingTableViewCell: UITableViewCell {

  @IBOutlet weak var ongoingCell: UIView!

  override func awakeFromNib() {
    
    super.awakeFromNib()
    
    contentView.backgroundColor = .beigeEBDDCE
    
    setUpCellStyle()
    
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  func setUpCellStyle() {
    
    selectionStyle = .none
    
    ongoingCell.backgroundColor = .beigeEBDDCE
//    separatorInset = .zero
  }

}
