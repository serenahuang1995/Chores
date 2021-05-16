//
//  UICollectionView+Extension.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/15.
//

import UIKit

extension UICollectionView {

    func registerCellWithNib(identifier: String, bundle: Bundle?) {

        let nib = UINib(nibName: identifier, bundle: bundle)

        register(nib, forCellWithReuseIdentifier: identifier)
    }
}
