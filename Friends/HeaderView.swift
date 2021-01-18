//
//  HeaderView.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 18.01.2021.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var headerLabel: UILabel!
    
//    func configure(label: String) {
//        self.headerLabel.text = label
//        self.headerLabel.textColor = .black
//        self.backgroundColor = UIColor.systemPink
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.headerLabel.text = nil
    }
    
}
