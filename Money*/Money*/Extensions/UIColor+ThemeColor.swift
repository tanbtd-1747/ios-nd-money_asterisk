//
//  UIColor+ThemeColor.swift
//  Money*
//
//  Created by tran.duc.tan on 3/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(aRed: CGFloat, aGreen: CGFloat, aBlue: CGFloat, alpha: CGFloat = 1) {
        self.init(red: aRed / 255, green: aGreen / 255, blue: aBlue / 255, alpha: alpha)
    }
    
    @nonobjc class var ivory: UIColor {
        return UIColor(aRed: 255, aGreen: 255, aBlue: 243)
    }
    
    @nonobjc class var khaki: UIColor {
        return UIColor(aRed: 183, aGreen: 173, aBlue: 153)
    }
    
    @nonobjc class var richBlack: UIColor {
        return UIColor(aRed: 3, aGreen: 3, aBlue: 1)
    }
    
    @nonobjc class var robinEggBlue: UIColor {
        return UIColor(aRed: 0, aGreen: 217, aBlue: 192)
    }
    
    @nonobjc class var magicPotion: UIColor {
        return UIColor(aRed: 255, aGreen: 67, aBlue: 101)
    }
}
