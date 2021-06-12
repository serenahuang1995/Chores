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
    
    case unclaimed = "任務認領區"
    
    case ongoing = "任務進行中"    
}

class SectionView: UITableViewHeaderFooterView {
    
    var buttonTag: Int = -1 // 存放 Section 索引的 buttonTag
    
    var isExpanded: Bool = false
    
    weak var delegate: SectionViewDelegate?
    
    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    @IBOutlet weak var showMoreItemButton: UIButton!
    
    @IBOutlet weak var cardView: CardView! {
        
        didSet {
            
            self.cardView.backgroundColor = .orangeFFDEB1
            
            self.cardView.layer.borderWidth = 2
            
            self.cardView.layer.borderColor = UIColor.black252525.cgColor
        }
    }
    
    @IBOutlet weak var cardViewTopConstraint: NSLayoutConstraint!
    
    @IBAction func pressToExpand(_ sender: Any) {
        
        self.delegate?.showMoreItem(self, buttonTag, self.isExpanded)
    }
    
    func layoutUnclaimedSection() {
        
        sectionTitleLabel.text = SectionTitle.unclaimed.rawValue
        
        cardViewTopConstraint.constant = 50 //160
        
        //    cardView.translatesAutoresizingMaskIntoConstraints = false
        //
        //    NSLayoutConstraint.activate([
        //      cardView.topAnchor.constraint(equalTo: self.topAnchor, constant: 150)
        //    ])
    }
    
    func layoutOngoingSection() {
        
        sectionTitleLabel.text = SectionTitle.ongoing.rawValue
        
        cardViewTopConstraint.constant = 10 // 20
        
        //    cardView.translatesAutoresizingMaskIntoConstraints = false
        //
        //    NSLayoutConstraint.activate([
        //      cardView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
        //    ])
    }
    
    func setExpandButtonVisible(isVisible: Bool) {
        
        showMoreItemButton.isHidden = !isVisible        
    }
    
}
