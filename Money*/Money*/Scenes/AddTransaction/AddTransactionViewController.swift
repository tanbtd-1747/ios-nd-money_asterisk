//
//  AddTransactionViewController.swift
//  Money*
//
//  Created by tran.duc.tan on 3/26/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import Firebase

final class AddTransactionViewController: UIViewController {
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
    
    // MARK: - Properties
    var wallet: Wallet!
    private var transaction = Transaction()
    
    // MARK: - Private functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Identifier.segueFromAddTransactionToTransactionType:
            let transactionTypeViewController = segue.destination as? TransactionTypeViewController
            transactionTypeViewController?.delegate = self
        default:
            return
        }
    }
    
    private func configureSubviews() {
        title = Constant.sceneTitleAddTransaction
        
        [walletContainerView, nameContainerView, amountContainerView,
         typeContainerView, typeContainerView, timestampContainerView, noteContainerView].forEach { $0?.makeRounded() }
        
        typeLabel.text = Constant.TransactionName[transaction.type.rawValue]
        timestampDatePicker.maximumDate = Date()
        
        let tapOnTypeGesture = UITapGestureRecognizer(target: self, action: #selector(handleTransactionTypeTapped))
        typeContainerView.addGestureRecognizer(tapOnTypeGesture)
    }
    
    @objc private func handleTransactionTypeTapped() {
        performSegue(withIdentifier: Identifier.segueFromAddTransactionToTransactionType, sender: nil)
    }
    
    private func updateTransactionType(type: TransactionType, with name: String) {
        transaction.type = type
        typeLabel.text = name
    }
    
    // MARK: - IBActions
    @IBAction private func handleSaveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text,
            AccountValidator.validateNotEmpty(name) else {
                presentErrorAlert(title: Constant.titleError,
                                  message: Constant.messageTransactionErrorEmptyName)
                return
        }
        
        guard let amount = amountTextField.text,
            AccountValidator.validateIsNumber(amount) else {
                presentErrorAlert(title: Constant.titleError,
                                  message: Constant.messageTransactionErrorNotNumberBalance)
                return
        }
        
        transaction.name = name
        transaction.amount = UInt64(amount) ?? 0
        transaction.timestamp = Timestamp(date: timestampDatePicker.date)
        transaction.note = noteTextField.text ?? ""
        
        // TODO: Save data
        
        performSegue(withIdentifier: Identifier.segueUnwindToDashboard, sender: nil)
    }
    
    @IBAction func unwindSegueToAddTransaction(segue: UIStoryboardSegue) {
    }
}

// MARK: - TransactionTypeViewControllerDelegate
extension AddTransactionViewController: TransactionTypeViewControllerDelegate {
    func didSelect(type: TransactionType, with name: String) {
        updateTransactionType(type: type, with: name)
    }
}
