//
//  UIView+RoundedShadowed.swift
//  Money*
//
//  Created by tran.duc.tan on 3/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

extension UIView {
    func makeRounded(radius: CGFloat) {
        layer.cornerRadius = radius
    }
    
    func makeShadowed(color: UIColor, radius: CGFloat, offset: CGSize, opacity: Float) {
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
    }
    
    func makeRoundedAndShadowed(cornerRadius: CGFloat,
                                shadowColor: UIColor,
                                shadowRadius: CGFloat,
                                shadowOffset: CGSize,
                                shadowOpacity: Float) {
        makeRounded(radius: cornerRadius)
        makeShadowed(color: shadowColor, radius: shadowRadius, offset: shadowOffset, opacity: shadowOpacity)
    }
}
