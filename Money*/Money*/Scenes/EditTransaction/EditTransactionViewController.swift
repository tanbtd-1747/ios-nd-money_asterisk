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
    var walletBalanceBeforeTransaction: UInt64 = 0
    var keyboardAdjusted = false
    var lastKeyboardOffset: CGFloat = 0
    
    // MARK: - Private functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureHideKeyboardWhenTappedOnBackground()
        calculateWalletBalance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(keyboardWillShow(notification:)),
                         name: UIResponder.keyboardWillShowNotification,
                         object: nil)
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(keyboardWillHide(notification:)),
                         name: UIResponder.keyboardWillHideNotification,
                         object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default
            .removeObserver(self,
                            name: UIResponder.keyboardWillShowNotification,
                            object: nil)
        NotificationCenter.default
            .removeObserver(self,
                            name: UIResponder.keyboardWillHideNotification,
                            object: nil)
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
    
    private func calculateWalletBalance() {
        if transaction.type.rawValue.contains("expense") {
            walletBalanceBeforeTransaction = wallet.balance + transaction.amount
        } else if transaction.type.rawValue.contains("income") {
            walletBalanceBeforeTransaction = wallet.balance - transaction.amount
        }
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
    
    private func updateData() {
        guard validateTransactionAmount() else {
            presentErrorAlert(title: Constant.titleError, message: Constant.messageTransactionErrorAmount)
            return
        }
        
        transaction.ref?.updateData(transaction.dictionary, completion: { [weak self] (error) in
            guard error == nil else {
                self?.presentErrorAlert(title: Constant.titleError, message: Constant.messageTransactionUpdateError)
                return
            }
            self?.updateWalletBalance(isDeleted: false)
        })
    }
    
    private func deleteData() {
        transaction.ref?.delete(completion: { [weak self] (error) in
            guard error == nil else {
                self?.presentErrorAlert(title: Constant.titleError, message: Constant.messageTransactionDeleteError)
                return
            }
            self?.updateWalletBalance(isDeleted: true)
        })
    }
    
    private func updateWalletBalance(isDeleted: Bool) {
        var newBalance = walletBalanceBeforeTransaction
        if !isDeleted {
            if transaction.type.rawValue.contains("expense") {
                newBalance -= transaction.amount
            } else if transaction.type.rawValue.contains("income") {
                newBalance += transaction.amount
            }
        }
        wallet.balance = newBalance
        wallet.ref?
            .updateData(["balance": newBalance], completion: { [weak self] (error) in
                guard error == nil else {
                    self?.presentErrorAlert(title: Constant.titleError, message: Constant.messageTransactionErrorSave)
                    return
                }
                self?.performSegue(withIdentifier: Identifier.segueUnwindToAllTransactions, sender: nil)
            })
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
        
        updateData()
    }
    
    @IBAction func handleDeleteButtonTouchUpInside(_ sender: Any) {
        deleteData()
    }
    
    @IBAction func unwindSegueToEditTransaction(segue: UIStoryboardSegue) {
    }
}

// MARK: - Keyboard
extension EditTransactionViewController {
    @objc func keyboardWillShow(notification: Notification) {
        if keyboardAdjusted == false {
            lastKeyboardOffset = getKeyboardHeight(notification: notification)
            if nameTextField.isEditing {
                lastKeyboardOffset = nameTextField.frame.origin.y
            } else if amountTextField.isEditing {
                lastKeyboardOffset = amountTextField.frame.origin.y
            }
            view.frame.origin.y -= lastKeyboardOffset
            keyboardAdjusted = true
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if keyboardAdjusted == true {
            view.frame.origin.y += lastKeyboardOffset
            keyboardAdjusted = false
        }
    }
    
    func getKeyboardHeight(notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        return keyboardSize?.cgRectValue.height ?? 0
    }
}

// MARK: - TransactionTypeViewControllerDelegate
extension EditTransactionViewController: TransactionTypeViewControllerDelegate {
    func didSelect(type: TransactionType, with name: String) {
        updateTransactionType(type: type, with: name)
    }
}
