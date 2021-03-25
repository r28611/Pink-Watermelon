//
//  VKLoginViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 11.02.2021.
//

import UIKit
import WebKit

final class VKLoginViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.load(URLRequest(url: Constants.vkAuthViewRequest.url!))
    }
}

extension VKLoginViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        print(params)
        
        guard let token = params["access_token"],
              let userIdString = params["user_id"],
              let userId = Int(userIdString) else {
            decisionHandler(.allow)
            return
        }
        
        print(token)
        Session.shared.token = token
        Session.shared.userId = userId
        
        decisionHandler(.cancel)
        performSegue(withIdentifier: Constants.VKtabBarVC, sender: self)
    }
}
