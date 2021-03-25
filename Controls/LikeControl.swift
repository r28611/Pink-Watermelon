//
//  LikeControl.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 06.01.2021.
//

import UIKit

final class LikeControl: UIControl {

    private var stackView: UIStackView!
    private var counterLabel = UILabel()
    private let button = UIButton(type: .system)
    private var imageForLiked: UIImage! = Constants.likedImage
    private var colorForLiked: UIColor! = .systemPink
    private var imageForDisliked: UIImage! = Constants.unlikedImage
    private var colorForDisliked: UIColor! = .darkGray
    var counter: Int = 0 {
        didSet {
            setupView()
        }
    }
    
    var isLiked: Bool = false {
        didSet {
            setupView()
        }
    }
    
    func set(colorDisliked: UIColor, iconDisliked: UIImage, colorLiked: UIColor, iconLiked: UIImage) {
        imageForDisliked = iconDisliked
        colorForDisliked = colorDisliked
        imageForLiked = iconLiked
        colorForLiked = colorLiked
        self.setupView()
    }
    
    private func animate() {
        if isLiked {
            UIView.animate(withDuration: 0.15, animations: {
                self.button.transform = .init(scaleX: 1.1, y: 1.1)
            }, completion: { _ in
                self.button.transform = .identity
            })
        } else {
            UIView.animate(withDuration: 0.15, animations: {
                self.button.transform = .init(scaleX: 0.9, y: 0.9)
                    }, completion: { _ in
                        self.button.transform = .identity
                    })
        }
        
        UIView.animate(withDuration: 0.1, animations: {
                self.counterLabel.frame.origin.x -= 5
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
     }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    private func setupView() {
        
        button.setImage(isLiked ? imageForLiked : imageForDisliked, for: .normal)
        button.tintColor = isLiked ? colorForLiked : colorForDisliked
        counterLabel.text = String(counter)
        counterLabel.textColor = isLiked ? colorForLiked : colorForDisliked
        button.addTarget(self, action: #selector(toogleIsLiked(_ :)), for: .touchUpInside)
        
        stackView = UIStackView(arrangedSubviews: [button, counterLabel])
        stackView.frame = bounds
        self.addSubview(stackView)

        stackView.spacing = 3
        stackView.axis = .horizontal
        stackView.alignment = .trailing
    }

    @objc func toogleIsLiked(_ sender: UIButton) {
        isLiked.toggle()
        //реализовать на api
    }
    
}
