//
//  UserSettingViewController.swift
//  Money*
//
//  Created by tran.duc.tan on 3/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

final class UserSettingViewController: UITableViewController {
    // MARK: - IBOutlets
    @IBOutlet private var notificationTimeLabel: UILabel!
    @IBOutlet private var notificationSwitch: UISwitch!
    
    // MARK: - Private properties
    var user: User!
    var notificationTime: Date?
    var isNotificationEnabled: Bool?
    var timePicker: UIDatePicker?
    var isTimePickerHidden = true
    
    // MARK: - Private functions
    override func viewDidLoad() {
        super.viewDidLoad()
        registerUserNotification()
        loadUserSetting()
        updateNotificationSetting()
        configureSubviews()
    }
    
    private func configureSubviews() {
        tableView.backgroundView = GradientView()
        title = user.email
        
        if let isNotificationEnabled = isNotificationEnabled {
            notificationSwitch.setOn(isNotificationEnabled, animated: true)
        }
        
        if let notificationTime = notificationTime {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            notificationTimeLabel.text = formatter.string(from: notificationTime)
        }
    }
    
    private func loadUserSetting() {
        isNotificationEnabled = UserDefaults.standard.value(forKey: Identifier.keyIsNofiticationEnabled) as? Bool
        notificationTime = UserDefaults.standard.value(forKey: Identifier.keyNotificationTime) as? Date
    }
    
    private func registerUserNotification() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { [weak self] (_, error) in
            guard error == nil else {
                self?.presentErrorAlert(title: Constant.titleError, message: Constant.messageError)
                return
            }
        }
    }
    
    private func scheduleUserNotification() {
        guard let time = notificationTime else { return }
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = Constant.titleUserNotification
        content.body = Constant.bodyUserNotification
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = Calendar.current.component(.hour, from: time)
        dateComponents.minute = Calendar.current.component(.minute, from: time)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        notificationCenter.add(request, withCompletionHandler: nil)
    }
    
    private func unscheduleUserNotification() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    private func showHideTimePicker() {
        if isTimePickerHidden {
            timePicker = UIDatePicker()
            guard let timePicker = timePicker else { return }
            
            timePicker.datePickerMode = .time
            timePicker.frame = CGRect(x: 0.0,
                                      y: view.frame.height / 2 + timePicker.bounds.size.height / 2,
                                      width: view.frame.width,
                                      height: timePicker.bounds.size.height)
            timePicker.backgroundColor = .darkIvory
            
            if let time = notificationTime {
                timePicker.setDate(time, animated: true)
            }
            
            view.addSubview(timePicker)
            timePicker.addTarget(self, action: #selector(updateNotificationTimeLabel(sender:)), for: .valueChanged)
            isTimePickerHidden = false
        } else {
            guard let timePicker = timePicker else { return }
            
            timePicker.removeFromSuperview()
            isTimePickerHidden = true
        }
    }
    
    @objc private func updateNotificationTimeLabel(sender: UIDatePicker) {
        notificationTime = sender.date
        UserDefaults.standard.set(notificationTime, forKey: Identifier.keyNotificationTime)
        
        guard let time = notificationTime else { return }
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        notificationTimeLabel.text = formatter.string(from: time)
        
        updateNotificationSetting()
    }
    
    private func updateNotificationSetting() {
        guard let isNotificationEnabled = isNotificationEnabled else { return }
        
        if isNotificationEnabled {
            scheduleUserNotification()
        } else {
            unscheduleUserNotification()
        }
    }
    
    private func handleSignoutButtonTapped() {
        let onlineDoc = Firestore.firestore().document("online/\(user.uid)")
        onlineDoc.delete { [weak self] (error) in
            if error != nil {
                self?.presentErrorAlert(title: Constant.titleSignoutError, message: nil)
                return
            }
            
            do {
                try Auth.auth().signOut()
                self?.navigationController?.popToRootViewController(animated: true)
            } catch {
                self?.presentErrorAlert(title: Constant.titleSignoutError, message: nil)
            }
        }
    }
    
    private func handleChangePasswordButtonTapped() {
        // Ask for confirmation to reset password
        presentAlert(title: Constant.titleResetPassword,
                     message: String(format: Constant.messageResetPasswordConfirmation, user.email),
                     cancelButton: Constant.buttonDeny,
                     otherButtons: [Constant.buttonAllow]) { (_) in
                        // Send reset password email
                        Auth.auth().sendPasswordReset(withEmail: self.user.email) { [weak self] (error) in
                            guard let self = self else { return }
                            
                            guard let error = error as NSError? else {
                                // Reset password succeeded
                                self.presentErrorAlert(title: Constant.titleResetPassword,
                                                       message: Constant.messageResetPasswordErrorSuccessfulAuth)
                                return
                            }
                            
                            // Reset password failed
                            let errorCode = AuthErrorCode(rawValue: error.code)
                            self.handleAuthorizationError(of: errorCode)
                        }
        }
    }
    
    // MARK: - IBActions
    @IBAction func handleNotificationSwitch(_ sender: UISwitch) {
        isNotificationEnabled = sender.isOn
        UserDefaults.standard.set(isNotificationEnabled, forKey: Identifier.keyIsNofiticationEnabled)
        
        updateNotificationSetting()
    }
}

// MARK: - TableView Delegate
extension UserSettingViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case IndexPath(row: 0, section: 0):
            performSegue(withIdentifier: Identifier.segueFromUserSettingToWalletManagement, sender: nil)
        case IndexPath(row: 1, section: 0):
            showHideTimePicker()
            tableView.deselectRow(at: indexPath, animated: true)
        case IndexPath(row: 0, section: 1):
            handleChangePasswordButtonTapped()
            tableView.deselectRow(at: indexPath, animated: true)
        case IndexPath(row: 1, section: 1):
            handleSignoutButtonTapped()
        default:
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

// MARK: - Firebase Authorizable
extension UserSettingViewController: FirebaseAuthorizable {
    internal func handleAuthorizationError(of code: AuthErrorCode?) {
        guard let code = code else { return }
        
        switch code {
        case .invalidEmail:
            presentErrorAlert(title: Constant.titleLoginError,
                              message: Constant.messageErrorInvalidEmail)
        case .wrongPassword:
            presentErrorAlert(title: Constant.titleLoginError,
                              message: Constant.messageLoginErrorWrongPassword)
        case .userNotFound:
            presentErrorAlert(title: Constant.titleLoginError,
                              message: Constant.messageLoginErrorUserNotFound)
        case .userDisabled:
            presentErrorAlert(title: Constant.titleLoginError,
                              message: Constant.messageLoginErrorUserDisabled)
        case .invalidRecipientEmail:
            presentErrorAlert(title: Constant.titleResetPasswordError,
                              message: Constant.messageResetPasswordErrorInvalidRecipientEmail)
        default:
            presentErrorAlert(title: Constant.titleError,
                              message: Constant.messageError)
        }
    }
}
