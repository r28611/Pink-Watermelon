//
//  PhotoSceneViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 15.01.2021.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var likeControl: LikeControl!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var currentIndex: Int = 0
    var photos: [UIImage] = [UIImage]()
    var animator: UIViewPropertyAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        image.image = photos[currentIndex]
        print("curentPhotoIndex = \(currentIndex)")
        

        if currentIndex == photos.count - 1 {
            self.nextButton.isHidden = true
        }
        if currentIndex == 0 {
            self.previousButton.isHidden = true
        }
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(onPAn))
        view.addGestureRecognizer(pan)
    }
    
    @IBAction func didDoubleTapOnImage(_ sender: UITapGestureRecognizer) {
        likeControl.isLiked.toggle()
    }
    
    @IBAction func previousPressed(_ sender: UIButton) {
        
        if currentIndex > 0 {
            animateTransitionPrevious(fromImage: self.image, toImage: UIImageView(image: photos[currentIndex - 1]))
            currentIndex -= 1
        }
        if currentIndex == photos.count - 1 {
            self.nextButton.isHidden = true
        } else {
            self.nextButton.isHidden = false
        }
        if currentIndex == 0 {
            self.previousButton.isHidden = true
        } else {
            self.previousButton.isHidden = false
        }

        self.view.layoutIfNeeded()
        
        
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        
        if currentIndex < photos.count - 1 {
            animateTransitionNext(fromImage: self.image, toImage: UIImageView(image: photos[currentIndex + 1]))
            currentIndex += 1
        }
        if currentIndex == photos.count - 1 {
            self.nextButton.isHidden = true
        } else {
            self.nextButton.isHidden = false
        }
        if currentIndex == 0 {
            self.previousButton.isHidden = true
        } else {
            self.previousButton.isHidden = false
        }
        
        self.view.layoutIfNeeded()
        
    }
    
    func animateTransitionPrevious(fromImage: UIImageView, toImage: UIImageView) {
        
        UIView.transition(with: fromImage,
                          duration: 0.5,
//                          options: .transitionFlipFromRight,
                          animations: {
                            fromImage.image = toImage.image
        })
        
        let translation = CGAffineTransform(translationX: -toImage.frame.width, y: 0)
        let scale = CGAffineTransform(scaleX: 1.4, y: 1.4)
        let concatenatedTransform = scale.concatenating(translation)
        fromImage.transform = concatenatedTransform
            
            UIView.animate(withDuration: 1,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: {
                            fromImage.transform = .identity
                           },
                           completion: nil)
        
    }
    
    func animateTransitionNext(fromImage: UIImageView, toImage: UIImageView) {
        
        UIView.transition(with: fromImage,
                          duration: 0.5,
//                          options: .transitionFlipFromRight,
                          animations: {
                            fromImage.image = toImage.image
        })
        
        let translation = CGAffineTransform(translationX: toImage.frame.width, y: 0)
        let scale = CGAffineTransform(scaleX: 0.4, y: 0.4)
        let concatenatedTransform = scale.concatenating(translation)
        fromImage.transform = concatenatedTransform
            
            UIView.animate(withDuration: 1,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: {
                            fromImage.transform = .identity
                           },
                           completion: nil)
        
    }
    
    @objc func onPAn(_ recognizer: UIPanGestureRecognizer) {
//        switch recognizer.state {
//        case .began:
//        case .ended:
//            animator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.5, animations: {
//
//            })
//        default:
//        }
    }

}
