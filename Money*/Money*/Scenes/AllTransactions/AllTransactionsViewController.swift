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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchTransactionData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Identifier.segueFromAllTransactionsToEditTransaction:
            let editTransactionViewController = segue.destination as? EditTransactionViewController
            
            guard let id = sender as? Int else {
                return
            }
            editTransactionViewController?.wallet = wallet
            editTransactionViewController?.transaction = transactions[id]
        default:
            return
        }
    }
    
    private func configureSubviews() {
        title = wallet.name
 
        transactionsTableView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.rowHeight = UITableView.automaticDimension
            $0.estimatedRowHeight = Constant.transactionCellHeight
            $0.register(cellType: TransactionDetailsTableViewCell.self)
        }
    }
    
    private func fetchTransactionData() {
        wallet.ref?
            .collection("transactions")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener(includeMetadataChanges: true) { [unowned self] (querySnapshot, _) in
                guard let snapshot = querySnapshot else {
                    self.presentErrorAlert(title: Constant.titleError, message: Constant.messageSnapshotError)
                    return
                }
                
                self.transactions = []
                for document in snapshot.documents {
                    if let transactionModel = Transaction(snapshot: document) {
                        self.transactions.append(transactionModel)
                    } else {
                        self.presentErrorAlert(title: Constant.titleError, message: Constant.messageDataError)
                        break
                    }
                }
                
                self.transactionsTableView.reloadData()
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
        cell.configure(for: transactions[indexPath.row])
        return cell
    }
}

// MARK: - UITableView Delegate
extension AllTransactionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: Identifier.segueFromAllTransactionsToEditTransaction, sender: indexPath.row)
    }
}
