//
//  СharacterPicker.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 06.01.2021.
//

import UIKit

class CharacterPicker: UIControl {

    var chars: [String] = []
    private let maxCharsForUi = 15
    private var buttons: [UIButton] = []
    private var stackView: UIStackView!
    
    var selectedChar: String? = nil {
        didSet {
            updateSelectedChar()
            sendActions(for: .valueChanged)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUi()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUi()
    }
    
    func setupUi() {
        buttons.removeAll()
        
        if chars.count > self.maxCharsForUi {
            let step = Int(chars.count / maxCharsForUi)
            var array = [String]()
            for (index, _) in chars.enumerated() {
                if index % step == 0 {
                    array.append(chars[index])
                }
            }
            chars = array
        }
        
        for char in chars {
            let button = UIButton(type: UIButton.ButtonType.system)
            button.setTitle(char, for: .normal)
            button.setTitleColor(.lightGray, for: .normal)
            button.setTitleColor(.white, for: .selected)
            button.addTarget(self, action: #selector(selectChar), for: .touchUpInside)
            buttons.append(button)
        }
        
        if stackView != nil {
            stackView.removeFullyAllArrangedSubviews()
        }

        stackView = UIStackView(arrangedSubviews: buttons)
        stackView.frame = bounds
        addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fillEqually
    }
    
    @objc func selectChar(_ sender: UIButton) {
        
        if let index = buttons.firstIndex(of: sender) {
            selectedChar = chars[index]
        }

    }
    
    private func updateSelectedChar() {
        for (index, button) in buttons.enumerated() {
            let char = chars[index] 
            button.isSelected = char == selectedChar
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.frame = bounds
    }

}

// MARK: - Extension StackView

extension UIStackView {

    func removeFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }

    func removeFullyAllArrangedSubviews() {
        arrangedSubviews.forEach { (view) in
            removeFully(view: view)
        }
    }

}
