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
    
    @IBInspectable
    var cornerRadius: CGFloat = 2 {
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
        
        layer.cornerRadius = frame.width / cornerRadius
        layer.masksToBounds = false
    }
}
