//
//  EditWalletViewController.swift
//  Money*
//
//  Created by tran.duc.tan on 3/20/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

final class EditWalletViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private var nameContainerView: UIView!
    @IBOutlet private var typeContainerView: UIView!
    @IBOutlet private var balanceContainerView: UIView!
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var typeLabel: UILabel!
    @IBOutlet private var balanceTextField: UITextField!
    @IBOutlet private var deleteButton: UIButton!
    
    // MARK: - Properties
    var wallet: Wallet!
    
    // MARK: - Private functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifier.segueFromEditWalletToWalletType {
            let walletTypeViewController = segue.destination as? WalletTypeViewController
            walletTypeViewController?.isEdittingWallet = true
            walletTypeViewController?.delegate = self
        }
    }
    
    private func configureSubviews() {
        title = Constant.sceneTitleEditWallet
        [nameContainerView, typeContainerView, balanceContainerView].forEach { $0?.makeRounded() }
        deleteButton.makeRoundedAndShadowed()
        
        nameTextField.text = wallet.name
        balanceTextField.text = "\(wallet.balance)"
        switch wallet.type {
        case .cash:
            typeLabel.text = Constant.nameWalletTypeCash
        case .creditCard:
            typeLabel.text = Constant.nameWalletTypeCreditCard
        case .other:
            typeLabel.text = Constant.nameOther
        }
        
        let tapOnTypeGesture = UITapGestureRecognizer(target: self, action: #selector(handleWalletTypeTapped))
        typeContainerView.addGestureRecognizer(tapOnTypeGesture)
    }
    
    @objc private func handleWalletTypeTapped() {
        performSegue(withIdentifier: Identifier.segueFromEditWalletToWalletType, sender: nil)
    }
    
    private func updateWalletType(type: WalletType, with name: String) {
        wallet.type = type
        typeLabel.text = name
    }
    
    private func updateData() {
        wallet.ref?.updateData(wallet.dictionary)
    }
    
    private func deleteData() {
        wallet.ref?.delete()
    }
    
    // MARK: - IBActions
    @IBAction private func handleSaveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text,
            AccountValidator.validateNotEmpty(name) else {
                presentErrorAlert(title: Constant.titleError,
                                  message: Constant.messageWalletErrorEmptyName)
                return
        }
        
        guard let balance = balanceTextField.text,
            AccountValidator.validateIsNumber(balance) else {
                presentErrorAlert(title: Constant.titleError,
                                  message: Constant.messageWalletErrorNotNumberBalance)
                return
        }
        
        wallet.name = name
        wallet.balance = UInt64(balance) ?? 0
        
        updateData()
        performSegue(withIdentifier: Identifier.segueUnwindToWalletManagement, sender: nil)
    }
    
    @IBAction private func handleDeleteButtonTouchUpInside(_ sender: Any) {
        deleteData()
        performSegue(withIdentifier: Identifier.segueUnwindToWalletManagement, sender: nil)
    }
    
    @IBAction func unwindSegueToEditWallet(segue: UIStoryboardSegue) {
    }
}

// MARK: - WalletTypeViewControllerDelegate
extension EditWalletViewController: WalletTypeViewControllerDelegate {
    func didSelect(type: WalletType, with name: String) {
        updateWalletType(type: type, with: name)
    }
}
