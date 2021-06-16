//
//  Lottie.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/6/13.
//

import Foundation
import Lottie

extension AnimationView {
    
    func configureLottieView(name: String) {
        
        let animation = Animation.named(name)
        
        self.animation = animation
        
        self.play()
        
        self.loopMode = .loop
    }
}
