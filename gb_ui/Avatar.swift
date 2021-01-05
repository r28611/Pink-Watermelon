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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize.zero
        
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = false
    }
}
