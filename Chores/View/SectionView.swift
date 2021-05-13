//
//  SectionView.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/12.
//

import UIKit

protocol SectionViewDelegate: AnyObject {
  func showMoreItem(_ section: SectionView, _ isExpanded: Bool)
}

class SectionView: UITableViewHeaderFooterView {
  
  var isExpanded: Bool = false
  
  weak var delegate: SectionViewDelegate?

  @IBOutlet weak var cardTitle: UILabel!
  @IBOutlet weak var showMoreItemBtn: UIButton!
  @IBOutlet weak var sectionView: CardView! {
    didSet {
      self.sectionView.backgroundColor = .blue939EB6
    }
  }

  @IBAction func pressToExpand(_ sender: Any) {
    self.delegate?.showMoreItem(self, self.isExpanded)
  }
  
//  func getIndexPath() -> IndexPath? {
//      guard let sectionView = superview as? UITableView else {
//          return nil
//      }
//    let indexPath = sectionView.indexPath.(for: <#T##UITableViewCell#>)
//      return indexPath
//  }
  
  
  
  
  
  
}
  
    
