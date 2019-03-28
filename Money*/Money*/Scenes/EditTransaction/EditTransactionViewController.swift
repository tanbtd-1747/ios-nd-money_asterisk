//
//  EditTransactionViewController.swift
//  Money*
//
//  Created by tran.duc.tan on 3/27/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

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
    }
}
