//
//  WalletCollectionViewCell.swift
//  Money*
//
//  Created by tran.duc.tan on 3/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import Reusable

final class WalletCollectionViewCell: UICollectionViewCell, NibReusable {
    // MARK: - IBOutlets
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var iconContainerView: UIView!
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var balanceLabel: UILabel!
    
    // MARK: - Private functions
    override func awakeFromNib() {
        super.awakeFromNib()
        configureSubviews()
    }
    
    private func configureSubviews() {
        containerView.makeRoundedAndShadowed()
        iconContainerView.makeRounded()
    }
    
    func configure(for wallet: Wallet) {
        nameLabel.text = wallet.name
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        balanceLabel.text = formatter.string(for: wallet.balance) ?? ""
        
        switch wallet.type {
        case .cash:
            iconImageView.image = UIImage(named: "icon-wallet")
        case .creditCard:
            iconImageView.image = UIImage(named: "icon-creditcard")
        case .other:
            iconImageView.image = UIImage(named: "icon-wallet-other")
        }
    }
}
