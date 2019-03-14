//
//  ViewController.swift
//  Money*
//
//  Created by tran.duc.tan on 3/13/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    
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

}
