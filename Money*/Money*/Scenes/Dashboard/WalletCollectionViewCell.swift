//
//  WalletCollectionViewCell.swift
//  Money*
//
//  Created by tran.duc.tan on 3/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

final class WalletCollectionViewCell: UICollectionViewCell {
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
}
