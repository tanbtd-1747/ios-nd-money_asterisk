//
//  UIViewControllerAlertPresenting.swift
//  Money*
//
//  Created by tran.duc.tan on 3/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

protocol UIViewControllerAlertPresenting {
}

extension UIViewControllerAlertPresenting where Self: UIViewController {
    func presentAlert(title: String?,
                      message: String?,
                      style: UIAlertController.Style = .alert,
                      cancelButton: String?,
                      cancelAction: (() -> Void)? = nil,
                      otherButtons: [String]? = nil,
                      otherActions: ((Int) -> Void)? = nil) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        if let cancelButton = cancelButton {
            let cancelAction = UIAlertAction(title: cancelButton, style: .cancel) { (_) in
                cancelAction?()
            }
            alertViewController.addAction(cancelAction)
        }
        
        if let otherButtons = otherButtons {
            for (id, otherButton) in otherButtons.enumerated() {
                let otherAction = UIAlertAction(title: otherButton, style: .default) { (_) in
                    otherActions?(id)
                }
                alertViewController.addAction(otherAction)
            }
        }
        
        DispatchQueue.main.async {
            self.present(alertViewController, animated: true, completion: nil)
        }
    }
    
    func presentErrorAlert(title: String?, message: String?) {
        presentAlert(title: title, message: message, cancelButton: "OK")
    }
}
