//
//  SignupViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 25.12.2020.
//

import UIKit

final class SignupViewController: UIViewController {

    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var cloudView: WatermelonLoadingView!
    @IBOutlet weak var form: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goButton.layer.cornerRadius = goButton.frame.height / 4
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        cloudView.isHidden = true

        
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goButton(_ sender: UIButton) {
        cloudView.isHidden = false
        animateFormDisappearing()
        cloudView.setup()
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
            self.performSegue(withIdentifier: "to_tabBar", sender: sender)
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
