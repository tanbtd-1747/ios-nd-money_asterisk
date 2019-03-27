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
    
    // MARK: Properties
    private var types = [Int]()
    weak var delegate: WalletTypeViewControllerDelegate?
    var isEdittingWallet = false
    
    // MARK: - Private functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
    
    private func configureSubviews() {
        title = Constant.sceneTitleWalletType
        
        for walletType in WalletType.allCases {
            types.append(walletType.rawValue)
        }
        walletTypeTableView.reloadData()
    }
}

// MARK: - TableView Data Source
extension WalletTypeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.cellWalletType, for: indexPath)
        cell.textLabel?.text = Constant.WalletName[types[indexPath.row]]
        return cell
    }
}

// MARK: - TableView Delegate
extension WalletTypeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(type: WalletType(rawValue: indexPath.row) ?? .other,
                            with: Constant.WalletName[types[indexPath.row]] ?? "")
        performSegue(withIdentifier: isEdittingWallet
            ? Identifier.segueUnwindToEditWallet
            : Identifier.segueUnwindToAddWallet,
                     sender: nil)
    }
}

// MARK: - WalletTypeViewControllerDelegate Protocol
protocol WalletTypeViewControllerDelegate: class {
    func didSelect(type: WalletType, with name: String)
}
