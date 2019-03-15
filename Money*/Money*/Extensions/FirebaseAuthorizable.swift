//
//  FirebaseAuthorizable.swift
//  Money*
//
//  Created by tran.duc.tan on 3/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol FirebaseAuthorizable {
    func handleAuthorizationError(of code: AuthErrorCode?)
}
