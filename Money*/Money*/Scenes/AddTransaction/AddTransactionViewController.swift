//
//  AddTransactionViewController.swift
//  Money*
//
//  Created by tran.duc.tan on 3/26/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import Firebase
import Then

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
    private var lastKeyboardOffset: CGFloat = 0
    
    // MARK: - Private functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureHideKeyboardWhenTappedOnBackground()
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
        view.endEditing(true)
        
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
        
        walletNameLabel.text = wallet.name
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
    
    private func saveData() {
        guard validateTransactionAmount() else {
            presentErrorAlert(title: Constant.titleError, message: Constant.messageTransactionErrorAmount)
            return
        }
        
        wallet.ref?
            .collection("transactions")
            .addDocument(data: transaction.dictionary, completion: { [weak self] (error) in
                guard error == nil else {
                    self?.presentErrorAlert(title: Constant.titleError, message: Constant.messageTransactionErrorSave)
                    return
                }
                self?.updateWalletBalance()
            })
    }
    
    private func updateWalletBalance() {
        var newBalance = wallet.balance
        if transaction.type.rawValue.contains("expense") {
            newBalance -= transaction.amount
        } else if transaction.type.rawValue.contains("income") {
            newBalance += transaction.amount
        }
        wallet.balance = newBalance
        wallet.ref?
            .updateData(["balance": newBalance], completion: { [weak self] (error) in
            guard error == nil else {
                self?.presentErrorAlert(title: Constant.titleError, message: Constant.messageTransactionErrorSave)
                return
            }
            self?.performSegue(withIdentifier: Identifier.segueUnwindToDashboard, sender: nil)
        })
    }
    
    private func validateTransactionAmount() -> Bool {
        guard transaction.type.rawValue.contains("expense"),
            transaction.amount > wallet.balance else {
            return true
        }
        return false
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
                                  message: Constant.messageTransactionErrorNotNumberAmount)
                return
        }

        transaction.do {
            $0.name = name
            $0.amount = UInt64(amount) ?? 0
            $0.timestamp = Timestamp(date: timestampDatePicker.date)
            $0.note = noteTextField.text ?? ""
        }
        
        saveData()
    }
    
    @IBAction func unwindSegueToAddTransaction(segue: UIStoryboardSegue) {
    }
}

// MARK: - Keyboard
extension AddTransactionViewController {
    @objc private func keyboardWillShow(notification: Notification) {
        lastKeyboardOffset = getKeyboardHeight(notification: notification)
        if nameTextField.isEditing {
            lastKeyboardOffset = nameContainerView.frame.origin.y
        } else if amountTextField.isEditing {
            lastKeyboardOffset = amountContainerView.frame.origin.y
        }
        view.frame.origin.y -= lastKeyboardOffset
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        view.frame.origin.y += lastKeyboardOffset
    }
    
    private func getKeyboardHeight(notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        return keyboardSize?.cgRectValue.height ?? 0
    }
}

// MARK: - TransactionTypeViewControllerDelegate
extension AddTransactionViewController: TransactionTypeViewControllerDelegate {
    func didSelect(type: TransactionType, with name: String) {
        updateTransactionType(type: type, with: name)
    }
}
