//
//  Avatar.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 05.01.2021.
//

import UIKit

class RoundedImage: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = true
        
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGestureRecognizer)

    }
    
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(onTap))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        return recognizer
    }()
    
    
    
    @objc func onTap() {
        print("TAP")
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.85
        animation.toValue = 1
        animation.stiffness = 100
        animation.mass = 1
        animation.duration = 0.2
        animation.beginTime = CACurrentMediaTime()
        animation.fillMode = CAMediaTimingFillMode.backwards
            
        self.layer.add(animation, forKey: nil)
    }
}

class Shedow: UIImageView {
    
   
    @IBInspectable
    var color: UIColor = UIColor.black {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    var opacity: Float = 0.5 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    var radius: CGFloat = 5 {
        didSet {
            setNeedsLayout()
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = CGSize.zero
        
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = false
    }
}
