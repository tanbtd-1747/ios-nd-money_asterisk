//
//  AppDelegate.swift
//  Money*
//
//  Created by tran.duc.tan on 3/13/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureFirebase()
        registerUserNotification()
        return true
    }
    
    private func configureFirebase() {
        FirebaseApp.configure()
    }
    
    private func registerUserNotification() {
        DailyNotification.shared.register()
    }
}
