//
//  LoginViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 19.12.2020.
//

import UIKit
import FirebaseAuth

final class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    private var listener: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(keybordWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keybordWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        listener = Auth.auth().addStateDidChangeListener({ [weak self] (auth, user) in
            guard user != nil else { return }
            
            self?.userNameTextField.text = ""
            self?.userPasswordTextField.text = ""
            
            self?.performSegue(withIdentifier: VKLoginViewController.segueIdentifier, sender: nil)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.tabBarVC {
            let tabBarController = segue.destination as? UITabBarController
            tabBarController?.selectedIndex = 3
        }
    }
    
    private func setupButtons() {
        let buttons = [self.loginButton, self.signupButton]
        for button in buttons {
            button?.layer.cornerRadius = (button?.frame.height)! / 4
        }
    }
    
    @objc func keybordWillShow (notification: Notification) {
        guard let kbSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.size.height, right: 0)
        scrollView.contentInset = insets
    }

    @objc func keybordWillHide (notification: Notification) {
        let insets = UIEdgeInsets.zero
        scrollView.contentInset = insets
    }
    
    @objc func hideKeyboard() {
            self.scrollView?.endEditing(true)
        }
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        guard let email = userNameTextField.text,
              let password = userPasswordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                print(error.localizedDescription)
                let alert = Alert()
                alert.showAlert(title: "Error", message: error.localizedDescription)
            } else {
                self?.performSegue(withIdentifier: VKLoginViewController.segueIdentifier, sender: self)
            }
        }
    }

}
