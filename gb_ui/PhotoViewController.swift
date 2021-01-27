//
//  PhotoSceneViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 15.01.2021.
//

import UIKit

class PhotoViewController: UIViewController {

    var chosenPhoto: UIImage?
    var photos = [UIImage?]()
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var likeControl: LikeControl!
    
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let photo = chosenPhoto {
            image.image = photo
        }
        
        for (index, photo) in photos.enumerated() {
            if chosenPhoto == photo && index == photos.count - 1 {
                self.nextButton.isHidden = true
            }
            if chosenPhoto == photo && index == 0 {
                self.previousButton.isHidden = true
            }
        }
        
    }
    
    @IBAction func didDoubleTapOnImage(_ sender: UITapGestureRecognizer) {
        likeControl.isLiked.toggle()
    }
    
    @IBAction func previousPressed(_ sender: UIButton) {
        
        self.nextButton.isHidden = false
        
        for (index, photo) in photos.enumerated() {
            if chosenPhoto == photo {
                if index > 0 {
//                    self.image.image = photos[index - 1]
                    animateTransitionPrevious(fromImage: self.image, toImage: UIImageView(image: photos[index - 1]))
                    break
                }
            }
        }
        self.view.layoutIfNeeded()
        chosenPhoto = self.image.image
        
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        
        self.previousButton.isHidden = false
 
        for (index, photo) in photos.enumerated() {
            if index < photos.count - 1 {
                if chosenPhoto == photo {
//                    self.image.image = photos[index + 1]
                    animateTransitionNext(
                        fromImage: self.image, toImage: UIImageView(image: photos[index + 1]))

                    break
                }
            }
        }
        self.view.layoutIfNeeded()
        chosenPhoto = self.image.image
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

}
