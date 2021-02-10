//
//  LoadingView.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 21.01.2021.
//

import UIKit

class LoadingView: UIView {
    
    private var stackView: UIStackView!
    var firstDot = UIImageView()
    var secondDot = UIImageView()
    var thirdDot = UIImageView()
    var dots = [UIImageView]()
    
    override init(frame: CGRect) {
         super.init(frame: frame)
        
         self.setupView()
     }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupView()
    }
    
    func setupView() {
        dots = [firstDot, secondDot, thirdDot]
        for dot in dots {
            dot.image = UIImage(systemName: "circle.fill")
            dot.contentMode = .scaleAspectFit
            dot.tintColor = .systemPink
        }
        
        stackView = UIStackView(arrangedSubviews: dots)
        
        self.addSubview(stackView)
        
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    private func animateDot(dot: UIView, delay time: TimeInterval) {
        UIView.animate(withDuration: 0.8, delay: time, options: [.repeat, .autoreverse], animations: {
            dot.alpha = 0
        })

    }
    
    func animate() {
        animateDot(dot: firstDot, delay: 0)
        animateDot(dot: secondDot, delay: 0.2)
        animateDot(dot: thirdDot, delay: 0.4)
    }
}
