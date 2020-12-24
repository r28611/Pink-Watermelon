//
//  LoginViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 19.12.2020.
//

import UIKit

class LoginViewController: UIViewController {


    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keybordWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keybordWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    @IBAction func didTapButton(_ sender: UIButton) {

    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
            // Проверяем данные
            let checkResult = checkUserData()
            // Если данные не верны, покажем ошибку
            if !checkResult {
                showLoginError()
            }
            // Вернем результат
            return checkResult
        }
        
        func checkUserData() -> Bool {
            guard let login = userNameTextField.text, let password = userPasswordTextField.text else { return false }
            if login == "admin" && password == "123456" {
                return true
            } else {
                return false
            }
        }
        
        func showLoginError() {
            // Создаем контроллер
            let alter = UIAlertController(title: "Sorry", message: "Wrong username or password", preferredStyle: .alert)
            // Создаем кнопку для UIAlertController
            let action = UIAlertAction(title: "Try again", style: .cancel, handler: nil)
            // Добавляем кнопку на UIAlertController
            alter.addAction(action)
            // Показываем UIAlertController
            present(alter, animated: true, completion: nil)
        }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
