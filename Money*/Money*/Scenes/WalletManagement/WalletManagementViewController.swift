//
//  WalletManagementViewController.swift
//  Money*
//
//  Created by tran.duc.tan on 3/19/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

final class WalletManagementViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var walletTableView: UITableView!
    
    // MARK: - Private functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
    
    private func configureSubviews() {
        title = Constant.sceneTitleWalletManagement
    }
}

// MARK: - TableView Data Source
extension WalletManagementViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.cellWallet, for: indexPath)
        return cell
    }
}
