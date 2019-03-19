//
//  DailyNotification.swift
//  Money*
//
//  Created by tran.duc.tan on 3/19/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import Foundation
import UserNotifications

class DailyNotification {
    var notificationTime = Date()
    var isNotificationEnabled = Constant.defaultIsNotificationEnabled
    
    static let shared = DailyNotification()
    
    init() {
        if let time = UserDefaults.standard.value(forKey: Identifier.keyNotificationTime) as? Date {
            notificationTime = time
        } else {
            var dateComponents = DateComponents()
            dateComponents.hour = Constant.defaultNotificationHour
            dateComponents.minute = Constant.defaultNotificationMinute
            if let time = Calendar.current.date(from: dateComponents) {
                notificationTime = time
            }
        }
        
        if let isEnabled = UserDefaults.standard.value(forKey: Identifier.keyIsNofiticationEnabled) as? Bool {
            isNotificationEnabled = isEnabled
        }
        
        updateNotificationSchedule()
    }
    
    func register() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (_, error) in
            guard error == nil else {
                print("Error")
                return
            }
        }
    }
    
    private func schedule() {
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = Constant.titleUserNotification
        content.body = Constant.bodyUserNotification
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = Calendar.current.component(.hour, from: notificationTime)
        dateComponents.minute = Calendar.current.component(.minute, from: notificationTime)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        notificationCenter.add(request, withCompletionHandler: nil)
    }
    
    private func unschedule() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    private func updateNotificationSchedule() {
        unschedule()
        if isNotificationEnabled {
            schedule()
        }
    }
    
    func updateSetting(isEnabled: Bool) {
        isNotificationEnabled = isEnabled
        UserDefaults.standard.set(isNotificationEnabled, forKey: Identifier.keyIsNofiticationEnabled)
        updateNotificationSchedule()
    }
    
    func updateSetting(time: Date) {
        notificationTime = time
        UserDefaults.standard.set(notificationTime, forKey: Identifier.keyNotificationTime)
        updateNotificationSchedule()
    }
}
