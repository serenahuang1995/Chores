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

extension UICollectionViewCell {
    
    static var identifier: String {
        
        return String(describing: self)
    }
    
    func getIndexPath() -> IndexPath? {
        
        guard let collectionView = superview as? UICollectionView else { return nil }
        
        let indexPath = collectionView.indexPath(for: self)
        
        return indexPath
    }

}
