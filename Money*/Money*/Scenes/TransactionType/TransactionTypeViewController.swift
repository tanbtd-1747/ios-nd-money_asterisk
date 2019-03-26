//
//  TransactionTypeViewController.swift
//  Money*
//
//  Created by tran.duc.tan on 3/26/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import Then

final class TransactionTypeViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private var transactionTypeTableView: UITableView!
    
    // MARK: - Private functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
    
    private func configureSubviews() {
        transactionTypeTableView.do {
            $0.dataSource = self
            $0.delegate = self
        }
    }
}

// MARK: - TableView Data Source
extension TransactionTypeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - TableView Delegate
extension TransactionTypeViewController: UITableViewDelegate {
}
