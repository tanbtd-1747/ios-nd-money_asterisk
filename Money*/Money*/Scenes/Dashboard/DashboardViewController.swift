//
//  DashboardViewController.swift
//  Money*
//
//  Created by tran.duc.tan on 3/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import Firebase

final class DashboardViewController: UIViewController {
    // MARK: - Private properties
    private var user: User!
    
    // MARK: - Private functions
    override func viewDidLoad() {
        super.viewDidLoad()
        addAuthorizationListener()
    }
    
    private func addAuthorizationListener() {
        Auth.auth().addStateDidChangeListener { [weak self] (_, user) in
            guard let self = self else { return }
            
            guard let user = user else {
                return
            }
            self.user = User(auth: user)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Identifier.segueFromDashboardToUserSetting:
            let userSettingViewController = segue.destination as! UserSettingViewController
            userSettingViewController.user = user
        default:
            return
        }
    }
    
    // MARK: - IBActions
    @IBAction func handleUserButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: Identifier.segueFromDashboardToUserSetting, sender: nil)
    }
}
