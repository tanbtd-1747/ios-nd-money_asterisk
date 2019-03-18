//
//  UserSettingViewController.swift
//  Money*
//
//  Created by tran.duc.tan on 3/15/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

final class UserSettingViewController: UITableViewController {
    // MARK: - IBOutlets
    @IBOutlet private var notificationTimeLabel: UILabel!
    
    // MARK: - Private properties
    var user: User!
    
    // MARK: - Private functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
    
    private func configureSubviews() {
        tableView.backgroundView = GradientView()
        title = user.email
    }
}
