//
//  FriendsTableViewCell.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 01.01.2021.
//

import UIKit
import RealmSwift

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
        let city = userModel.city?.title
        let avatarURL = userModel.avatarURL
        let avatarData = userModel.avatarData
        let isOnline = userModel.isOnline
        
        if let data = avatarData {
            avatar.image.image = UIImage(data: data)
        } else {
            avatar.image.getData(from: avatarURL) { (data) in
                DispatchQueue.main.async {
                    self.avatar.image.image = UIImage(data: data)
                    let realm = RealmManager.shared
                    try? realm?.update {
                        userModel.avatarData = data
                    }
                }
            }
        }
        
        nameLabel.text = name + " " + surname
        cityLabel.text = city
        onlineStatus.isHidden = !isOnline
    }
    
}
