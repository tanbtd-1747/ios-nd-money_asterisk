//
//  WalletTypeViewController.swift
//  Money*
//
//  Created by tran.duc.tan on 3/20/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

final class WalletTypeViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private var walletTypeTableView: UITableView!
    
    // MARK: - Private functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
    
    private func configureSubviews() {
        title = Constant.sceneTitleWalletType
    }
}

// MARK: - TableView Data Source
extension WalletTypeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.cellWalletType, for: indexPath)
        return cell
    }
}
