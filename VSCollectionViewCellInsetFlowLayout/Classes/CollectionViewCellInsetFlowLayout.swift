//
//  CollectionViewCellInsetFlowLayout.swift
//  Pods
//
//  Created by Guihal Gwenn on 07/04/17.
//
//

import UIKit
import Foundation

@objc public protocol CollectionViewDelegateCellInsetFlowLayout : UICollectionViewDelegateFlowLayout {
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForItemAt indexPath: IndexPath) -> UIEdgeInsets
}

public class VSCollectionViewCellInsetFlowLayout: UICollectionViewFlowLayout {
    
    fileprivate var cachedItemAttributes = [IndexPath:UICollectionViewLayoutAttributes]()
    fileprivate var globalOffset = CGPoint()
    var contentSize = CGSize()
    
    override open func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else {
            return
        }
        
        // reset
        globalOffset = CGPoint()
        cachedItemAttributes.removeAll()
        
        // compute
        let sectionsCount = collectionView.numberOfSections
        for sectionIndex in 0..<sectionsCount {
            let itemsCount = collectionView.numberOfItems(inSection: sectionIndex)
            for itemIndex in 0..<itemsCount {
                let indexPath = IndexPath(item: itemIndex, section: sectionIndex)
                
                guard let itemAttributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes else {
                    continue
                }
                
                let insets:UIEdgeInsets? = (collectionView.delegate as? CollectionViewDelegateCellInsetFlowLayout)?.collectionView?(collectionView, layout: self, insetForItemAt: indexPath)
                
                // add left or top
                if let insets = insets  {
                    globalOffset.x += insets.left
                    globalOffset.y += insets.top
                }
                
                // apply offset
                switch scrollDirection {
                case .horizontal:
                    itemAttributes.frame = itemAttributes.frame.offsetBy(dx: globalOffset.x, dy: 0)
                case .vertical:
                    itemAttributes.frame = itemAttributes.frame.offsetBy(dx: 0, dy: globalOffset.y)
                }
                
                // cache attributes
                cachedItemAttributes[indexPath] = itemAttributes
                
                // add right or bottom
                if let insets = insets  {
                    globalOffset.x += insets.right
                    globalOffset.y += insets.bottom
                }
            }
        }
        
        // content Size
        contentSize = super.collectionViewContentSize
        switch scrollDirection {
        case .horizontal:
            contentSize.width += globalOffset.x
        case .vertical:
            contentSize.height += globalOffset.y
        }

    }
    
    public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cachedItemAttributes[indexPath]
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cachedItemAttributes.values.filter { rect.intersects($0.frame) }
    }
    
    public override var collectionViewContentSize: CGSize {
        return contentSize
    }
}
