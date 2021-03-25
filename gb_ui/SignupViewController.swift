//
//  SignupViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 25.12.2020.
//

import UIKit

final class SignupViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var cloudView: WatermelonLoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        cloudView.setup()
        welcomeLabel.text = "Here will be authorization form soon! Stay tuned for more fun!"
        welcomeLabel.numberOfLines = welcomeLabel.calculateMaxLines()
        welcomeLabel.textColor = Constants.greenColor
    }
    

    @IBAction func closeButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
