//
//  Timestamp+.swift
//  Money*
//
//  Created by tran.duc.tan on 3/25/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import Foundation
import Firebase

extension Timestamp {
    func toDateString() -> String {
        let dateFormatter = DateFormatter().then {
            $0.dateStyle = .short
            $0.timeStyle = .short
            $0.locale = Locale.current
        }
        
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(self.seconds)))
    }
}
