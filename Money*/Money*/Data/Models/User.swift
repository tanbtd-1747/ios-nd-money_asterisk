//
//  User.swift
//  Money*
//
//  Created by tran.duc.tan on 3/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import Foundation
import Firebase

struct User {
    var uid: String
    var email: String
    
    init(auth user: Firebase.User) {
        uid = user.uid
        email = user.email ?? ""
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}
