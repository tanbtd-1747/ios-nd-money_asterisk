//
//  Identifier.swift
//  Money*
//
//  Created by tran.duc.tan on 3/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import Foundation

struct Identifier {
    static let segueFromLoginToDashboard = "FromLoginToDashboard"
    static let segueFromLoginToSignup = "FromLoginToSignup"
    static let segueFromDashboardToUserSetting = "FromDashboardToUserSetting"
    static let segueFromUserSettingToWalletManagement = "FromUserSettingToWalletManagement"
    static let segueFromWalletManagementToAddWallet = "FromWalletManagementToAddWallet"
    static let segueFromWalletManagementToEditWallet = "FromWalletManagementToEditWallet"
    static let segueFromAddWalletToWalletType = "FromAddWalletToWalletType"
    static let segueFromEditWalletToWalletType = "FromEditWalletToWalletType"
    static let segueUnwindToAddWallet = "UnwindToAddWallet"
    static let segueUnwindToEditWallet = "UnwindToEditWallet"
    static let segueUnwindToWalletManagement = "UnwindToWalletManagement"
    
    static let keyIsNofiticationEnabled = "KeyIsNotificationEnabled"
    static let keyNotificationTime = "KeyNotificationTime"
    
    static let cellWallet = "WalletCell"
    static let cellWalletType = "WalletTypeCell"
}
