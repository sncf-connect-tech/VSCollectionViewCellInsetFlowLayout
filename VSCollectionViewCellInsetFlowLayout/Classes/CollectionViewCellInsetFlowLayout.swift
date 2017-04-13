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
    /**
     Asks the delegate for the margins to apply to item a the specified indexPath.
     + If flowLayout scrollDirection is **vertical**:
        - **inset.top** offsets the item vertically, **inset.bottom** offsets the next item vertically or offsets contentSize if no more cell. All next items and contentSize are also offset vertically by the specified margins.
        - **inset.left** offset the item horizontally and subtracts the value from the cell width, **inset.right** updates the width of the cell without offsets its origin. Others cells are **not** impacted by the specified margins.
     + If flowLayout scrollDirection is **horizontal**:
        - **inset.left** offsets the item horizontally, **inset.right** offsets the next item horizontally or offsets contentSize if no more cell. All next items and contentSize are also offset horizontally by the specified margins.
        - **inset.top** offset the item vertically and subtracts the value from the cell height, **inset.bottom** updates the height of the item without offsets its origin. Others items are **not** impacted by the specified margins.
     - parameter collectionView: The collection view object displaying the flow layout.
     - parameter layout: The layout object requesting the information.
     - parameter indexPath: The index path of the item.
     - Returns: The margins to apply to the item.
     */
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
                
                let insets:UIEdgeInsets = (collectionView.delegate as? CollectionViewDelegateCellInsetFlowLayout)?.collectionView?(collectionView, layout: self, insetForItemAt: indexPath) ?? UIEdgeInsets.zero
                
                // add left or top
                globalOffset.x += insets.left
                globalOffset.y += insets.top
                
                // apply offset
                switch scrollDirection {
                case .horizontal:
                    // left, right
                    itemAttributes.frame = itemAttributes.frame.offsetBy(dx: globalOffset.x, dy: 0)
                    // top, bottom
                    itemAttributes.frame = itemAttributes.frame.verticalInsetBy(top: insets.top, bottom: insets.bottom)
                    
                case .vertical:
                    // top, bottom
                    itemAttributes.frame = itemAttributes.frame.offsetBy(dx: 0, dy: globalOffset.y)
                    // left, right
                    itemAttributes.frame = itemAttributes.frame.horizontalInsetBy(left: insets.left, right: insets.right)
                }
                
                // cache attributes
                cachedItemAttributes[indexPath] = itemAttributes
                
                // add right or bottom
                globalOffset.x += insets.right
                globalOffset.y += insets.bottom
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

fileprivate extension CGRect {
    func verticalInsetBy(top:CGFloat, bottom:CGFloat) -> CGRect {
        var rect = self
        rect.origin.y += top
        rect.size.height -= bottom + top
        return rect
    }
    
    func horizontalInsetBy(left:CGFloat, right:CGFloat) -> CGRect {
        var rect = self
        rect.origin.x += left
        rect.size.width -= left + right
        return rect
    }
}
