//
//  SectionView.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/12.
//

import UIKit

protocol SectionViewDelegate: AnyObject {
  
  func showMoreItem(_ section: SectionView, _ didPressTag: Int, _ isExpanded: Bool)
  
}

class SectionView: UITableViewHeaderFooterView {
  
  var buttonTag: Int = -1 // 存放 Section 索引的 buttonTag

  var isExpanded: Bool = false

  weak var delegate: SectionViewDelegate?

  @IBOutlet weak var sectionTitle: UILabel!
  
  @IBOutlet weak var showMoreItemBtn: UIButton!
  
  @IBOutlet weak var cardView: CardView! {
    
    didSet {
      
      self.cardView.backgroundColor = .orangeFBDAA0
      
    }
    
  }

  @IBAction func pressToExpand(_ sender: Any) {
    
      self.delegate?.showMoreItem(self, buttonTag, self.isExpanded)
    
  }

}
