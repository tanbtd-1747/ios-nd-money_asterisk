//
//  UIView+RoundedShadowed.swift
//  Money*
//
//  Created by tran.duc.tan on 3/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

// MARK: - Rounded and Shadowed View
extension UIView {
    func makeRounded(radius: CGFloat = Constant.cornerRadius) {
        layer.cornerRadius = radius
    }
    
    func makeShadowed(color: UIColor, radius: CGFloat, offset: CGSize, opacity: Float) {
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
    }
    
    func makeRoundedAndShadowed(cornerRadius: CGFloat = Constant.cornerRadius,
                                shadowColor: UIColor = .richBlack,
                                shadowRadius: CGFloat = Constant.shadowRadius,
                                shadowOffset: CGSize = Constant.shadowOffset,
                                shadowOpacity: Float = Constant.shadowOpacity) {
        makeRounded(radius: cornerRadius)
        makeShadowed(color: shadowColor, radius: shadowRadius, offset: shadowOffset, opacity: shadowOpacity)
    }
}
