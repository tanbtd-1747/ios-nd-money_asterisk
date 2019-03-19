//
//  UserSettingViewController.swift
//  Money*
//
//  Created by tran.duc.tan on 3/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import Firebase

final class UserSettingViewController: UITableViewController {
    // MARK: - IBOutlets
    @IBOutlet private var notificationTimeLabel: UILabel!
    @IBOutlet private var notificationSwitch: UISwitch!
    
    // MARK: - Properties
    var user: User!
    private var timePicker = UIDatePicker()
    private var isTimePickerHidden = true
    
    // MARK: - Private functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Identifier.segueFromUserSettingToWalletManagement:
            let walletManagementViewController = segue.destination as? WalletManagementViewController
            walletManagementViewController?.user = user
        default:
            return
        }
    }
    
    private func configureSubviews() {
        tableView.backgroundView = GradientView()
        title = user.email
        
        notificationSwitch.setOn(DailyNotification.shared.isNotificationEnabled, animated: true)
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        notificationTimeLabel.text = formatter.string(from: DailyNotification.shared.notificationTime)
    }
    
    private func showHideTimePicker() {
        if isTimePickerHidden {
            timePicker.datePickerMode = .time
            timePicker.frame = CGRect(x: 0.0,
                                      y: view.bounds.size.height / 2 + timePicker.frame.size.height / 2,
                                      width: view.bounds.size.width,
                                      height: timePicker.frame.size.height)
            timePicker.backgroundColor = .darkIvory
            
            timePicker.setDate(DailyNotification.shared.notificationTime, animated: true)
            
            view.addSubview(timePicker)
            timePicker.addTarget(self, action: #selector(updateNotificationTimeLabel(sender:)), for: .valueChanged)
            isTimePickerHidden = false
        } else {
            timePicker.removeFromSuperview()
            isTimePickerHidden = true
        }
    }
    
    @objc private func updateNotificationTimeLabel(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        notificationTimeLabel.text = formatter.string(from: sender.date)
        
        DailyNotification.shared.updateSetting(time: sender.date)
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
        DailyNotification.shared.updateSetting(isEnabled: sender.isOn)
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
