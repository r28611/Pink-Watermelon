//
//  GroupsTableViewCell.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 04.01.2021.
//

import UIKit
import RealmSwift

class GroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: RoundedImageWithShadow!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subscribeLabel: UILabel!
    @IBOutlet weak var membersCountLabel: UILabel!
    
    var groupModel: Group? {
        didSet {
            setup()
        }
    }
    
    private func setup() {
        guard let groupModel = groupModel else { return }

        let name = groupModel.name
        let isMember = groupModel.isMember
        let members = groupModel.members
        
        self.backgroundColor = avatar.image.image?.findAverageColor(algorithm: .simple)
        nameLabel.text = name
        nameLabel.numberOfLines = nameLabel.calculateMaxLines()
        
        subscribeLabel?.text = isMember == 1 ? "✅" : "Subscribe"
        subscribeLabel?.tintColor = isMember == 1 ? .black : .systemPink
        membersCountLabel?.text = "\(members) members" 

    }
}
