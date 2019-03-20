//
//  AddWalletViewController.swift
//  Money*
//
//  Created by tran.duc.tan on 3/20/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

final class AddWalletViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private var nameContainerView: UIView!
    @IBOutlet private var typeContainerView: UIView!
    @IBOutlet private var balanceContainerView: UIView!
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var typeLabel: UILabel!
    @IBOutlet private var balanceTextField: UITextField!
    
    // MARK: - Private functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
    
    private func configureSubviews() {
        title = Constant.sceneTitleAddWallet
        [nameContainerView, typeContainerView, balanceContainerView].forEach { $0?.makeRounded() }
    }

}
