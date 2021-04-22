//
//  HeaderView.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 18.01.2021.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var headerLabel: UILabel!
    var corners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner ]
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.headerLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.tintColor = UIColor.systemPink.withAlphaComponent(0.3)
        layer.cornerRadius = frame.height / 2
        layer.maskedCorners = corners
        layer.masksToBounds = true
    }
    
}
