//
//  ProfileViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 25.12.2020.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet private weak var usernameLabel: UILabel!
    public var textForUsernameLabel: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = "Hello again, dear \(textForUsernameLabel!)"
        
         
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func didTapLogOut(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
