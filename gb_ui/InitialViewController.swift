//
//  InitialViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 19.12.2020.
//

import UIKit

final class InitialViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var loadingView: WatermelonLoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.isHidden = true
        loginButton.layer.cornerRadius = loginButton.frame.height / 4

    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        self.loadingView.isHidden = false
        self.loadingView.setup()
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { [weak self] timer in
            self?.performSegue(withIdentifier: VKLoginViewController.segueIdentifier, sender: self)
        }

    }
    
}
