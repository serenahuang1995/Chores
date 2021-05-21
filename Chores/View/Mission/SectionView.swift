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

private enum SectionTitle: String {

  case unclaimed = "待接受任務"
  
  case ongoing = "任務現正進行中"
  
}

class SectionView: UITableViewHeaderFooterView {
  
  var buttonTag: Int = -1 // 存放 Section 索引的 buttonTag

  var isExpanded: Bool = false

  weak var delegate: SectionViewDelegate?

  @IBOutlet weak var sectionTitleLabel: UILabel!
  
  @IBOutlet weak var showMoreItemButton: UIButton!
  
  @IBOutlet weak var cardView: CardView! {
    
    didSet {
      
      self.cardView.backgroundColor = .orangeFBDAA0
      
    }
    
  }

  @IBAction func pressToExpand(_ sender: Any) {
    
      self.delegate?.showMoreItem(self, buttonTag, self.isExpanded)
    
  }
  
  func layoutUnclaimedSection() {
    
    sectionTitleLabel.text = SectionTitle.unclaimed.rawValue
    
    cardView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      cardView.topAnchor.constraint(equalTo: self.topAnchor, constant: 150)
    ])

  }

  func layoutOngoingSection() {
    
    sectionTitleLabel.text = SectionTitle.ongoing.rawValue

    cardView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      cardView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
    ])

  }

}
