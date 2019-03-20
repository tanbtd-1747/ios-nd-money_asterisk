//
//  Wallet.swift
//  Money*
//
//  Created by tran.duc.tan on 3/19/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import Foundation
import Firebase

enum WalletType: Int, CaseIterable {
    case cash
    case creditCard
    case other
}

struct Wallet {
    let ref: DocumentReference?
    let key: String
    var name: String
    var type: WalletType
    var balance: UInt64
    
    var dictionary: [String: Any] {
        return ["name": name,
                "type": type.rawValue,
                "balance": balance]
    }
    
    init() {
        ref = nil
        key = ""
        name = ""
        type = .cash
        balance = 0
    }
    
    init(name: String, type: WalletType, balance: UInt64, key: String = "") {
        self.ref = nil
        self.key = key
        self.name = name
        self.type = type
        self.balance = balance
    }
    
    init?(snapshot: DocumentSnapshot) {
        guard let data = snapshot.data() else {
            return nil
        }
        
        guard let name = data["name"] as? String,
            let type = data["type"] as? Int,
            let balance = data["balance"] as? UInt64 else {
            return nil
        }
        
        self.ref = snapshot.reference
        self.key = snapshot.documentID
        self.name = name
        self.type = WalletType(rawValue: type) ?? .other
        self.balance = balance
    }
}
