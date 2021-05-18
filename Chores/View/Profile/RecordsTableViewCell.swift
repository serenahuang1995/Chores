//
//  RecordsTableViewCell.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/17.
//

import UIKit

class RecordsTableViewCell: UITableViewCell {

  @IBOutlet weak var recordView: CardView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
    
    recordView.backgroundColor = .beigeEBDDCE
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
