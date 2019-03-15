//
//  LoginViewController.swift
//  Money*
//
//  Created by tran.duc.tan on 3/13/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import FirebaseAuth

final class LoginViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private var emailContainerView: UIView!
    @IBOutlet private var passwordContainerView: UIView!
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var loginButton: UIButton!
    @IBOutlet private var signupButton: UIButton!
    
    // MARK: - Private functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureHideKeyboardWhenTappedOnBackground()
        addAuthorizationListener()
    }
    
    private func configureSubviews() {
        [emailContainerView,
         passwordContainerView].forEach { $0?.makeRounded() }
        
        [loginButton,
         signupButton].forEach { $0?.makeRoundedAndShadowed() }
    }
    
    private func addAuthorizationListener() {
        Auth.auth().addStateDidChangeListener { [weak self] (_, user) in
            guard let self = self else { return }
            
            if user != nil {
                self.performSegue(withIdentifier: Identifier.segueFromLoginToDashboard, sender: nil)
                self.emailTextField.text = nil
                self.passwordTextField.text = nil
            }
        }
    }
    
    private func handleAuthorizationError(of code: AuthErrorCode?) {
        guard let code = code else { return }
        
        switch code {
        case .invalidEmail:
            presentErrorAlert(title: StringConstant.titleLoginError,
                              message: StringConstant.messageLoginErrorInvalidEmail)
        case .wrongPassword:
            presentErrorAlert(title: StringConstant.titleLoginError,
                              message: StringConstant.messageLoginErrorWrongPassword)
        case .userNotFound:
            presentErrorAlert(title: StringConstant.titleLoginError,
                              message: StringConstant.messageLoginErrorUserNotFound)
        case .userDisabled:
            presentErrorAlert(title: StringConstant.titleLoginError,
                              message: StringConstant.messageLoginErrorUserDisabled)
        case .invalidRecipientEmail:
            presentErrorAlert(title: StringConstant.titleResetPasswordError,
                              message: StringConstant.messageResetPasswordErrorInvalidRecipientEmail)
        default:
            presentErrorAlert(title: StringConstant.titleError,
                              message: StringConstant.messageError)
        }
    }

    // MARK: - IBActions
    @IBAction private func onLoginButtonTouchUpInside(_ sender: Any) {
        // Check if email or password is empty
        guard let userEmail = emailTextField.text,
            let userPassword = passwordTextField.text,
            !userEmail.isEmpty,
            userPassword.count >= .minPasswordLength else {
            presentErrorAlert(title: StringConstant.titleLoginError,
                              message: StringConstant.messageLoginErrorEmptyField)
            return
        }
        
        // Firebase Auth sign in
        Auth.auth().signIn(withEmail: userEmail,
                           password: userPassword) { [weak self] (_, error) in
            guard let self = self else { return }
            
            //Sign in failed
            if let error = error as NSError? {
                let errorCode = AuthErrorCode(rawValue: error.code)
                self.handleAuthorizationError(of: errorCode)
            }
        }
    }
    
    @IBAction private func onSignupButtonTouchUpInside(_ sender: Any) {
        performSegue(withIdentifier: Identifier.segueFromLoginToSignup, sender: nil)
    }
    
    @IBAction private func onForgotPasswordButtonTouchUpInside(_ sender: Any) {
        // Check if email is empty
        guard let userEmail = emailTextField.text,
            !userEmail.isEmpty else {
            presentErrorAlert(title: StringConstant.titleResetPasswordError,
                              message: StringConstant.messageResetPasswordErrorEmptyField)
            return
        }
        
        // Ask for confirmation to reset password
        presentAlert(title: StringConstant.titleResetPassword,
                     message: String(format: StringConstant.messageResetPasswordConfirmation, userEmail),
                     cancelButton: StringConstant.buttonDeny,
                     otherButtons: [StringConstant.buttonAllow]) { (_) in
            // Send reset password email
            Auth.auth().sendPasswordReset(withEmail: userEmail) { [weak self] (error) in
                guard let self = self else { return }
            
                guard let error = error as NSError? else {
                    // Reset password succeeded
                    self.presentErrorAlert(title: StringConstant.titleResetPassword,
                                           message: StringConstant.messageResetPasswordErrorSuccessfulAuth)
                    return
                }
                
                // Reset password failed
                let errorCode = AuthErrorCode(rawValue: error.code)
                self.handleAuthorizationError(of: errorCode)
            }
        }
    }
}
