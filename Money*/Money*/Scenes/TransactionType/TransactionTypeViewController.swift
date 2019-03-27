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
    
    // MARK: - Properties
    private var types = [String]()
    private var expenseTypes = [String]()
    private var incomeTypes = [String]()
    weak var delegate: TransactionTypeViewControllerDelegate?
    var isEdittingTransaction = false
    
    // MARK: - Private functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
    
    private func configureSubviews() {
        title = Constant.sceneTitleTransactionType
        
        transactionTypeTableView.do {
            $0.dataSource = self
            $0.delegate = self
        }
        
        for transactionType in TransactionType.allCases {
            if transactionType.rawValue.contains("expense") {
                expenseTypes.append(transactionType.rawValue)
            } else if transactionType.rawValue.contains("income") {
                incomeTypes.append(transactionType.rawValue)
            }
        }
        types = expenseTypes
        transactionTypeTableView.reloadData()
    }
    
    // MARK: - IBActions
    @IBAction private func handleTransactionTypeSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        types = sender.selectedSegmentIndex == 0 ? expenseTypes : incomeTypes
        transactionTypeTableView.reloadData()
    }
}

// MARK: - TableView Data Source
extension TransactionTypeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.cellTransactionType, for: indexPath)
        cell.textLabel?.text = Constant.TransactionName[types[indexPath.row]]
        return cell
    }
}

// MARK: - TableView Delegate
extension TransactionTypeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(type: TransactionType(rawValue: types[indexPath.row]) ?? .update,
                            with: Constant.TransactionName[types[indexPath.row]] ?? "")
        performSegue(withIdentifier: isEdittingTransaction
            ? Identifier.segueUnwindToEditTransaction
            : Identifier.segueUnwindToAddTransaction,
                     sender: nil)
    }
}

// MARK: - TransactionTypeViewControllerDelegate Protocol
protocol TransactionTypeViewControllerDelegate: class {
    func didSelect(type: TransactionType, with name: String)
}
