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
    }
}
