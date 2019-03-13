//
//  RoundedButton.swift
//  Money*
//
//  Created by tran.duc.tan on 3/13/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 5 {
        didSet {
            setNeedsLayout()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = cornerRadius
        layer.shadowColor = Theme.Color.richBlack.cgColor
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.5
    }

}
