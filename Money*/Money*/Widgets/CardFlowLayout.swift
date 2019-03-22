//
//  CardFlowLayout.swift
//  Money*
//
//  Created by tran.duc.tan on 3/22/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

final class CardFlowLayout: UICollectionViewFlowLayout {
    let activeDistance = Constant.walletCollectionActiveDistance
    let zoomFactor = Constant.walletCollectionZoomFactor
    
    override init() {
        super.init()
        scrollDirection = .horizontal
        minimumLineSpacing = Constant.walletCollectionMinimumLineSpacing
        itemSize = CGSize(width: Constant.walletCollectionCellWidth,
                          height: Constant.walletCollectionCellHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        
        let verticalInsets = (collectionView.frame.height
            - collectionView.adjustedContentInset.top
            - collectionView.adjustedContentInset.bottom
            - itemSize.height) / 2
        let horizontalInsets = (collectionView.frame.width
            - collectionView.adjustedContentInset.left
            - collectionView.adjustedContentInset.right
            - itemSize.width) / 2
        sectionInset = UIEdgeInsets(top: verticalInsets,
                                    left: horizontalInsets,
                                    bottom: verticalInsets,
                                    right: horizontalInsets)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView,
            let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
            
        }
        
        var rectAttributes = [UICollectionViewLayoutAttributes]()
        for attribute in attributes {
            if let attribute = attribute.copy() as? UICollectionViewLayoutAttributes {
                rectAttributes.append(attribute)
            }
        }
        let visibleRect = CGRect(origin: collectionView.contentOffset,
                                 size: collectionView.frame.size)
        
        // Make the cells be zoomed when they reach the center of the screen
        for attributes in rectAttributes where attributes.frame.intersects(visibleRect) {
            let distance = visibleRect.midX - attributes.center.x
            let normalizedDistance = distance / activeDistance
            
            if distance.magnitude < activeDistance {
                let zoom = 1 + zoomFactor * (1 - normalizedDistance.magnitude)
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1)
                attributes.zIndex = Int(zoom.rounded())
            }
        }
        
        return rectAttributes
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return .zero }
        
        // Add some snapping behaviour so that the zoomed cell is always centered
        let targetRect = CGRect(x: proposedContentOffset.x,
                                y: 0,
                                width: collectionView.frame.width,
                                height: collectionView.frame.height)
        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }
        
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2
        
        for layoutAttributes in rectAttributes {
            let itemHorizontalCenter = layoutAttributes.center.x
            if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            }
        }
        
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment,
                       y: proposedContentOffset.y)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        guard let context = super.invalidationContext(forBoundsChange: newBounds)
            as? UICollectionViewFlowLayoutInvalidationContext else {
            return UICollectionViewLayoutInvalidationContext()
        }
        
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        return context
    }
}
