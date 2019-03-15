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
    }
    
    private func configureSubviews() {
        [emailContainerView,
         passwordContainerView,
         confirmPasswordContainerView].forEach { $0?.makeRounded() }
        
        [createButton,
         cancelButton].forEach { $0?.makeRoundedAndShadowed() }
    }
}
