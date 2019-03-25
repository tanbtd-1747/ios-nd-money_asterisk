//
//  Transaction.swift
//  Money*
//
//  Created by tran.duc.tan on 3/25/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import Foundation
import Firebase

enum TransactionType: String, CaseIterable {
    case exRestaurant = "expense-restaurant"
    case exCoffee = "expense-coffee"
    case exBill = "expense-bill"
    case exShopping = "expense-shopping"
    case exTransport = "expense-transport"
    case exEducation = "expense-education"
    case exEntertainment = "expense-entertainment"
    case exGift = "expense-gift"
    case exTravel = "expense-travel"
    case exHealth = "expense-health"
    case exInsurance = "expense-insurance"
    case exPet = "expense-pet"
    case exInvestment = "expense-investment"
    case exExchange = "expense-exchange"
    case exOther = "expense-other"
    case inSalary = "income-salary"
    case inBonus = "income-bonus"
    case inProfit = "income-profit"
    case inSale = "income-sale"
    case inTake = "income-take"
    case inExchange = "income-exchange"
    case inOther = "income-other"
    case update = "update"
}

struct Transaction {
    let ref: DocumentReference?
    let key: String
    var name: String
    var type: TransactionType
    var amount: UInt64
    var timestamp: Timestamp
    var note: String
    
    var dictionary: [String: Any] {
        return ["name": name,
                "type": type.rawValue,
                "amount": amount,
                "timestamp": timestamp,
                "note": note]
    }
    
    init() {
        ref = nil
        key = ""
        name = ""
        type = .update
        amount = 0
        timestamp = Timestamp(date: Date())
        note = ""
    }
    
    init?(snapshot: DocumentSnapshot) {
        guard let data = snapshot.data() else {
            return nil
        }
        
        guard let name = data["name"] as? String,
            let type = data["type"] as? String,
            let amount = data["amount"] as? UInt64,
            let timestamp = data["timestamp"] as? Timestamp,
            let note = data["note"] as? String else {
                return nil
        }
        
        self.ref = snapshot.reference
        self.key = snapshot.documentID
        self.name = name
        self.type = TransactionType(rawValue: type) ?? .update
        self.amount = amount
        self.timestamp = timestamp
        self.note = note
    }
}
