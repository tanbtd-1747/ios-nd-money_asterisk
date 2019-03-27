//
//  AddWalletViewController.swift
//  Money*
//
//  Created by tran.duc.tan on 3/20/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import Firebase
import Then

final class AddWalletViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private var nameContainerView: UIView!
    @IBOutlet private var typeContainerView: UIView!
    @IBOutlet private var balanceContainerView: UIView!
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var typeLabel: UILabel!
    @IBOutlet private var balanceTextField: UITextField!
    
    // MARK: - Properties
    var user: User!
    private var wallet = Wallet()
    
    // MARK: - Private functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Identifier.segueFromAddWalletToWalletType:
            let walletTypeViewController = segue.destination as? WalletTypeViewController
            walletTypeViewController?.delegate = self
        default:
            return
        }
    }
    
    private func configureSubviews() {
        title = Constant.sceneTitleAddWallet
        [nameContainerView, typeContainerView, balanceContainerView].forEach { $0?.makeRounded() }
        
        let tapOnTypeGesture = UITapGestureRecognizer(target: self, action: #selector(handleWalletTypeTapped))
        typeContainerView.addGestureRecognizer(tapOnTypeGesture)
    }
    
    @objc private func handleWalletTypeTapped() {
        performSegue(withIdentifier: Identifier.segueFromAddWalletToWalletType, sender: nil)
    }
    
    private func updateWalletType(type: WalletType, with name: String) {
        wallet.type = type
        typeLabel.text = name
    }
    
    private func saveData() {
        Firestore.firestore()
            .collection(user.email)
            .addDocument(data: wallet.dictionary) { [weak self] (error) in
                guard error == nil else {
                    self?.presentErrorAlert(title: Constant.titleError, message: Constant.messageWalletErrorSave)
                    return
                }
                self?.performSegue(withIdentifier: Identifier.segueUnwindToWalletManagement, sender: nil)
        }
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
        
        wallet.do {
            $0.name = name
            $0.balance = UInt64(balance) ?? 0
        }
        
        saveData()
    }
    
    @IBAction func unwindSegueToAddWallet(segue: UIStoryboardSegue) {
    }
}

// MARK: - WalletTypeViewControllerDelegate
extension AddWalletViewController: WalletTypeViewControllerDelegate {
    func didSelect(type: WalletType, with name: String) {
        updateWalletType(type: type, with: name)
    }
}
