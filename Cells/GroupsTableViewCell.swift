//
//  GroupsTableViewCell.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 04.01.2021.
//

import UIKit

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
        let avatarUrl = groupModel.avatar
        let members = groupModel.members.value ?? 0
        
        avatar.image.load(url: URL(string: avatarUrl)!)
        nameLabel.text = name
        subscribeLabel?.text = isMember == 0 ? "your group" : "Subscribe"
        subscribeLabel?.tintColor = isMember == 0 ? .black : .systemPink
        membersCountLabel?.text = "\(members) members"
    }
}
