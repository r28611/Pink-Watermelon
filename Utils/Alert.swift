//
//  Alert.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 21.03.2021.
//

import UIKit

class Alert: UIViewController {
    func showAlert(title: String? = nil,
                   message: String? = nil,
                   handler: ((UIAlertAction) -> Void)? = nil,
                   completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: completion)
    }
}
