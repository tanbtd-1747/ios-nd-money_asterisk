//
//  UInt64+.swift
//  Money*
//
//  Created by tran.duc.tan on 3/25/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import Foundation
import Then

extension UInt64 {
    func toDecimalString() -> String {
        let formatter = NumberFormatter().then {
            $0.numberStyle = .decimal
            $0.locale = Locale.current
        }
        
        return formatter.string(for: self) ?? ""
    }
}
