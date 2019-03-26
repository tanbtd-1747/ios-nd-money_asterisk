//
//  AddTransactionViewController.swift
//  Money*
//
//  Created by tran.duc.tan on 3/26/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

final class AddTransactionViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private var walletContainerView: UIView!
    @IBOutlet private var nameContainerView: UIView!
    @IBOutlet private var amountContainerView: UIView!
    @IBOutlet private var typeContainerView: UIView!
    @IBOutlet private var timestampContainerView: UIView!
    @IBOutlet private var noteContainerView: UIView!
    @IBOutlet var walletNameLabel: UILabel!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var timestampLabel: UILabel!
    @IBOutlet var noteTextField: UITextField!
    
    // MARK: - Private functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
    
    private func configureSubviews() {
        title = Constant.sceneTitleAddTransaction
        
        [walletContainerView, nameContainerView, amountContainerView,
         typeContainerView, typeContainerView, timestampContainerView, noteContainerView].forEach { $0?.makeRounded() }
    }
}
