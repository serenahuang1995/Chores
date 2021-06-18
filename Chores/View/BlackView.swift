//
//  BlackView.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/6/17.
//

import UIKit

class BlackView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureBlackView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func configureBlackView() {

        self.backgroundColor = .clear
        
        let effect = UIBlurEffect(style: .dark)
        
        let effectView = UIVisualEffectView(effect: effect)
        
        effectView.alpha = 0.6
        
        effectView.frame = self.frame
        
        self.addSubview(effectView)
    }
}
