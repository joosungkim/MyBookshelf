//
//  UIViewController + Extension.swift
//  MyBookshelf
//
//  Created by JS Kim on 2021/04/04.
//

import UIKit

extension UIViewController {
    func presentAlert(alertTitle: String, alertMessage: String, alertButtonTitle: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            alertController.modalPresentationStyle = .overFullScreen
            alertController.modalTransitionStyle = .crossDissolve
            self.present(alertController, animated: true)
        }
    }
}
