//
//  СharacterPicker.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 06.01.2021.
//

import UIKit

class CharacterPicker: UIControl {

    var Chars: [String] = []
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
        for char in Chars {
            let button = UIButton(type: UIButton.ButtonType.system)
            button.setTitle(char, for: .normal)
            button.setTitleColor(.lightGray, for: .normal)
            button.setTitleColor(.white, for: .selected)
            button.addTarget(self, action: #selector(selectChar), for: .touchUpInside)
            buttons.append(button)
        }
        stackView = UIStackView(arrangedSubviews: buttons)
        addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fillEqually
    }
    
    @objc func selectChar(_ sender: UIButton) {
        
        guard let index = buttons.firstIndex(of: sender),
              let char: String? = Chars[index]
        else { return }
          
        selectedChar = char
    }
    
    private func updateSelectedChar() {
        for (index, button) in buttons.enumerated() {
            guard let char: String? = Chars[index] else { return }
            button.isSelected = char == selectedChar
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.frame = bounds
    }

}

