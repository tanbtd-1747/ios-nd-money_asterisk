//
//  AllTransactionsViewController.swift
//  Money*
//
//  Created by tran.duc.tan on 3/27/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import Then
import Reusable

final class AllTransactionsViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private var transactionsTableView: UITableView!
    
    // MARK: - Properties
    var wallet: Wallet!
    private var transactions = [Transaction]()
    
    // MARK: - Private functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
    
    private func configureSubviews() {
        transactionsTableView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.rowHeight = UITableView.automaticDimension
            $0.estimatedRowHeight = Constant.transactionCellHeight
            $0.register(cellType: TransactionDetailsTableViewCell.self)
        }
    }
}

// MARK: - UITableView Data Source
extension AllTransactionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as TransactionDetailsTableViewCell
        return cell
    }
}

// MARK: - UITableView Delegate
extension AllTransactionsViewController: UITableViewDelegate {
}
