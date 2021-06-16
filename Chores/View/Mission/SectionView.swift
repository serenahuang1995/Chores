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

enum SectionTitle: String {
    
    case unclaimed = "任務認領區"
    
    case ongoing = "任務進行中"
}

class SectionView: UITableViewHeaderFooterView {
    
    var buttonTag: Int = -1 // 存放 Section 索引的 buttonTag
    
    var isExpanded: Bool = false
    
    weak var delegate: SectionViewDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var expandButton: UIButton!
    
    @IBOutlet weak var cardView: CardView! {
        
        didSet {
            
            self.cardView.backgroundColor = .orangeFFDEB1
        }
    }
    
    @IBOutlet weak var cardViewTopConstraint: NSLayoutConstraint!
    
    @IBAction func expand(_ sender: Any) {
        
        self.delegate?.showMoreItem(self, buttonTag, self.isExpanded)
    }
    
    func layoutSection(section: SectionTitle) {
        
        switch section {
        
        case .unclaimed:
            
            cardViewTopConstraint.constant = 50.0

        case .ongoing:
            
            cardViewTopConstraint.constant = 10.0
        }
        
        titleLabel.text = section.rawValue
        
        if isExpanded {
            
            // 按鈕鏡像翻轉
            expandButton.transform = CGAffineTransform(scaleX: 1, y: -1)
        }
    }
    
    func setExpandButtonVisible(isVisible: Bool) {
        
        expandButton.isHidden = !isVisible        
    }
}
