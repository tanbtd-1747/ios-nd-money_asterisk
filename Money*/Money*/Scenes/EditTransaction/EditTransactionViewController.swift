//
//  EditTransactionViewController.swift
//  Money*
//
//  Created by tran.duc.tan on 3/27/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import Firebase

final class EditTransactionViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private var walletContainerView: UIView!
    @IBOutlet private var nameContainerView: UIView!
    @IBOutlet private var amountContainerView: UIView!
    @IBOutlet private var typeContainerView: UIView!
    @IBOutlet private var timestampContainerView: UIView!
    @IBOutlet private var noteContainerView: UIView!
    @IBOutlet private var walletNameLabel: UILabel!
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var amountTextField: UITextField!
    @IBOutlet private var typeLabel: UILabel!
    @IBOutlet private var timestampDatePicker: UIDatePicker!
    @IBOutlet private var noteTextField: UITextField!
    @IBOutlet private var deleteButton: UIButton!
    
    // MARK: - Properties
    var wallet: Wallet!
    var transaction: Transaction!
    
    // MARK: - Private functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Identifier.segueFromEditTransactionToTransactionType:
            let transactionTypeViewController = segue.destination as? TransactionTypeViewController
            transactionTypeViewController?.isEdittingTransaction = true
            transactionTypeViewController?.delegate = self
        default:
            return
        }
    }
    
    private func configureSubviews() {
        title = Constant.sceneTitleEditTransaction
        
        [walletContainerView, nameContainerView, amountContainerView,
         typeContainerView, typeContainerView, timestampContainerView, noteContainerView].forEach { $0?.makeRounded() }
        deleteButton.makeRoundedAndShadowed()
        
        walletNameLabel.text = wallet.name
        typeLabel.text = Constant.TransactionName[transaction.type.rawValue]
        nameTextField.text = transaction.name
        amountTextField.text = "\(transaction.amount)"
        noteTextField.text = transaction.note
        timestampDatePicker.date = Date(timeIntervalSince1970: TimeInterval(exactly: transaction.timestamp.seconds)
            ?? TimeInterval())
        timestampDatePicker.maximumDate = Date()
        
        let tapOnTypeGesture = UITapGestureRecognizer(target: self, action: #selector(handleTransactionTypeTapped))
        typeContainerView.addGestureRecognizer(tapOnTypeGesture)
    }
    
    @objc private func handleTransactionTypeTapped() {
        performSegue(withIdentifier: Identifier.segueFromEditTransactionToTransactionType, sender: nil)
    }
    
    private func updateTransactionType(type: TransactionType, with name: String) {
        transaction.type = type
        typeLabel.text = name
    }
    
    private func validateTransactionAmount() -> Bool {
        guard transaction.type.rawValue.contains("expense"),
            transaction.amount > wallet.balance else {
                return true
        }
        return false
    }
    
    // MARK: - IBActions
    @IBAction func handleSaveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text,
            AccountValidator.validateNotEmpty(name) else {
                presentErrorAlert(title: Constant.titleError,
                                  message: Constant.messageTransactionErrorEmptyName)
                return
        }
        
        guard let amount = amountTextField.text,
            AccountValidator.validateIsNumber(amount) else {
                presentErrorAlert(title: Constant.titleError,
                                  message: Constant.messageTransactionErrorNotNumberAmount)
                return
        }
        
        transaction.do {
            $0.name = name
            $0.amount = UInt64(amount) ?? 0
            $0.timestamp = Timestamp(date: timestampDatePicker.date)
            $0.note = noteTextField.text ?? ""
        }
        
        // TODO: Save transaction
    }
    
    @IBAction func handleDeleteButtonTouchUpInside(_ sender: Any) {
        // TODO: Delete transaction
    }
    
    @IBAction func unwindSegueToEditTransaction(segue: UIStoryboardSegue) {
    }
}

// MARK: - TransactionTypeViewControllerDelegate
extension EditTransactionViewController: TransactionTypeViewControllerDelegate {
    func didSelect(type: TransactionType, with name: String) {
        updateTransactionType(type: type, with: name)
    }
}
