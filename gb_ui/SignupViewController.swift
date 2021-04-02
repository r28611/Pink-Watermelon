//
//  SignupViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 25.12.2020.
//

import UIKit
import FirebaseAuth

final class SignupViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var cloudView: WatermelonLoadingView!
    @IBOutlet weak var form: UIStackView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.layer.cornerRadius = registerButton.frame.height / 4
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        cloudView.isHidden = true
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goButton(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self](result, error) in
            if let error = error {
                let alert = Alert()
                alert.showAlert(title: "Error", message: error.localizedDescription)
            } else {
                self?.cloudView.isHidden = false
                self?.animateFormDisappearing()
                self?.cloudView.setup()
                Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
//                    self?.performSegue(withIdentifier: "to_tabBar", sender: sender)
                    self?.dismiss(animated: true, completion: nil)
                }
            }
        }
        
    }
    
    func animateFormDisappearing() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = 0.5
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.fillMode = CAMediaTimingFillMode.both
        animation.isRemovedOnCompletion = false
        self.form.layer.add(animation, forKey: nil)
    }
    
}
