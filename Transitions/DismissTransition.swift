//
//  DismissTransition.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 08.02.2021.
//

import UIKit

class DismissTransition: UIPercentDrivenInteractiveTransition {

    var viewController: UIViewController? {
        didSet {
            let recognizer = UIScreenEdgePanGestureRecognizer(target: self,
                                                              action: #selector(handleScreenEdgeGesture(_:)))
            recognizer.edges = [.bottom, .top]
            viewController?.view.addGestureRecognizer(recognizer)
        }
    }
    
    @objc func handleScreenEdgeGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            self.viewController?.dismiss(animated: true, completion: nil)
        default:
            break
        }
        
    }
}
