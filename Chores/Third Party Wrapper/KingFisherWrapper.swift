//
//  KingFisherWrapper.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/6/11.
//

import Foundation
import Kingfisher

extension UIImageView {

    func loadImage(_ urlString: String?, placeHolder: UIImage? = nil) {

        guard urlString != nil else { return }
        
        let url = URL(string: urlString!)

        self.kf.setImage(with: url, placeholder: placeHolder)
    }
}
