//
//  FriendsTableViewCell.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 01.01.2021.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: RoundedImageWithShadow!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var onlineStatus: UIImageView!
    
    var userModel: User? {
        didSet {
            setup()
        }
    }
    
    private func setup() {
        guard let userModel = userModel else { return }

        let name = userModel.name
        let surname = userModel.surname
        let city = userModel.city?.title ?? ""
        let avatarUrl = userModel.avatarURL
        let isOnline = userModel.isOnline
        
        avatar.image.load(url: URL(string: avatarUrl)!)
        nameLabel.text = name + " " + surname
        cityLabel.text = city
        onlineStatus.isHidden = !isOnline
    }
    
}
