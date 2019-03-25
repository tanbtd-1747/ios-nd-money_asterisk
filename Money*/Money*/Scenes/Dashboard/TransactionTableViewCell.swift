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
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale.current
        amountLabel.text = numberFormatter.string(for: transaction.amount) ?? ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale.current
        dateLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(transaction.timestamp.seconds)))
        
        if let type = transaction.type.rawValue.split(separator: "-").first {
            typeImageView.image = UIImage(named: "icon-money-\(type)")
        }
        
        if let icon = transaction.type.rawValue.split(separator: "-").last {
            iconImageView.image = UIImage(named: "icon-\(icon)")
        }
    }
}
