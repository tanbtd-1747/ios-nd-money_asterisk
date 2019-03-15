//
//  AccountValidator.swift
//  Money*
//
//  Created by tran.duc.tan on 3/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import Foundation

struct AccountValidator {
    static func validateNotEmpty(_ text: String) -> Bool {
        return !text.isEmpty
    }
    
    static func validatePasswordLength(_ password: String) -> Bool {
        return password.count >= Constant.minPasswordLength
    }
    
    static func validatePasswordMatch(_ confirmPassword: String, _ password: String) -> Bool {
        return confirmPassword == password
    }
}
