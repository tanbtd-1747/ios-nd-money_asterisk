//
//  SignupViewController.swift
//  Money*
//
//  Created by tran.duc.tan on 3/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

final class SignupViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private var emailContainerView: UIView!
    @IBOutlet private var passwordContainerView: UIView!
    @IBOutlet private var confirmPasswordContainerView: UIView!
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var confirmPasswordTextField: UITextField!
    @IBOutlet private var createButton: UIButton!
    @IBOutlet private var cancelButton: UIButton!
    
    // MARK: - Private functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureHideKeyboardWhenTappedOnBackground()
    }
    
    private func configureSubviews() {
        [emailContainerView,
         passwordContainerView,
         confirmPasswordContainerView].forEach { $0?.makeRounded() }
        
        [createButton,
         cancelButton].forEach { $0?.makeRoundedAndShadowed() }
    }
    
    // MARK: - IBActions
    @IBAction private func handleCreateButtonTouchUpInside(_ sender: Any) {
        // Check if email is empty
        guard let email = emailTextField.text,
            AccountValidator.validateNotEmpty(email) else {
            presentErrorAlert(title: Constant.titleSignupError,
                              message: Constant.messageErrorEmptyEmail)
            return
        }
        
        // Check if password is empty
        guard let password = passwordTextField.text,
            AccountValidator.validateNotEmpty(password) else {
                presentErrorAlert(title: Constant.titleSignupError,
                                  message: Constant.messageErrorEmptyPassword)
                return
        }
        
        // Check if confirm password is empty
        guard let confirmPassword = confirmPasswordTextField.text,
            AccountValidator.validateNotEmpty(confirmPassword) else {
                presentErrorAlert(title: Constant.titleSignupError,
                                  message: Constant.messageSignupErrorEmptyConfirmPassword)
                return
        }
        
        // Check if password is short
        guard AccountValidator.validatePasswordLength(password) else {
            presentErrorAlert(title: Constant.titleSignupError,
                              message: Constant.messageErrorShortPassword)
            return
        }
        
        // Check if confirm password matches with password
        guard AccountValidator.validatePasswordMatch(confirmPassword, password) else {
            presentErrorAlert(title: Constant.titleSignupError,
                              message: Constant.messageSignupErrorPasswordNotMatch)
            return
        }
        
        // TODO: Create Account
    }
    
    @IBAction private func handleCancelButtonTouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
