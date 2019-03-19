//
//  Wallet.swift
//  Money*
//
//  Created by tran.duc.tan on 3/19/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import Foundation

enum WalletType {
    case cash
    case creditCard
    case other
}

struct Wallet {
    var name: String
    var type: WalletType
    var balance: UInt64
    
    init(name: String, type: WalletType, balance: UInt64) {
        self.name = name
        self.type = type
        self.balance = balance
    }
}
