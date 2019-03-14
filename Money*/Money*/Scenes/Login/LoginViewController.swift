//
//  ViewController.swift
//  Money*
//
//  Created by tran.duc.tan on 3/13/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import FirebaseAuth

final class LoginViewController: UIViewController, UIViewControllerAlertPresenting {
    // MARK: - IBOutlets
    @IBOutlet private var containerEmail: UIView!
    @IBOutlet private var containerPassword: UIView!
    @IBOutlet private var tfUserEmail: UITextField!
    @IBOutlet private var tfUserPassword: UITextField!
    @IBOutlet private var btnLogin: UIButton!
    @IBOutlet private var btnSignup: UIButton!
    
    // MARK: - Private functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        addAuthorizationListener()
    }
    
    private func configureSubviews() {
        btnLogin.makeRoundedAndShadowed(cornerRadius: .cornerRadius,
                                        shadowColor: .richBlack,
                                        shadowRadius: .shadowRadius,
                                        shadowOffset: .shadowOffset,
                                        shadowOpacity: .shadowOpacity)
        btnSignup.makeRoundedAndShadowed(cornerRadius: .cornerRadius,
                                         shadowColor: .richBlack,
                                         shadowRadius: .shadowRadius,
                                         shadowOffset: .shadowOffset,
                                         shadowOpacity: .shadowOpacity)
        containerEmail.makeRounded(radius: .cornerRadius)
        containerPassword.makeRounded(radius: .cornerRadius)
    }
    
    private func addAuthorizationListener() {
        Auth.auth().addStateDidChangeListener { (_, user) in
            if user != nil {
                self.performSegue(withIdentifier: Identifier.segueFromLoginToDashboard, sender: nil)
                self.tfUserEmail.text = nil
                self.tfUserPassword.text = nil
            }
        }
    }

    // MARK: - IBActions
    @IBAction private func onBtnLoginTouchUpInside(_ sender: Any) {
        // Check if email or password is empty
        guard let userEmail = tfUserEmail.text, let userPassword = tfUserPassword.text,
            !userEmail.isEmpty, !userPassword.isEmpty else {
            presentErrorAlert(title: StringConstant.titleLoginError,
                              message: StringConstant.messageLoginErrorEmptyField)
            return
        }
        
        // Firebase Auth sign in
        Auth.auth().signIn(withEmail: userEmail,
                           password: userPassword) { (user, _) in
            //Sign in failed
            if user == nil {
                self.presentErrorAlert(title: StringConstant.titleLoginError,
                                       message: StringConstant.messageLoginErrorFailedAuth)
            }
        }
    }
    
    @IBAction private func onBtnSignupTouchUpInside(_ sender: Any) {
        performSegue(withIdentifier: Identifier.segueFromLoginToSignup, sender: nil)
    }
    
    @IBAction private func onBtnForgotPasswordTouchUpInside(_ sender: Any) {
        // Check if email is empty
        guard let userEmail = tfUserEmail.text, !userEmail.isEmpty else {
            presentErrorAlert(title: StringConstant.titleResetPasswordError,
                              message: StringConstant.messageResetPasswordErrorEmptyField)
            return
        }
        
        // Ask for confirmation to reset password
        presentAlert(title: StringConstant.titleResetPassword,
                     message: String(format: StringConstant.messageResetPasswordConfirmation, userEmail),
                     cancelButton: StringConstant.buttonResetPasswordDeny,
                     otherButtons: [StringConstant.buttonResetPasswordAllow]) { (_) in
            // Send reset password email
            Auth.auth().sendPasswordReset(withEmail: userEmail) { (error) in
                // Reset password failed
                guard error == nil else {
                    self.presentErrorAlert(title: StringConstant.titleResetPasswordError,
                                           message: StringConstant.messageResetPasswordErrorFailedAuth)
                    return
                }
                
                // Reset password succeeded
                self.presentErrorAlert(title: StringConstant.titleResetPassword,
                                       message: StringConstant.messageResetPasswordErrorSuccessfulAuth)
            }
        }
    }
}
