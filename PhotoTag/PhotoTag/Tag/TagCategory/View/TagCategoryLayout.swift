//
//  TagCategoryLayout.swift
//  PhotoTag
//
//  Created by Keunna Lee on 2020/12/17.
//

import UIKit

protocol TagCategoryLayoutDelegate: class {
  func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}

class TagCategoryLayout: UICollectionViewLayout {
    
    // MARK: - Properties
    weak var delegate: TagCategoryLayoutDelegate?
    private let numberOfColumns = 2
    private let cellPadding: CGFloat = 6
    private var attributesCache: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0
    private let defaultContentHeight: CGFloat = 180
    private var contentWidth: CGFloat {
      guard let collectionView = collectionView else {
        return 0
      }
      let insets = collectionView.contentInset
      return collectionView.bounds.width - (insets.left + insets.right)
    }
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    // MARK: - Functions
    // Whenever a layout operation is about to take place, UIKit calls prepare() function. In here, prepare and perform any calculations required to determine the collection view’s size and the positions of the items.
    override func prepare() {
        guard attributesCache.isEmpty, let collectionView = collectionView else { return }
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset: [CGFloat] = []
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let photoHeight = delegate?.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath) ?? defaultContentHeight
            let height = cellPadding * 2 + photoHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath) // set the frame for each item
            attributes.frame = insetFrame
            attributesCache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
        
    }
    
    // Collection view calls this function after prepare() to determine which items are visible in the given rectangle. It return the layout attributes for all items insdie the given rectangle.
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        for attributes in attributesCache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    // This function returns the layout attributes for the item at the requested indexPath. It provides on demand layout information to the collection view.
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributesCache[indexPath.item]
    }
}
