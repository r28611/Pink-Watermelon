//
//  Avatar.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 05.01.2021.
//

import UIKit

class RoundedImageWithShadow: UIView {
    
    public var image: UIImageView!
    
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
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
        //разобраться зачем это
//        animation.isRemovedOnCompletion = true
        layer.add(animation, forKey: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addImage()
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addImage()
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    func addImage() {
        image = UIImageView(frame: frame)
        addSubview(image)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        image.frame = bounds
        layer.backgroundColor = UIColor.clear.cgColor
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 1)
        
        image.layer.cornerRadius = frame.width / 2
        image.layer.masksToBounds = true

//        self.isUserInteractionEnabled = true

    }
}

