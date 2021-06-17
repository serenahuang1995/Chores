//
//  BlackView.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/6/17.
//

import UIKit

class BlackView: UIView {
    
    func configureBlackView() {
        
//        let blackView = UIView(frame: UIScreen.main.bounds)
        
        self.backgroundColor = .clear
        
        let effect = UIBlurEffect(style: .dark)
        
        let effectView = UIVisualEffectView(effect: effect)
        
        effectView.alpha = 0.6
        
        effectView.frame = self.frame
        
        self.addSubview(effectView)
    }
}
