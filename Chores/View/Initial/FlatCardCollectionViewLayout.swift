//
//  FlatCardCollectionViewLayout.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/28.
//

import UIKit

class FlatCardCollectionViewLayout: UICollectionViewFlowLayout {
    
    var inset: CGFloat = 0.0
    
    override open func prepare() {
        super.prepare()
        
        scrollDirection = .horizontal
        
        inset = (collectionView!.frame.size.width - itemSize.width) * 0.5

        sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)        
    }
    
    override open var collectionViewContentSize: CGSize {
        
        if collectionView == nil { return CGSize.zero }
        
        let itemsCount = CGFloat(collectionView!.numberOfItems(inSection: 0))
        
        let itemWidth = UIScreen.main.bounds.width * 0.62
        
        let itemHeight = UIScreen.main.bounds.height * 0.52
        
        let lineSpacing = self.minimumLineSpacing
        
        return CGSize(
            width: itemWidth * itemsCount + inset * 2 + (itemsCount - 1) * lineSpacing,
            height: itemHeight)
    }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        if collectionView == nil { return nil }
        
        // 從supser 獲取已經計算好的佈局屬性
        let attributes = super.layoutAttributesForElements(in: rect)
        
        let centerX = collectionView!.contentOffset.x + collectionView!.bounds.width / 2.0
        
        for attribute in attributes! {
            
            // cell 中心點 和 collectionView 中心點的間距
            let delta = Swift.abs(attribute.center.x - centerX)
            print("delta \(delta)")
            
            // 根據間隔距離計算縮放比例
            let scale = 1.3 - delta / collectionView!.frame.size.width
            
            // 設置縮放比例
            attribute.transform = CGAffineTransform(scaleX: scale, y: scale)            
        }
        
        return attributes
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        
        return true
    }
    
}
