//
//  HeaderView.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 18.01.2021.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var headerLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.headerLabel.text = nil
    }
    
}
