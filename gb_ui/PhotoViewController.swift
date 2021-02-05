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
    
    var currentIndex: Int = 0
    var photos: [UIImage] = [UIImage]()
    var animator: UIViewPropertyAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        likeControl.set(colorDisliked: .gray,
                        iconDisliked: UIImage(systemName: "heart")!,
                        colorLiked: .systemPink,
                        iconLiked: UIImage(systemName: "heart.fill")!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        image.image = photos[currentIndex]
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(onPAn))
        self.view.addGestureRecognizer(pan)
        self.view.isUserInteractionEnabled = true
    }
    
    @IBAction func didDoubleTapOnImage(_ sender: UITapGestureRecognizer) {
        likeControl.isLiked.toggle()
    }
    
    private func changeImage(direction: Direction) {
        switch direction {
        case .next:
            if currentIndex < photos.count - 1 {
                animateTransition(view: self.image, toImage: photos[currentIndex + 1], direction: direction)
                currentIndex += 1
            }
        case .previous:
            if currentIndex > 0 {
                animateTransition(view: self.image, toImage: photos[currentIndex - 1], direction: direction)
                currentIndex -= 1
            }
        }
    }
    
    private enum Direction {
        case next, previous
    }
    
    private func animateTransition(view: UIImageView, toImage: UIImage, direction: Direction) {
        
        view.image = toImage
        
        var translation = CGAffineTransform()
        var scale = CGAffineTransform()
        switch direction {
        case .next:
            translation = CGAffineTransform(translationX: view.frame.width, y: 0)
            scale = CGAffineTransform(scaleX: 0.4, y: 0.4)
        case .previous:
            translation = CGAffineTransform(translationX: -view.frame.width, y: 0)
            scale = CGAffineTransform(scaleX: 1.4, y: 1.4)
        }
        
        let concatenatedTransform = scale.concatenating(translation)
        view.transform = concatenatedTransform
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
                        view.transform = .identity
                       },
                       completion: nil)
        
    }
    
    @objc func onPAn(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        
        switch recognizer.state {
        case .began:
            
            print(translation.x)
            animator = UIViewPropertyAnimator(duration: 1, curve: .easeIn, animations: {
                if translation.x > 0 && self.currentIndex > 0 {
                    self.image.transform = CGAffineTransform(translationX: self.image.frame.width, y: 0)
                } else if translation.x < 0  && self.currentIndex < self.photos.count - 1 {
                    self.image.transform = CGAffineTransform(translationX: -self.image.frame.width, y: 0)
                }
            })
            
            animator?.startAnimation()
        case .changed:
            animator.fractionComplete = abs(translation.x / 100)
        case .ended:
            // добавить отмену действия
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            if translation.x > 0 {
                changeImage(direction: .previous)
            } else {
                changeImage(direction: .next)
            }
        default:
            break
        }
    }

}
