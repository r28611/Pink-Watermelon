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
    var photos = [Photo]()
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
        
        let currentPhoto = photos[currentIndex]
        if let url = currentPhoto.sizes.last?.url {
            image.load(url: URL(string: url)!)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapOnImage))
        tap.numberOfTapsRequired = 2
        image.addGestureRecognizer(tap)
        image.isUserInteractionEnabled = true
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(onPan))
        self.view.addGestureRecognizer(pan)
        self.view.isUserInteractionEnabled = true
    }
    
    @IBAction func dismissDidTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func changeImage(direction: Direction) {
        switch direction {
        case .next:
            if currentIndex < photos.count - 1 {
//                animateTransition(view: self.image, toImage: photos[currentIndex + 1], direction: direction)
                currentIndex += 1
            }
        case .previous:
            if currentIndex > 0 {
//               animateTransition(view: self.image, toImage: photos[currentIndex - 1], direction: direction)
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
    
    // MARK: Tap function
    
    @objc func doubleTapOnImage() {
        self.likeControl.isLiked.toggle()
    }
    
    // MARK: Pan function
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        
        if abs(translation.y) > abs(translation.x) {
            switch recognizer.state {
            case .began:
                animator = UIViewPropertyAnimator(duration: 1, curve: .easeIn, animations: {
                    if translation.y > 0 {
                        self.image.transform = CGAffineTransform(translationX: 0, y: self.image.frame.height)
                        
                    } else if translation.y < 0 {
                        self.image.transform = CGAffineTransform(translationX: 0, y: -self.image.frame.height)
                    }
                })
                animator?.startAnimation()
            case .changed:
                animator.fractionComplete = abs(translation.y / 100)
            case .ended:
                animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                dismiss(animated: true, completion: nil)
            default:
                break
            }
        }
        
        switch recognizer.state {
        case .began:
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
