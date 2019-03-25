//
//  TransactionTableViewCell.swift
//  Money*
//
//  Created by tran.duc.tan on 3/21/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import Reusable

final class TransactionTableViewCell: UITableViewCell, NibReusable {
    // MARK: - IBOutlets
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var typeImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var amountLabel: UILabel!
    
    // MARK: - Private functions
    override func awakeFromNib() {
        super.awakeFromNib()
        configureSubviews()
    }
    
    private func configureSubviews() {
        containerView.makeRounded()
    }
    
    func configure(for transaction: Transaction) {
        nameLabel.text = transaction.name
        amountLabel.text = transaction.amount.toDecimalString()
        dateLabel.text = transaction.timestamp.toDateString()
        
        if let type = transaction.type.rawValue.split(separator: "-").first {
            typeImageView.image = #imageLiteral(resourceName: "icon-money-\(type)")
            switch type {
            case "expense":
                amountLabel.textColor = .magicPotion
            case "income":
                amountLabel.textColor = .robinEggBlue
            default:
                amountLabel.textColor = .richBlack
            }
        }
        
        if let icon = transaction.type.rawValue.split(separator: "-").last {
            iconImageView.image = #imageLiteral(resourceName: "icon-\(icon)")
        }
    }
}
