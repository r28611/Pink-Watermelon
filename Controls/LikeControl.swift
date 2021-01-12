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
    var counterLabel = UILabel()
    
    var isLiked: Bool = false {
        didSet {
            self.sendActions(for: .valueChanged)
            if !oldValue {
                counter += 1
            } else {
                counter -= 1
            }
            self.updateControl()
        }
    }
    var counter: Int = 0
    
    
    override init(frame: CGRect) {
         super.init(frame: frame)
        
         self.setupView()
     }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupView()
    }
    
    private func setupView() {
        
        button.setImage(UIImage(systemName: isLiked ? "heart.fill" : "heart"), for: .normal)
        button.tintColor = isLiked ? UIColor.systemPink : UIColor.black
        counterLabel.text = String(counter)
        counterLabel.textColor = isLiked ? UIColor.systemPink : UIColor.black
        button.addTarget(self, action: #selector(toogleIsLiked(_ :)), for: .touchUpInside)
        
        stackView = UIStackView(arrangedSubviews: [counterLabel, button])

        self.addSubview(stackView)

        stackView.spacing = 3
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
    }

    @objc func toogleIsLiked(_ sender: UIButton) {
        isLiked.toggle()
    }
    
    private func updateControl() {
        button.setImage(UIImage(systemName: isLiked ? "heart.fill" : "heart"), for: .normal)
        button.tintColor = isLiked ? UIColor.systemPink : UIColor.black
        counterLabel.textColor = isLiked ? UIColor.systemPink : UIColor.black
        counterLabel.text = String(counter)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
}
