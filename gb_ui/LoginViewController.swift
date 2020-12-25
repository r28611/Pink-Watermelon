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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "to_signup_view":
            if let destination = segue.destination as? SignupViewController {
                destination.textForLabel = userNameTextField.text!
            }
        case "to_tabBarController":
//             какой таб будет отображаться при загрузке tabbarcontroller
//            let tabBarController = segue.destination as? UITabBarController
//            tabBarController?.selectedIndex = 2
            if let destinations = segue.destination as? UITabBarController {
            let vc = destinations.viewControllers![2] as! ProfileViewController
            vc.textForUsernameLabel = userNameTextField.text!
            }
        default:
            break
        }
    }
    
   
    /*
    //проверка на админа
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let checkResult = checkUserData()
        if identifier == "to_tabBarController" {
            if !checkResult {
                showLoginError()
            }
        }
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
        let alter = UIAlertController(title: "Sorry", message: "Wrong username or password", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alter.addAction(action)
        present(alter, animated: true, completion: nil)
    }
*/
    
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
        performSegue(withIdentifier: "to_tabBarController", sender: self)
    }
    
    @IBAction func didTapSignupButton(_ sender: UIButton) {
    }
    
    @IBAction func unwindSegueDidTap (_ segue: UIStoryboardSegue) {
        
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
