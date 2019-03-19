//
//  WalletManagementViewController.swift
//  Money*
//
//  Created by tran.duc.tan on 3/19/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import Firebase

final class WalletManagementViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private var walletTableView: UITableView!
    
    // MARK: - Properties
    var wallets = [Wallet]()
    var user: User!
    
    // MARK: - Private functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Firestore.firestore().collection(user.email).addSnapshotListener { [unowned self] (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error fetching snapshot results")
                return
            }
            
            let models = snapshot.documents.map({ (document) -> Wallet in
                if let model = Wallet(snapshot: document) {
                    return model
                } else {
                    fatalError()
//                    return Wallet(name: "", type: "", balance: 0)
                }
            })
            
            self.wallets = models
            self.walletTableView.reloadData()
        }
    }
    
    private func configureSubviews() {
        title = Constant.sceneTitleWalletManagement
    }
}

// MARK: - TableView Data Source
extension WalletManagementViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wallets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.cellWallet, for: indexPath)
        let label = cell.viewWithTag(1) as? UILabel
        label?.text = wallets[indexPath.row].name
        return cell
    }
}
