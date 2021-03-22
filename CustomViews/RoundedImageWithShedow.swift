//
//  Avatar.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 05.01.2021.
//

import UIKit

final class RoundedImageWithShadow: UIView {
    
    public var image: UIImageView!
    private let shedowColor = UIColor.black.cgColor
    private let imageBackgroundColor = UIColor.clear.cgColor
    
    var cornerRadius: CGFloat = 2 {
        didSet {
            layoutIfNeeded()
        }
    }
    
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        return recognizer
    }()
    
    @objc func onTap() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.85
        animation.toValue = 1
        animation.stiffness = 100
        animation.mass = 1
        animation.duration = 0.2
        animation.beginTime = CACurrentMediaTime()
        animation.fillMode = CAMediaTimingFillMode.backwards
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
        image.contentMode = .scaleAspectFill
        layer.backgroundColor = imageBackgroundColor
        
        layer.shadowColor = shedowColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 1)
        
        image.layer.cornerRadius = frame.width / cornerRadius
        image.layer.masksToBounds = true

    }
}

