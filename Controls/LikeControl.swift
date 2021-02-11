//
//  LikeControl.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 06.01.2021.
//

import UIKit

class LikeControl: UIControl {

    private var stackView: UIStackView!
    private let button = UIButton(type: .system)
    private var imageForLiked: UIImage! = UIImage(systemName: "heart.fill")
    private var colorForLiked: UIColor! = .systemPink
    private var imageForDisliked: UIImage! = UIImage(systemName: "heart")
    private var colorForDisliked: UIColor! = .darkGray
    var counter: Int = 0 {
        didSet {
            setupView()
        }
    }
    var counterLabel = UILabel()
    
    var isLiked: Bool = false {
        didSet {
            self.sendActions(for: .valueChanged)
            if !oldValue {
                counter += 1
            } else {
                counter -= 1
            }
            self.setupView()
            animate()
        }
    }
    
    func set(colorDisliked: UIColor, iconDisliked: UIImage, colorLiked: UIColor, iconLiked: UIImage) {
        imageForDisliked = iconDisliked
        colorForDisliked = colorDisliked
        imageForLiked = iconLiked
        colorForLiked = colorLiked
        self.setupView()
    }
    
    func animate() {
        print("Tap Like")
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
        //разобраться почему не работет transition
//        UIView.transition(with: counterLabel,
//                          duration: 0.5,
//                          options: .transitionFlipFromRight,
//                          animations: {
//            self.counterLabel.text = String(self.counter)
//        })

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
//        stackView.distribution = .fillEqually
    }

    @objc func toogleIsLiked(_ sender: UIButton) {
        isLiked.toggle()
    }
    
}
