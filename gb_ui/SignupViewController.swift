//
//  SignupViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 25.12.2020.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet private weak var label: UILabel!

    @IBOutlet weak var loadingView: LoadingView!
    
    public var textForLabel: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = textForLabel
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        for _ in 1...10 {
            
            loadingView.animate()
        }
        
       
            
        
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
